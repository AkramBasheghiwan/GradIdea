import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/user/data/dataSourece/supabase_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/user/domain/repository/search_user_repository.dart';

class SearchUserRepositoryImp implements SearchUserRepository {
  UserSupabaseRemoteDataSource remotedataSource;

  SearchUserRepositoryImp(this.remotedataSource);
  @override
  Future<Either<Failure, List<UserEntity>>> searchUser({
    required String query,
    required int page,
  }) async {
    try {
      final result = await remotedataSource.searchUsers(
        query: query,
        page: page,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
