import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';

import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class HeadRepository {
  Future<Either<Failure, List<ProjectEntity>>> getPendingProjects();
  Future<Either<Failure, Unit>> approveProject(String projectId);
  Future<Either<Failure, Unit>> rejectProject(String projectId, String reason);
}
