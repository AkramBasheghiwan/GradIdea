import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';
import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/forget_password_states.dart';

class ForgotPasswordCubits extends Cubit<ForgotPasswordStates> {
  final AuthSupabaseRepo authRepository;

  ForgotPasswordCubits({required this.authRepository})
    : super(ForgotPasswordInitial());

  // =========================================================
  // الخطوة 1: إرسال كود التحقق إلى البريد الإلكتروني
  // =========================================================
  Future<void> sendCode(String email) async {
    emit(ForgotPasswordLoading());

    final Either<Failure, void> result = await authRepository.forgetPassword(
      email,
    );

    result.fold(
      (failure) => emit(ForgotPasswordError(failure.message)),
      (_) => emit(ForgotPasswordCodeSent()), // إرسال حالة "تم إرسال الكود"
    );
  }

  // =========================================================
  // الخطوة 2: التحقق من الرمز (OTP) المدخل من المستخدم
  // =========================================================
  Future<void> verifyCode({required String email, required String otp}) async {
    emit(ForgotPasswordLoading());

    final Either<Failure, void> result = await authRepository
        .verifyPasswordResetOtp(email: email, otp: otp);

    result.fold(
      (failure) => emit(ForgotPasswordError(failure.message)),
      (_) => emit(ForgotPasswordCodeVerified()), // إرسال حالة "تم التحقق بنجاح"
    );
  }

  // =========================================================
  // الخطوة 3: تعيين كلمة المرور الجديدة
  // =========================================================
  Future<void> updatePassword(String newPassword) async {
    emit(ForgotPasswordLoading());

    final Either<Failure, void> result = await authRepository.updatePassword(
      newPassword,
    );

    result.fold(
      (failure) => emit(ForgotPasswordError(failure.message)),
      (_) => emit(
        ForgotPasswordPasswordUpdated(),
      ), // إرسال حالة "تم تحديث كلمة المرور"
    );
  }
}
