import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/data_source/idea_validation_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/validation_result_entity.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idea_validation_repo.dart';

class IdeaValidationRepoimp implements IdeaValidationRepository {
  final IdeaValidationRemoteDataSource remoteDataSource;
  IdeaValidationRepoimp({required this.remoteDataSource});
  @override
  Future<Either<Failure, String>> getAiSuggestions({
    required String studentIdea,
    required List<SimilarProjectEntity> oldProjects,
  }) async {
    try {
      final resulte = await remoteDataSource.getAiEnhancements(
        studentIdea,
        oldProjects.map((e) => e.title).toList(),
      );
      return Right(resulte);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        NetworkFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, ValidationResultEntity>> validateStudentIdea(
    String studentIdea,
  ) async {
    try {
      final resulte = await remoteDataSource.validateIdea(studentIdea);
      return Right(resulte);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        NetworkFailure('An unexpected error occurred: ${e.toString()}'),
      );
    }
  }
}
