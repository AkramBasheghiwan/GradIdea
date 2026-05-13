import 'package:graduation_management_idea_system/feature/app_setting/domain/entities/setting_entity.dart';

sealed class AppSettingState {
  const AppSettingState();
}

class AppSettingInitial extends AppSettingState {
  const AppSettingInitial();
}

class AppSettingLoading extends AppSettingState {
  const AppSettingLoading();
}

class AppSettingLoaded extends AppSettingState {
  final AppSettingEntity setting;

  const AppSettingLoaded(this.setting);
}

class AppSettingUpdating extends AppSettingState {
  final AppSettingEntity setting;

  const AppSettingUpdating(this.setting);
}

class AppSettingError extends AppSettingState {
  final String message;

  const AppSettingError(this.message);
}
