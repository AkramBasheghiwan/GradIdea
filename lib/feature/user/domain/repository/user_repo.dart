import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../auth/Domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsersByRole(String role);
  Future<Either<Failure, Unit>> deleteUser(String userId);
  Future<Either<Failure, Unit>> updateUserRole(String userId, String newRole);
}
