import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/project_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/projects_repository.dart';

class ProjectRepositoryImp implements ProjectsRepository {
  final ProjectRemoteDataSource remoteDataSource;

  const ProjectRepositoryImp(this.remoteDataSource);
  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchAllProjects({
    required String departmentId,
    required String status,
    required int page,
  }) async {
    try {
      final result = await remoteDataSource.fetchAllProjects(
        departmentId: departmentId,
        status: status,
        page: page,
      );

      final response = result.map((e) => ProjectModel.fromEntity(e)).toList();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> findSimilarProjects(
    String description,
  ) {
    // TODO: implement findSimilarProjects
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> searchProjects({
    required String query,
    required int page,
    String? department,
    String? year,
  }) async {
    try {
      final resulte = await remoteDataSource.searchProjects(
        query: query,
        page: page,
      );

      return Right(resulte);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
