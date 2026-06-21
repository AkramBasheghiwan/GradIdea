import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/core/services/api_service/api_service_app_setting.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/fetch_supervisor_cubit.dart/fetch_supervisor_cubit.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/data_source/project_proposal_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/repository/project_propsale_repository_imp.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/repository/student_project_proposal_imp.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/student_project_proposal_repository.dart';

import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';

class ProposalInjection {
  static void initPrposalInhection(GetIt scope) {
    // Data Source

    scope.registerLazySingleton<ProjectProposalRemoteDataSource>(
      () => ProjectProposalRemoteDataSourceImpl(scope()),
    );
    //  repository
    scope.registerLazySingleton<ProjectProposalRepository>(
      () => ProjectProposalRepositoryImpl(
        remoteDataSource: scope(),
        settingsApiService: scope<AppSettingsApiService>(),
        networkInfo: scope(),
      ),
    );
    scope.registerLazySingleton<StudentProjectProposalRepository>(
      () => StudentProjectProposalRepositoryImpl(remoteDataSource: scope()),
    );

    // cubit for uploud proposal
    scope.registerFactory<UploadProposalCubit>(
      () => UploadProposalCubit(repository: scope<ProjectProposalRepository>()),
    );

    scope.registerFactory<FetchSupervisorCubit>(
      () => FetchSupervisorCubit(scope()),
    );
  }
}
