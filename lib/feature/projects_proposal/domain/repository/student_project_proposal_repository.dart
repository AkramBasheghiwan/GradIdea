import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class StudentProjectProposalRepository {
  Future<Either<Failure, Unit>> uploudProjectsProposals(
    ProjectProposals project,
  );

  Future<Either<Failure, List<ProjectProposals>>> getMyProposals(String status);
  Future<Either<Failure, Unit>> updateProposal(ProjectProposals project);
}
