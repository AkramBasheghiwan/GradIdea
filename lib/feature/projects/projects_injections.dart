import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/supabase_upload_project_remote_data_sourcr.dart';
import 'package:graduation_management_idea_system/feature/projects/data/repository/uploud_project_reporepository_imp.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/upload_project_cubit/upload_project_cubit.dart';

Future<void> initProjectsinjectionScope(GetIt scope) async {
  scope.registerLazySingleton<ProjectRemoteDataSource>(
    () => ProjectRemoteDataSourceImpl(supabase: scope()),
  );
  //repository
  scope.registerLazySingleton<UploudProjectRepository>(
    () => UploudProjectRepositoryImpl(remoteDataSource: scope()),
  );

  scope.registerFactory<UploadProjectCubit>(() => scope());
}
