import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/feature/app_setting/domain/repository/app_setting_repository.dart';
import 'package:graduation_management_idea_system/feature/app_setting/presentation/manager/setting_cubit/cubit/setting_state.dart';

class AppSettingCubit extends Cubit<AppSettingState> {
  AppSettingRepository repository;

  AppSettingCubit({required this.repository})
    : super(const AppSettingInitial());

  Future<void> getSetting() async {
    emit(const AppSettingLoading());

    final result = await repository.get();

    result.fold(
      (failure) => emit(AppSettingError(failure.message)),
      (setting) => emit(AppSettingLoaded(setting)),
    );
  }

  Future<void> update({
    int? maxGroup,
    bool? canUploadProjects,
    bool? canUploadProposal,
  }) async {
    final current = state;
    if (current is! AppSettingLoaded) return;

    emit(AppSettingUpdating(current.setting));

    final result = await repository.update(
      maxGroup: maxGroup,
      canUploadProjects: canUploadProjects,
      canUploadProposal: canUploadProposal,
    );

    result.fold(
      (failure) => emit(AppSettingError(failure.message)),
      (_) => getSetting(),
    );
  }

  Future<void> clearCurrentGroups() async {
    final result = await repository.clearSupervisorCurrentGroup();

    result.fold((failure) => emit(AppSettingError(failure.message)), (_) {});
  }
}
