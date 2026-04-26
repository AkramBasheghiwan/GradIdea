import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> signUpUser({
    required String email,
    required String password,
    required String name,
    required String specialization,
  });
  Future<Either<Failure, UserEntity>> signUpExternalEntity({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String companyName,
  });
  Future<Either<Failure, Unit>> foregetPassword(String email);
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, bool>> checkVerifyEmail();
  Future<Either<Failure, Unit>> verifyEmail();
}
