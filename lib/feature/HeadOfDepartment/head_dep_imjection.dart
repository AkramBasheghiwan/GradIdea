import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/data/head_repopository/hod_dash_repository_imp.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/domain/head_repo/hod_dash_repository.dart';
import 'package:graduation_management_idea_system/feature/HeadOfDepartment/presentation/manager/dashboard_cubit/dashboard_state.dart';

class HeadOfDepartmentInjection {
  static void init(GetIt sl) {
    // Repository
    sl.registerLazySingleton<HodDashRepository>(
      () => DashboardRepositoryImp(sl()),
    );

    // Data Source
    sl.registerFactory<DashboardCubit>(
      () => DashboardCubit(sl<HodDashRepository>()),
    );
  }
}
