import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class GetProjectRepository {
  Future<Either<Failure, ProjectEntity>> getProjectDetaile(String id);
}
