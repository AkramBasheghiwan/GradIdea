import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';

import 'package:graduation_management_idea_system/feature/auth/Domain/repository/auth_repository.dart';
import 'package:graduation_management_idea_system/feature/auth/Domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../network/network_info.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({required this.authDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.getCurrentUser();
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.login(email, password);
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    }
    {
      return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }

  @override
  Future<Either<Failure, Unit>> foregetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await authDataSource.forgetPassword(email);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await authDataSource.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure("فشل تسجيل الخروج: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpUser({
    required String email,
    required String password,
    required String name,
    required String specialization,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.signUpUser(
          email: email,
          password: password,
          name: name,
          spcialization: specialization,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpExternalEntity({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String companyName,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await authDataSource.signUpCompany(
          email: email,
          password: password,
          name: name,
          phone: phone,
          companyName: companyName,
        );
        return Right(response);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() async {
    if (await networkInfo.isConnected) {
      try {
        await authDataSource.verifyEmail();
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }

  @override
  Future<Either<Failure, bool>> checkVerifyEmail() async {
    if (await networkInfo.isConnected) {
      var isCheck = await authDataSource.checkEmailverfied();

      return Right(isCheck);
    } else {
      return Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
    }
  }
}
