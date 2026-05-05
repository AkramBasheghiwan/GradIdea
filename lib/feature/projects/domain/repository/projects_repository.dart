import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class ProjectsRepository {
  Future<Either<Failure, List<ProjectEntity>>> findSimilarProjects(
    String description,
  );
  Future<Either<Failure, List<ProjectEntity>>> fetchAllProjects({
    required String departmentId,
    required String status,
    required int page,
  });
  Future<Either<Failure, List<ProjectEntity>>> searchProjects({
    required String query,
    required int page,
    String? department,
    String? year,
  });
}
