import 'package:equatable/equatable.dart';

abstract class ForgotPasswordStates extends Equatable {
  const ForgotPasswordStates();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordStates {}

class ForgotPasswordLoading extends ForgotPasswordStates {}

// 1. حالة نجاح إرسال الكود (الـ UI يوجه المستخدم لشاشة إدخال الـ OTP)
class ForgotPasswordCodeSent extends ForgotPasswordStates {}

// 2. حالة نجاح التحقق من الكود (الـ UI يوجه المستخدم لشاشة كتابة كلمة المرور الجديدة)
class ForgotPasswordCodeVerified extends ForgotPasswordStates {}

// 3. حالة نجاح تغيير كلمة المرور (الـ UI يظهر رسالة نجاح ويوجه لتسجيل الدخول)
class ForgotPasswordPasswordUpdated extends ForgotPasswordStates {}

// حالة الخطأ (الـ UI يظهر SnackBar برسالة الخطأ)
class ForgotPasswordError extends ForgotPasswordStates {
  final String message;

  const ForgotPasswordError(this.message);

  @override
  List<Object> get props => [message];
}
