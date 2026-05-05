// users_state.dart
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => <Object>[];
}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersLoaded extends UsersState {
  final List<UserEntity> users;
  // final int page;
  // final bool hasReacgedMax;

  const UsersLoaded({required this.users});

  @override
  List<Object> get props => <Object>[users];
}

final class UsersError extends UsersState {
  final String message;

  const UsersError({required this.message});

  @override
  List<Object> get props => <Object>[message];
}
