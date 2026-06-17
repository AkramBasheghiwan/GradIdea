import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/datasource/dashboard_analysis_supervisor_data_source.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/data/repo/supervisor_dashboard_analysis.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/domain/repo/supervisor_dashboard_repo.dart';
import 'package:graduation_management_idea_system/feature/Supervisor/presentation/manager/dash_analysis_cubit/dash_analysis_cubit.dart';

class SupervisorInjection {
  static void init(GetIt getIt) {
    // Data Source
    getIt.registerLazySingleton<DashboardAnalysisSupervisorDataSource>(
      () => DashboardAnalysisSupervisorDataSourceImpl(supabase: getIt()),
    );
    //repostory

    getIt.registerLazySingleton<SupervisorDashboardAnalysis>(
      () => SupervisorDashboardAnalysisImpl(
        dashboarAnalusis: getIt<DashboardAnalysisSupervisorDataSource>(),
      ),
    );
    // Cubit
    getIt.registerFactory<DashAnalysisCubit>(
      () => DashAnalysisCubit(repository: getIt<SupervisorDashboardAnalysis>()),
    );
  }
}
