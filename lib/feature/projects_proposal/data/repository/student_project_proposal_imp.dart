import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/data_source/project_proposal_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/student_project_proposal_repository.dart';

class StudentProjectProposalRepositoryImpl
    implements StudentProjectProposalRepository {
  final ProjectProposalRemoteDataSource remoteDataSource;

  const StudentProjectProposalRepositoryImpl({required this.remoteDataSource});

  // 1. جلب المقترحات الخاصة بالطالب  الي رفع المشروع
  @override
  Future<Either<Failure, List<ProjectProposals>>> getMyProposals(
    String status,
  ) async {
    try {
      final result = await remoteDataSource.getMyProposals(status);

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

  // 2. تحديث مقترح الطالب ومعالجة الأخطاء
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
      return const Left(
        ServerFailure("فشل تحديث المقترح، يرجى المحاولة لاحقاً."),
      );
    }
  }

  // 3. رفع مقترح جديد ومعالجة الأخطاء
  @override
  Future<Either<Failure, Unit>> uploudProjectsProposals(
    ProjectProposals project,
  ) async {
    try {
      final projectMap = ProjectProposalsModel.fromEntity(project);

      await remoteDataSource.uploadProjectProposal(projectMap);
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
}
