import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart'; // تأكد من مسار ملف الـ Failure
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

import 'package:graduation_management_idea_system/feature/auth/presentation/views/test_authFaeture/cubit/verify_email_state.dart';

import '../../../../Domain/repository/auth_supabase_repo.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final AuthSupabaseRepo authRepository;

  // البداية مع الحالة الابتدائية
  VerifyOtpCubit({required this.authRepository}) : super(VerifyOtpInitial());

  // =========================================================
  // الدالة الأولى: التحقق من الرمز المدخل (OTP)
  // =========================================================
  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(VerifyOtpLoading()); // إظهار التحميل

    // استدعاء الدالة من الـ Repository
    final Either<Failure, UserEntity> result = await authRepository.verifyOtp(
      email: email,
      otp: otp,
    );

    // معالجة النتيجة (إما فشل أو نجاح)
    result.fold(
      (Failure failure) => emit(VerifyOtpFailure(failure.message)),
      (UserEntity user) =>
          emit(VerifyOtpSuccess(user)), // إرسال المستخدم للواجهة
    );
  }

  // =========================================================
  // الدالة الثانية: إعادة إرسال الرمز إلى الإيميل
  // =========================================================
  Future<void> resendCode(String email) async {
    emit(VerifyOtpLoading()); // إظهار التحميل

    // استدعاء دالة إعادة الإرسال من الـ Repository
    final Either<Failure, void> result = await authRepository
        .resendVerificationCode(email);

    // معالجة النتيجة
    result.fold(
      (Failure failure) => emit(VerifyOtpFailure(failure.message)),
      (_) => emit(ResendOtpSuccess()), // إرسال حالة "نجح إعادة الإرسال"
    );
  }
}
