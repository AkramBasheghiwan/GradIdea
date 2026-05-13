import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/project_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/supabase_upload_project_remote_data_sourcr.dart';
import 'package:graduation_management_idea_system/feature/projects/data/repository/project_repository_imp.dart';
import 'package:graduation_management_idea_system/feature/projects/data/repository/uploud_project_reporepository_imp.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/projects_repository.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_bloc.dart';

import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';

Future<void> initProjectsinjectionScope(GetIt scope) async {
  scope.registerLazySingleton<UploadProjectRemoteDataSource>(
    () => UploadProjectRemoteDataSourceImpl(supabase: scope()),
  );
  scope.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImp(scope()),
  );
  //repository
  scope.registerLazySingleton<UploudProjectRepository>(
    () => UploudProjectRepositoryImpl(remoteDataSource: scope()),
  );
  scope.registerLazySingleton<ProjectsRepository>(
    () => ProjectRepositoryImp(scope()),
  );
  scope.registerFactory<ProjectSearchBloc>(
    () => ProjectSearchBloc(scope<ProjectsRepository>()),
  );
  scope.registerFactory<UploadProjectCubit>(() => scope());
}
