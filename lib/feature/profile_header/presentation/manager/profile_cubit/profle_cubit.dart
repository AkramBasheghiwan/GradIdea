import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/manager/profile_cubit/profile_state.dart';
import 'package:graduation_management_idea_system/feature/profile_header/presentation/views/profiel_form_controller.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());

  final controllers = EditProfileControllers();

  //final ImagePicker _picker = ImagePicker();

  /// next
  void nextStep() {
    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  /// previous
  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  // /// pick image
  // Future<void> pickImage() async {
  //   final picked = await _picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 85,
  //   );

  //   if (picked == null) return;

  //   emit(
  //     state.copyWith(
  //       image: File(picked.path),
  //     ),
  //   );
  // }

  /// load profile
  Future<void> loadProfile() async {
    emit(state.copyWith(loading: true));

    try {
      /// repo call
      final user = await repo.getProfile();

      controllers.name.text = user.name ?? '';
      controllers.email.text = user.email ?? '';
      controllers.specialization.text = user.specialization ?? '';
      controllers.bio.text = user.bio ?? '';

      emit(state.copyWith(loading: false, userModel: user));
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  /// update
  Future<void> updateProfile() async {
    emit(state.copyWith(loading: true, updated: false));

    try {
      final updatedUser = state.userModel!.copyWith(
        name: controllers.name.text.trim(),
        email: controllers.email.text.trim(),
        specialization: controllers.specialization.text.trim(),
        bio: controllers.bio.text.trim(),
      );

      await repo.updateProfile(user: updatedUser, image: state.image);

      emit(
        state.copyWith(loading: false, userModel: updatedUser, updated: true),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    }
  }

  /// logout
  Future<void> logout() async {
    emit(state.copyWith(loading: true));

    await repo.logout();

    emit(state.copyWith(loading: false, loggedOut: true));
  }

  @override
  Future<void> close() {
    controllers.dispose();
    return super.close();
  }
}
