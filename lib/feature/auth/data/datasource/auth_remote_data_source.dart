import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String name,
    required String spcialization,
  });
  Future<UserModel> signUpCompany({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String companyName,
  });
  Future<void> forgetPassword(String email);
  Future<void> verifyEmail();
  Future<UserModel> getCurrentUser();
  Future<void> signOut();
  Future<bool> checkEmailverfied();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });
  final String userCollection = AppConstatnce.userCollection;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final User user = userCredential.user!;

      final DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection(userCollection)
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw const ServerException(
          'بيانات المستخدم غير موجودة في قاعدة البيانات',
        );
      }

      return UserModel.fromSnapshot(doc, user);
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseError(e.code));
    } on EmailNotVerifiedException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseError(e.code));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpCompany({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String companyName,
  }) async {
    try {
      // 1. إنشاء المستخدم في Auth
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final User user = userCredential.user!;

      // 2. إنشاء UserModel
      final UserModel userModel = UserModel(
        isEmailVerified: user.emailVerified,
        role: AppRoles.company,
        uid: user.uid,
        email: email,
        name: name,
        phone: phone,
        companyName: companyName,
      );

      await firestore
          .collection(userCollection)
          .doc(user.uid)
          .set(userModel.toDocument());

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseError(e.code)); // دالة الخطأ السابقة
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String name,
    required String spcialization,
  }) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user!;

      final UserModel newModel = UserModel(
        isEmailVerified: user.emailVerified,
        uid: user.uid,
        name: name,
        email: email,
        role: AppRoles.user,
        specialization: spcialization,
      );

      await firestore
          .collection(userCollection)
          .doc(user.uid)
          .set(newModel.toDocument());

      return newModel;
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseError(e.code)); // دالة الخطأ السابقة
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await firebaseAuth.setLanguageCode("ar");
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseError(e.code));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> verifyEmail() async {
    try {
      final User? user = firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await firebaseAuth.setLanguageCode("ar");
        await user.sendEmailVerification();
      } else {
        throw const ServerException(
          "المستخدم غير موجود أو البريد الإلكتروني تم التحقق منه بالفعل.",
        );
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(_mapFirebaseError(e.code));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final User? user = firebaseAuth.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection(userCollection)
          .doc(user.uid)
          .get();

      return UserModel.fromSnapshot(doc, user);
    } else {
      throw const ServerException("لا يوجد مستخدم مسجل حالياً.");
    }
  }

  @override
  Future<bool> checkEmailverfied() async {
    final User? user = firebaseAuth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      // أخطاء تسجيل الدخول
      case 'user-not-found':
        return 'لا يوجد مستخدم بهذا البريد الإلكتروني.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة.';
      case 'invalid-credential': // أحياناً تظهر بدلاً من wrong-password في النسخ الجديدة
        return 'بيانات الدخول غير صحيحة.';

      // أخطاء إنشاء الحساب
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً.';
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة.';

      // أخطاء عامة وأمان
      case 'operation-not-allowed':
        return 'هذه العملية غير مفعلة حالياً.';
      case 'user-disabled':
        return 'تم تعطيل هذا الحساب من قبل الإدارة.';
      case 'too-many-requests':
        return 'تم حظر الطلبات مؤقتاً بسبب نشاط غير معتاد، حاول لاحقاً.';

      // أخطاء الشبكة (أحياناً تأتي ككود من فايربيس)
      case 'network-request-failed':
        return 'فشل الاتصال بالإنترنت، يرجى التحقق من الشبكة.';

      default:
        return 'حدث خطأ غير معروف: $code';
    }
  }
}
