import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class UploudProjectRepository {
  Future<Either<Failure, Unit>> uploadProjectToArchive(ProjectEntity project);
  Future<Either<Failure, Unit>> deleteProject(String id);
  Future<Either<Failure, List<ProjectEntity>>> fetchMyProjects({
    required String status,
  });
  Future<Either<Failure, Unit>> updateProject(ProjectEntity newProject);

  Future<Either<Failure, List<ProjectEntity>>> fetchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  });
  Future<Either<Failure, Unit>> updateProjectsStatusReject({
    required String id,
    required String status,
    String? reason,
  });
  Future<Either<Failure, Unit>> updateProjectStatus(String id);
}
