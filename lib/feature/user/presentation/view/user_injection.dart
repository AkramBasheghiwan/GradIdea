//import 'package:graduation_management_idea_system/feature/user/data/dataSourece/data_source.dart';
import 'package:graduation_management_idea_system/feature/user/data/dataSourece/supabase_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/user/data/repository/user_repository.dart';
import 'package:graduation_management_idea_system/feature/user/domain/repository/user_repo.dart';
import 'package:get_it/get_it.dart';

void initUserInjection(GetIt sl) {
  // dataSource

  // sl.registerLazySingleton<UserRemoteDataSource>(
  //   () => UserRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  // );
  sl.registerLazySingleton<UserSupabaseRemoteDataSource>(
    () => UserSupabaseRemoteDataSourceImpl(supabase: sl()),
  );
  // repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );
}
