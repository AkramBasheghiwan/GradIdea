import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

abstract class SearchUserRepository {
  Future<Either<Failure, List<UserEntity>>> searchUser({
    required String query,
    required int page,
  });
}
