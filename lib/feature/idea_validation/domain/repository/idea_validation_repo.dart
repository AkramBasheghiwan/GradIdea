import 'package:graduation_management_idea_system/feature/idea_validation/domain/entities/simialar_project_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/validation_result_entity.dart';

abstract class IdeaValidationRepositoryImp {
  Future<Either<Failure, ValidationResultEntity>> validateStudentIdea(
    String studentIdea,
  );

  Future<Either<Failure, String>> getAiSuggestions({
    required String studentIdea,
    required List<SimilarProjectEntity> oldProjects,
  });
}
