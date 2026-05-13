import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/data_source/idea_validation_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/repository/idea_validation_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idea_validation_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_cubit_cubit.dart';

class ValidationInjection {
  static void init(GetIt scope) {
    scope.registerLazySingleton<IdeaValidationRemoteDataSource>(
      () => IdeaValidationRemoteDataSourceImpl(supabase: scope()),
    );

    //repositories

    scope.registerLazySingleton<IdeaValidationRepository>(
      () => IdeaValidationRepoimp(remoteDataSource: scope()),
    );

    //cubit

    scope.registerFactory(
      () => IdeaValidationCubit(repository: scope<IdeaValidationRepository>()),
    );
  }
}
