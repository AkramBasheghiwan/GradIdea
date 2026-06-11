import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';

abstract class ProfileState {
  final UserModel? user;
  final String? message;

  const ProfileState({this.user, this.message});
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required UserModel user}) : super(user: user);
}

class ProfileUpdated extends ProfileState {
  const ProfileUpdated({required UserModel super.user, super.message});
}

class ProfileError extends ProfileState {
  const ProfileError({required String message}) : super(message: message);
}
