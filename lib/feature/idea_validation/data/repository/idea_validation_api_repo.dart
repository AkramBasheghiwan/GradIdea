import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/data_source/idea_validation_by_api_service.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/idae_validation_api_repo.dart';

class IdeaValidationApiRepoimp implements IdeaValidationApiRepository {
  final IdeaValidationByApiService remoteDataSource;
  IdeaValidationApiRepoimp({required this.remoteDataSource});
  @override
  Future<Either<Failure, String>> getAiSuggestions({
    required IdeaSubmit studentIdea,
    required List<SimilarPaperMatch> oldProjects,
  }) async {
    try {
      final resulte = await remoteDataSource.getAiEnhancements(
        studentIdea,
        oldProjects,
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
  Future<Either<Failure, ValidationResponse>> validateStudentIdea(
    IdeaSubmit studentIdea,
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
