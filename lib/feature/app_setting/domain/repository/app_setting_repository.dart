import 'package:graduation_management_idea_system/feature/app_setting/domain/entities/setting_entity.dart';

import '../../../../core/error/failure.dart';

import 'package:dartz/dartz.dart';

abstract class AppSettingRepository {
  Future<Either<Failure, AppSettingEntity>> get();

  Future<Either<Failure, Unit>> update({
    int? maxGroup,
    bool? canUploadProjects,
    bool? canUploadProposal,
  });

  Future<Either<Failure, Unit>> clearSupervisorCurrentGroup();
}
