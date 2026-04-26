abstract class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;
  ForgotPasswordSuccess({
    this.message =
        "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.",
  });
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
}
