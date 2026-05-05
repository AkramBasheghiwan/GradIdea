import 'dart:io';

import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';

class EditProfileState {
  final int currentStep;
  final bool loading;
  final File? image;
  final UserModel? userModel;
  final String? errorMessage;
  final bool updated;
  final bool loggedOut;

  const EditProfileState({
    this.currentStep = 0,
    this.loading = false,
    this.image,
    this.userModel,
    this.errorMessage,
    this.updated = false,
    this.loggedOut = false,
  });

  EditProfileState copyWith({
    int? currentStep,
    bool? loading,
    File? image,
    bool clearImage = false,
    UserModel? userModel,
    String? errorMessage,
    bool clearError = false,
    bool? updated,
    bool? loggedOut,
  }) {
    return EditProfileState(
      currentStep: currentStep ?? this.currentStep,
      loading: loading ?? this.loading,
      image: clearImage ? null : image ?? this.image,
      userModel: userModel ?? this.userModel,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      updated: updated ?? false,
      loggedOut: loggedOut ?? false,
    );
  }
}
