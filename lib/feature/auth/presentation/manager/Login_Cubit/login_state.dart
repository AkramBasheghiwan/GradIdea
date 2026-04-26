import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => <Object>[];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserEntity user;
  const LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});
}

// أضف هذه الحالة إلى ملف login_state.dart
class LoginRequiresVerification extends LoginState {
  final String email;

  const LoginRequiresVerification({required this.email});

  @override
  List<Object> get props => [email];
}
