// feature/auth/data/repository/auth_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_supabase_repo.dart';
import 'package:graduation_management_idea_system/feature/auth/data/datasource/supabase_remote_data_source.dart';

class AuthSupRepositoryImpl implements AuthSupabaseRepo {
  final AuthSupabaseRemoteDataSource remoteDataSource;
  // إذا كان لديك NetworkInfo للتحقق من الإنترنت قبل الاتصال، يتم حقنه هنا أيضاً

  AuthSupRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpUser({
    required String email,
    required String password,
    required String name,
    required String spcialization,
  }) async {
    try {
      final result = await remoteDataSource.signUpUser(
        email: email,
        password: password,
        name: name,
        spcialization: spcialization,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpCompany({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String companyName,
  }) async {
    try {
      final result = await remoteDataSource.signUpCompany(
        name: name,
        phone: phone,
        email: email,
        password: password,
        companyName: companyName,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(
        unit,
      ); // دالة void في dartz ترجع Right(unit) بدلاً من Right(null)
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(String email) async {
    try {
      await remoteDataSource.forgetPassword(email);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      await remoteDataSource.verifyPasswordResetOtp(email: email, otp: otp);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(String newPassword) async {
    try {
      await remoteDataSource.updatePassword(newPassword);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailverfied() async {
    try {
      final isVerified = await remoteDataSource.checkEmailverfied();
      return Right(isVerified);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final user = await remoteDataSource.verifyOtp(email: email, otp: otp);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> resendVerificationCode(String email) async {
    try {
      await remoteDataSource.resendVerificationCode(email);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
