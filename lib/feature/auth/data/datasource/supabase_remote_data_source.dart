import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/utils/app_constatnce.dart';
import 'package:graduation_management_idea_system/core/utils/app_role.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
// تأكد من المسار الصحيح للواجهة

abstract class AuthSupabaseRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String spcialization,
  });
  Future<String> signUpCompany({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String companyName,
  });
  Future<void> verifyPasswordResetOtp({
    required String email,
    required String otp,
  });

  Future<void> updatePassword(String newPassword);
  Future<void> forgetPassword(String email);
  Future<UserModel> verifyOtp({required String email, required String otp});

  Future<void> resendVerificationCode(String email);
  Future<UserModel> getCurrentUser();
  Future<void> signOut();
  Future<bool> checkEmailverfied();
}

class SupabaseAuthDataSourceImpl implements AuthSupabaseRemoteDataSource {
  final SupabaseClient supabase;

  SupabaseAuthDataSourceImpl({required this.supabase});

  final String _profilesTable = AppConstatnce.userCollection;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final authResponse = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw const ServerException('فشل تسجيل الدخول، لم يتم إرجاع المستخدم.');
      }

      // final UserResponse latestResponse = await supabase.auth.getUser();
      // final User? latestUser = latestResponse.user;

      // if (latestUser == null) {
      //   throw const ServerException(
      //     'حدث خطأ غير متوقع في جلب بيانات المستخدم.',
      //   );
      // }

      return await _getUserProfile(authResponse.user!);
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String spcialization,
  }) async {
    try {
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'role': AppRoles.user,
          'specialization': spcialization,
        },
      );

      if (authResponse.user == null) {
        throw const ServerException('فشل إنشاء الحساب، لم يتم إرجاع المستخدم.');
      }

      return authResponse.user!.email!;
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<String> signUpCompany({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String companyName,
  }) async {
    try {
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'role': AppRoles.company,
          'phone': phone,
          'external_name': companyName,
        },
      );

      if (authResponse.user == null) {
        throw const ServerException(
          'فشل إنشاء حساب الشركة، لم يتم إرجاع المستخدم.',
        );
      }
      return authResponse.user!.email!;
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تسجيل الخروج: ${e.toString()}');
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
    } on SocketException catch (e, stackTrace) {
      log('==============================');
      log('❌ SocketException');
      log('📌 Error: $e');
      log('📍 StackTrace: $stackTrace');

      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e, stackTrace) {
      log('==============================');
      log('❌ AuthException');
      log('📌 Message: ${e.message}');
      log('📌 StatusCode: ${e.statusCode}');
      log('📍 StackTrace: $stackTrace');

      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e, stackTrace) {
      log('==============================');
      log('❌ Unexpected Exception');
      log('📌 Error: $e');
      log('📍 Type: ${e.runtimeType}');
      log('📍 StackTrace: $stackTrace');

      throw ServerException(
        'حدث خطأ أثناء طلب استعادة كلمة المرور: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      log('==============================');
      log('🔹 بدء التحقق من رمز استعادة كلمة المرور');
      log('📧 Email: $email');
      log('🔑 OTP: $otp');

      final response = await supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.recovery,
      );

      log('✅ تم استدعاء verifyOTP بنجاح');
      log('📌 Session: ${response.session}');
      log('📌 User: ${response.user?.id}');

      if (response.session == null) {
        log('❌ Session == null');
        throw const ServerException(
          'فشل التحقق، الرمز غير صحيح أو منتهي الصلاحية.',
        );
      }

      log('🎉 تم التحقق من الرمز بنجاح');
    } on SocketException catch (e, stackTrace) {
      log('==============================');
      log('❌ SocketException');
      log('📌 Error: $e');
      log('📍 StackTrace: $stackTrace');

      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e, stackTrace) {
      log('==============================');
      log('❌ AuthException');
      log('📌 Message: ${e.message}');
      log('📌 StatusCode: ${e.statusCode}');
      log('📍 StackTrace: $stackTrace');

      if (e.message.toLowerCase().contains('token has expired or is invalid')) {
        throw const ServerException('رمز الاستعادة غير صحيح أو انتهت صلاحيته.');
      }

      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e, stackTrace) {
      log('==============================');
      log('❌ Unexpected Exception');
      log('📌 Error: $e');
      log('📌 Type: ${e.runtimeType}');
      log('📍 StackTrace: $stackTrace');

      throw ServerException(
        'حدث خطأ أثناء التحقق من رمز الاستعادة: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> updatePassword(String newPassword) async {
    try {
      // تقوم هذه الدالة بتحديث بيانات المستخدم الحالي (الذي تم تسجيل دخوله مؤقتاً في الخطوة السابقة)
      final UserResponse response = await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (response.user == null) {
        throw const ServerException('فشل تحديث كلمة المرور.');
      }
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ أثناء تحديث كلمة المرور: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final currentUser = supabase.auth.currentUser;

      if (currentUser != null) {
        return await _getUserProfile(currentUser);
      } else {
        throw const ServerException("لا يوجد مستخدم مسجل حالياً.");
      }
    } on SocketException {
      throw const NetworkException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(
        'حدث خطأ أثناء جلب المستخدم الحالي: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> checkEmailverfied() async {
    try {
      final currentUser = supabase.auth.currentUser;

      return currentUser?.emailConfirmedAt != null;
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ أثناء التحقق من البريد: ${e.toString()}');
    }
  }

  // 1. دالة التحقق من الكود (عند ضغط زر التأكيد)
  @override
  Future<UserModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.signup,
      );
      if (response.user == null) {
        throw const ServerException(
          'فشل التحقق، الرمز غير صحيح أو منتهي الصلاحية.',
        );
      }
      return await _getUserProfile(response.user!);
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('حدث خطأ أثناء التحقق من الرمز: ${e.toString()}');
    }
  }

  // 2. دالة إعادة الإرسال (عند ضغط زر "إعادة إرسال الرمز")
  // قمت بتغيير اسمها من verifyEmail إلى resendVerificationCode ليكون معناها واضحاً 100%
  @override
  Future<void> resendVerificationCode(String email) async {
    try {
      await supabase.auth.resend(type: OtpType.signup, email: email);
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on AuthException catch (e) {
      _handleAuthException(e);
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException('حدث خطأ أثناء إعادة إرسال الرمز: ${e.toString()}');
    }
  }

  // ==========================================
  // الدوال المساعدة (Helper Methods)
  // ==========================================

  /// جلب بيانات المستخدم الإضافية من جدول قاعدة البيانات
  Future<UserModel> _getUserProfile(User user) async {
    try {
      final data = await supabase
          .from(_profilesTable)
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromSupabaseMap(data, user.emailConfirmedAt != null);
    } on SocketException {
      throw const ServerException(
        'الخدمة غير متوفرة حالياً، يرجى التحقق من اتصالك بالإنترنت.',
      );
    } on PostgrestException catch (e) {
      // التقاط أخطاء قاعدة البيانات (Postgrest)
      if (e.code == 'PGRST116') {
        throw const ServerException(
          'بيانات الملف الشخصي غير موجودة، يرجى التواصل مع الدعم.',
        );
      } else if (e.code == '42501') {
        throw const ServerException(
          'عذراً، ليس لديك صلاحية للوصول إلى بيانات الملف الشخصي.',
        );
      } else if (e.code == '23505') {
        throw const ServerException('هذه البيانات موجودة مسبقاً.');
      }
      throw ServerException('خطأ في جلب بيانات المستخدم: ${e.message}');
    } catch (e) {
      throw ServerException(
        'خطأ غير متوقع أثناء جلب الملف الشخصي: ${e.toString()}',
      );
    }
  }

  void _handleAuthException(AuthException e) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      throw const ServerException(
        'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
      );
    }
    if (message.contains('user already registered') ||
        message.contains('already exists')) {
      throw const ServerException('هذا البريد الإلكتروني مسجل بالفعل.');
    }
    if (message.contains('password should be at least 6 characters')) {
      throw const ServerException(
        'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل.',
      );
    }
    if (message.contains('user not found')) {
      throw const ServerException('لا يوجد مستخدم بهذا البريد الإلكتروني.');
    }
    if (message.contains('to be a valid email') ||
        message.contains('unable to validate email address')) {
      throw const ServerException('صيغة البريد الإلكتروني غير صحيحة.');
    }
    if (message.contains('rate limit') || message.contains('60 seconds')) {
      throw const ServerException(
        'الرجاء الانتظار قليلاً قبل المحاولة مرة أخرى.',
      );
    }
    if (message.contains('email link is invalid or has expired')) {
      throw const ServerException('رابط التحقق غير صالح أو انتهت صلاحيته.');
    }

    // إذا لم يكن الخطأ معروفاً، ارمِ رسالة الخطأ الأصلية
    throw ServerException(e.message);
  }

  // Future<T> _excuteWithAuthHandling<T>(Future<T>Function()  action) async {
  //     try {
  //       return await action();
  //     }on AuthException catch (e) {
  //       _handleAuthException(e);
  //       throw ServerException(e.message);
  //     } catch (e) {
  //       if (e is ServerException) rethrow;
  //       throw ServerException('حدث خطأ غير متوقع: ${e.toString()}');
  //     }
  // }
}
