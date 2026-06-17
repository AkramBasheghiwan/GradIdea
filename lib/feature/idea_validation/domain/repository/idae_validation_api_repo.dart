import 'package:graduation_management_idea_system/feature/idea_validation/data/model/idea_supmit_modle.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

abstract class IdeaValidationApiRepository {
  Future<Either<Failure, ValidationResponse>> validateStudentIdea(
    IdeaSubmit studentIdea,
  );

  Future<Either<Failure, String>> getAiSuggestions({
    required IdeaSubmit studentIdea,
    required List<SimilarPaperMatch> oldProjects,
  });
}
