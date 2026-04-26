import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsersByRole(String role);
  Future<void> deleteUser(String userId);
  Future<void> updateUserRole(String userId, String newRole);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  UserRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<List<UserModel>> getAllUsersByRole(String role) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection(AppConstatnce.userCollection)
          .where('role', isEqualTo: role)
          .get();

      return snapshot.docs
          .map(
            (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
                UserModel.fromJsion(doc),
          )
          .toList();
    } on FirebaseException catch (e) {
      throw ServerException(_handleFirebaseException(e));
    } catch (e) {
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  String _handleFirebaseException(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'ليس لديك الصلاحية للوصول إلى هذه البيانات.';
      case 'unavailable':
        return 'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.';
      case 'not-found':
        return 'لم يتم العثور على البيانات المطلوبة.';
      default:
        return 'حدث خطأ في الخادم: ${exception.message}';
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await firestore
          .collection(AppConstatnce.userCollection)
          .doc(userId)
          .delete();
    } on FirebaseException catch (e) {
      throw ServerException(_handleFirebaseException(e));
    } catch (e) {
      throw ServerException('حدث خطأ أثناء الحذف: ${e.toString()}');
    }
  }

  @override
  Future<void> updateUserRole(String userId, String newRole) async {
    try {
      await firestore
          .collection(AppConstatnce.userCollection)
          .doc(userId)
          .update(<Object, Object?>{'role': newRole});
    } on FirebaseException catch (e) {
      throw ServerException(_handleFirebaseException(e));
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تحديث الدور: ${e.toString()}');
    }
  }
}
