import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class ProposalApprovedRepository {
  Future<Either<Failure, List<ProjectProposals>>> fetchAllProposals({
    required String departmentId,
    required String status,
    required int page,
  });
  Future<Either<Failure, List<ProjectProposals>>> searchProposals({
    required String query,
    required int page,
    String? department,
    String? year,
  });
}
