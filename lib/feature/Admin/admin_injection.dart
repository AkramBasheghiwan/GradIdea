import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/Admin/data/datasource/dashboard_analysis.dart';
import 'package:graduation_management_idea_system/feature/Admin/presentation/views/manager/dashboard_analysis_cubit.dart';

class AdminInjection {
  static void init(GetIt sl) {
    sl.registerLazySingleton<DashboardAnalysisRemoteDataSource>(
      () => DashboardAnalysisRemoteDataSourceImp(sl()),
    );

    sl.registerFactory<DashboardAnalysisCubit>(
      () => DashboardAnalysisCubit(sl<DashboardAnalysisRemoteDataSource>()),
    );
  }
}
