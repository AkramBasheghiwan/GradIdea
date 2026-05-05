import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/data/data_source/proposal_approved_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/domain/repository/proposal_approved_repository.dart';

class ProposalApprovedRepositoryImpl implements ProposalApprovedRepository {
  final ProposalApprovedRemoteDataSource remoteDataSource;

  const ProposalApprovedRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<ProjectProposals>>> fetchAllProposals({
    required String departmentId,
    required String status,
    required int page,
  }) async {
    try {
      final result = await remoteDataSource.fetchAllProposals(
        departmentId: departmentId,
        status: status,
        page: page,
      );

      final response = result
          .map((e) => ProjectProposalsModel.fromEntity(e))
          .toList();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProjectProposals>>> searchProposals({
    required String query,
    required int page,
    String? department,
    String? year,
  }) async {
    try {
      final resulte = await remoteDataSource.searchProposal(
        query: query,
        page: page,
      );

      final response = resulte
          .map((e) => ProjectProposalsModel.fromEntity(e))
          .toList();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
