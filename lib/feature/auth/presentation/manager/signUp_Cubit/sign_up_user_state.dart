import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState(); // يفضل إضافة const هنا

  @override
  List<Object?> get props => <Object?>[];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String
  email; // يمكنك تغيير هذا إلى UserEntity إذا كنت تريد إرسال الكائن الكامل بدلاً من البريد الإلكتروني فقط

  const SignUpSuccess(this.email);
  @override
  List<Object> get props => <Object>[email];
}

class SignUpFailure extends SignUpState {
  final String message;
  final bool isOffline;
  const SignUpFailure(this.message, {this.isOffline = false});
  @override
  List<Object> get props => <Object>[message, isOffline];
}

// أضف هذه الحالة إلى ملف الحالات الخاص بك
class SignUpRequiresVerification extends SignUpState {
  final String email;

  const SignUpRequiresVerification({required this.email});

  @override
  List<Object> get props => [email];
}
