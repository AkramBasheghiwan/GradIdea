import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class UploudProjectRepository {
  Future<Either<Failure, Unit>> uploadProjectToArchive(ProjectEntity project);
  Future<Either<Failure, Unit>> deleteProject(String id);

  Future<Either<Failure, Unit>> updateProject(ProjectEntity newProject);
}
