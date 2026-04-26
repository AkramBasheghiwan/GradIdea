import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/project_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/projects_repository.dart';

class ProjectRepositoryImp implements ProjectsRepository {
  final ProjectRemoteDataSource remoteDataSource;

  const ProjectRepositoryImp(this.remoteDataSource);
  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchAllProjects(
    String departmentId,
    String status,
    int page,
  ) async {
    final result = await remoteDataSource.fetchAllProjects(
      departmentId: departmentId,
      status: status,
      page: page,
    );
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> findSimilarProjects(
    String description,
  ) {
    // TODO: implement findSimilarProjects
    throw UnimplementedError();
  }
}
