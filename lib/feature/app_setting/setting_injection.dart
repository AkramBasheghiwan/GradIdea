import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/app_setting/data/data_source/setting_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/app_setting/data/repository/app_setting_repository_imp.dart';
import 'package:graduation_management_idea_system/feature/app_setting/domain/repository/app_setting_repository.dart';
import 'package:graduation_management_idea_system/feature/app_setting/presentation/manager/setting_cubit/cubit/setting_cubit.dart';

class SettingInjection {
  static void init(GetIt sl) {
    sl.registerLazySingleton<AppSettingRemoteDataSource>(
      () => AppSettingRemoteDataSourceImpl(sl()),
    );
    sl.registerLazySingleton<AppSettingRepository>(
      () => AppSettingRepositoryImpl(sl<AppSettingRemoteDataSource>()),
    );
    sl.registerFactory<AppSettingCubit>(
      () => AppSettingCubit(repository: sl<AppSettingRepository>()),
    );
  }
}
