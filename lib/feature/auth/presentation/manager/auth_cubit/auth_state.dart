import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => <Object>[];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;
  const AuthAuthenticated(this.user);
  @override
  List<Object> get props => <Object>[user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object> get props => <Object>[message];
}

class AuthMessageSuccess extends AuthState {
  final String message;
  const AuthMessageSuccess(this.message);
  @override
  List<Object> get props => <Object>[message];
}
