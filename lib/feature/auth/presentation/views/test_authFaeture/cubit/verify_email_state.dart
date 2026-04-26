import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

// حالة التحميل (لإظهار الدائرة الدوارة)
class VerifyOtpLoading extends VerifyOtpState {}

// حالة نجاح تأكيد الحساب (ترجع لنا بيانات المستخدم لندخله للتطبيق)
class VerifyOtpSuccess extends VerifyOtpState {
  final UserEntity user;

  const VerifyOtpSuccess(this.user);

  @override
  List<Object> get props => [user];
}

// حالة خاصة بنجاح زر "إعادة إرسال الرمز"
class ResendOtpSuccess extends VerifyOtpState {}

// حالة الخطأ (سواء في التحقق أو إعادة الإرسال)
class VerifyOtpFailure extends VerifyOtpState {
  final String message;

  const VerifyOtpFailure(this.message);

  @override
  List<Object> get props => [message];
}
