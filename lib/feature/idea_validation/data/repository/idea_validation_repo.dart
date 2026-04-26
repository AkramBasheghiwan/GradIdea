// import 'package:graduation_management_idea_system/core/error/exceptions.dart';
// import 'package:graduation_management_idea_system/core/error/failure.dart';
// import 'package:graduation_management_idea_system/feature/projects/data/data_source/idea_validation_remote_data_source.dart';
// import 'package:graduation_management_idea_system/feature/projects/domain/entities/validation_result_entity.dart';
// import 'package:graduation_management_idea_system/feature/projects/domain/repository/idea_validation_repo.dart';
// import 'package:dartz/dartz.dart';

// class IdeaValidationRepo implements IdeaValidationRepositoryImp {
//   final IdeaValidationRemoteDataSource ideaValidationRemotDataSource;

//   const IdeaValidationRepo({required this.ideaValidationRemotDataSource});

//   @override
//   Future<Either<Failure, ValidationResultEntity>> validateStudentIdea(
//     String studentIdea,
//   ) async {
//     try {
//       final result = await ideaValidationRemotDataSource.validateIdea(
//         studentIdea,
//       );
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> getAiSuggestions({
//     required String studentIdea,
//     required List<String> oldProjects,
//   }) async {
//     try {
//       final result = await ideaValidationRemotDataSource.getAiEnhancements(
//         studentIdea,
//         oldProjects,
//       );
//       return Right(result);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.message));
//     }
//   }
// }
