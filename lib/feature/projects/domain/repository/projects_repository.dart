import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectEntity>>> findSimilarProjects(
    String description,
  );
  Future<Either<Failure, List<ProjectEntity>>> fetchAllProjects(
    String departmentId,
    String status,
    int pag,
  );
}
