import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class ProjectProposalRepository {
  Future<Either<Failure, Unit>> uploudProjectsProposals(
    ProjectProposals project,
  );
  Future<Either<Failure, List<ProjectProposals>>> getProposalToSupervisor(
    String status,
  );

  Future<Either<Failure, List<ProjectProposals>>> getAllProposals(
    String departmentId,
  );

  Future<Either<Failure, Unit>> deleteProjectProposal(int id);

  Future<Either<Failure, Unit>> updateProposal(ProjectProposals project);

  Future<Either<Failure, Unit>> updateProposalStatus({
    required int id,
    required String status,
    String? reason,
  });
}
