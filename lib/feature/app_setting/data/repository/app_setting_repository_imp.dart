import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/feature/app_setting/data/data_source/setting_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/app_setting/domain/entities/setting_entity.dart';
import 'package:graduation_management_idea_system/feature/app_setting/domain/repository/app_setting_repository.dart';

import '../../../../core/error/failure.dart';

class AppSettingRepositoryImpl implements AppSettingRepository {
  final AppSettingRemoteDataSource remote;

  AppSettingRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, AppSettingEntity>> get() async {
    try {
      final result = await remote.get();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> update({
    int? maxGroup,
    bool? canUploadProjects,
    bool? canUploadProposal,
  }) async {
    try {
      await remote.update(
        maxGroup: maxGroup,
        canUploadProjects: canUploadProjects,
        canUploadProposal: canUploadProposal,
      );

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearSupervisorCurrentGroup() async {
    try {
      await remote.clearSupervisorCurrentGroup();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
