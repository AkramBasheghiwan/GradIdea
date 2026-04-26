import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';

abstract class AuthSupabaseRepo {
  // feature/auth/domain/repository/auth_repository.dart

  Future<Either<Failure, UserEntity>> login(String email, String password);

  Future<Either<Failure, String>> signUpUser({
    required String email,
    required String password,
    required String name,
    required String spcialization,
  });

  Future<Either<Failure, String>> signUpCompany({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String companyName,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> forgetPassword(String email);

  Future<Either<Failure, void>> verifyPasswordResetOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, void>> updatePassword(String newPassword);

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, bool>> checkEmailverfied();

  Future<Either<Failure, UserEntity>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<Failure, void>> resendVerificationCode(String email);
}
