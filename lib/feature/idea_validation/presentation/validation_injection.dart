import 'package:get_it/get_it.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/data_source/idea_validation_by_api_service.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/data_source/idea_validation_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/repository/get_project_repository_impl.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/repository/idea_validation_api_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/repository/idea_validation_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/get_project_repository.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idae_validation_api_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idea_validation_repo.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_suggestion_cubit/cubit/ai_suggestion_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/ai_validate_idea/cubit/validate_idea_cubit_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/get_project_detail/get_project_cubit.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/idea_validate_cubit/idea_validate_cubit.cubit.dart';

class ValidationInjection {
  static void init(GetIt scope) {
    scope.registerLazySingleton<IdeaValidationRemoteDataSource>(
      () => IdeaValidationRemoteDataSourceImpl(supabase: scope()),
    );
    scope.registerLazySingleton<IdeaValidationByApiService>(
      () => IdeaValidationByApiServiceImpl(),
    );
    //repositories

    scope.registerLazySingleton<IdeaValidationRepository>(
      () => IdeaValidationRepoimp(remoteDataSource: scope()),
    );
    scope.registerLazySingleton<IdeaValidationApiRepository>(
      () => IdeaValidationApiRepoimp(
        remoteDataSource: scope<IdeaValidationByApiService>(),
      ),
    );
    //cubit

    scope.registerFactory(
      () => IdeaValidationCubit(repository: scope<IdeaValidationRepository>()),
    );

    scope.registerLazySingleton<GetProjectRepository>(
      () => GetProjectRepositoryImpl(scope()),
    );
    scope.registerFactory<IdeaValidateCubit>(
      () => IdeaValidateCubit(apiService: scope<IdeaValidationApiRepository>()),
    );

    scope.registerFactory<AiSuggestionCubit>(
      () => AiSuggestionCubit(repository: scope<IdeaValidationApiRepository>()),
    );

    scope.registerFactory(() => GetProjectCubit(scope<GetProjectRepository>()));
  }
}
