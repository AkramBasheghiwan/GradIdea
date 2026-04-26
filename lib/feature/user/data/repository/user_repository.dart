import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/data/model/user_model.dart';
//import 'package:graduation_management_idea_system/feature/user/data/dataSourece/data_source.dart';
import 'package:graduation_management_idea_system/feature/user/data/dataSourece/supabase_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/user/domain/repository/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserSupabaseRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsersByRole(String role) async {
    //if(!await Network)
    try {
      final List<UserModel> users = await remoteDataSource.getAllUsersByRole(
        role,
      );
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('حدث خطأ غير متوقع في النظام.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(String userId) async {
    try {
      await remoteDataSource.deleteUser(userId);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserRole(
    String userId,
    String newRole,
  ) async {
    try {
      await remoteDataSource.updateUserRole(userId, newRole);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
