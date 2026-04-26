abstract class VerifyEmailState {
  VerifyEmailState();
}

class VerifyEmailInitial extends VerifyEmailState {}

class VerifyEmailLoading extends VerifyEmailState {}

class VerifyEmailSuccess extends VerifyEmailState {}

class VerifyEmailMessageSuccess extends VerifyEmailState {
  final String message;
  VerifyEmailMessageSuccess({required this.message});
}

class VerifyEmailFailure extends VerifyEmailState {
  final String errMessage;
  bool? isOffline;
  VerifyEmailFailure({required this.errMessage, required this.isOffline});
}
