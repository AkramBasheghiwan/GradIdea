import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/data_source/project_proposal_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';

class ProjectProposalRepositoryImpl implements ProjectProposalRepository {
  final ProjectProposalRemoteDataSource remoteDataSource;

  ProjectProposalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProjectProposals>>> getProposalToSupervisor(
    String status,
  ) async {
    try {
      final result = await remoteDataSource.getProposalToSupervisor(status);

      final projectProposal = result.map((json) {
        return ProjectProposalsModel.fromEntity(json);
      }).toList();

      return Right(projectProposal);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(NetworkFailure("يرجى التحقق من اتصال الإنترنت."));
    } catch (e) {
      return Left(ServerFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }

  // 2. حذف مقترح ومعالجة الأخطاء
  @override
  Future<Either<Failure, Unit>> deleteProjectProposal(int id) async {
    try {
      await remoteDataSource.deleteProjectProposal(id);
      return const Right(unit); // وحدة نجاح
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(NetworkFailure("انقطع الاتصال بالإنترنت أثناء الحذف."));
    } catch (e) {
      return const Left(
        ServerFailure("فشل حذف المقترح، يرجى المحاولة لاحقاً."),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProposal(ProjectProposals project) async {
    try {
      final projectMap = ProjectProposalsModel.fromEntity(project);

      await remoteDataSource.updateProposal(projectMap);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(
        NetworkFailure("انقطع الاتصال بالإنترنت أثناء التحديث."),
      );
    } catch (e) {
      return const Left(ServerFailure("فشل تحديث بيانات المقترح."));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProposalStatus({
    required int id,
    required String status,
    String? reason,
  }) async {
    try {
      await remoteDataSource.updateProposalStatus(
        id: id,
        status: status,
        rejectionReason: reason,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(
        NetworkFailure("لا يوجد اتصال بالإنترنت لتحديث الحالة."),
      );
    } catch (e) {
      return const Left(ServerFailure("حدث خطأ أثناء تحديث حالة المقترح."));
    }
  }

  @override
  Future<Either<Failure, Unit>> uploudProjectsProposals(
    ProjectProposals project,
  ) async {
    try {
      await remoteDataSource.uploadProjectProposal(
        ProjectProposalsModel.fromEntity(project),
      );

      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(NetworkFailure("انقطع الاتصال بالإنترنت أثناء الرفع."));
    } catch (e) {
      return const Left(
        ServerFailure("فشل رفع المقترح، يرجى المحاولة لاحقاً."),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProjectProposals>>> getAllProposals(
    String departmentId,
  ) async {
    try {
      final result = await remoteDataSource.getProposalsToHOD(departmentId);

      final projectProposal = result.map((json) {
        return ProjectProposalsModel.fromEntity(json);
      }).toList();

      return Right(projectProposal);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(NetworkFailure("يرجى التحقق من اتصال الإنترنت."));
    } catch (e) {
      return Left(ServerFailure("حدث خطأ غير متوقع: ${e.toString()}"));
    }
  }
}
