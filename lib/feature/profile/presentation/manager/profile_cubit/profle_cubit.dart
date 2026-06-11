import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
import 'package:graduation_management_idea_system/feature/profile/data/repository/update_profile_repository_impl.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:graduation_management_idea_system/feature/profile/presentation/views/profiel_form_controller.dart';

class EditProfileCubit extends Cubit<ProfileState> {
  EditProfileCubit(this.repo) : super(const ProfileInitial());

  final UpdatePeofileRepository repo;

  final controllers = EditProfileControllers();

  UserModel? currentUser;

  /// load user
  void setUser(UserModel user) {
    currentUser = user;

    controllers.name.text = user.name;
    controllers.phone.text = user.phone ?? '';
    controllers.specialization.text = user.specialization ?? '';

    emit(ProfileLoaded(user: user));
  }

  /// update profile
  Future<void> updateProfile() async {
    if (currentUser == null) return;

    emit(const ProfileLoading());

    try {
      final updatedUser = currentUser!.copyWith(
        name: controllers.name.text.trim(),
        specialization: controllers.specialization.text.trim(),
        phone: controllers.phone.text.trim(),
      );

      await repo.updateProfile(updatedUser);

      currentUser = updatedUser;

      emit(ProfileUpdated(user: updatedUser, message: 'تم '));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
