import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/data_source/project_proposal_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/repository/project_propsale_repository_imp.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/repository/student_prject_proposal_imp.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/student_project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/fetch_supersior_cubit/cubit/fetch_supersior_cubit.dart';

import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/uploud_proposal/uploud_proposal_cubit.dart';

class ProposalInjection {
  static void initPrposalInhection(GetIt scope) {
    // Data Source
    scope.registerLazySingleton<ProjectProposalRemoteDataSource>(
      () => ProjectProposalRemoteDataSourceImpl(scope()),
    );
    //  repository
    scope.registerLazySingleton<ProjectProposalRepository>(
      () => ProjectProposalRepositoryImpl(remoteDataSource: scope()),
    );
    scope.registerLazySingleton<StudentProjectProposalRepository>(
      () => StudentProjectProposalRepositoryImpl(remoteDataSource: scope()),
    );

    // cubit for uploud proposal
    scope.registerFactory<UploadProposalCubit>(
      () => UploadProposalCubit(repository: scope<ProjectProposalRepository>()),
    );

    scope.registerFactory<FetchSupersiorCubit>(
      () => FetchSupersiorCubit(scope()),
    );
  }
}
