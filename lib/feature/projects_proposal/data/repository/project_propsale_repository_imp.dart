import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/core/services/api_service/api_service_app_setting.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/data_source/project_proposal_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/data/model/project_proposals_model.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';
import 'package:graduation_management_idea_system/network/network_info.dart';

class ProjectProposalRepositoryImpl implements ProjectProposalRepository {
  final ProjectProposalRemoteDataSource remoteDataSource;
  final AppSettingsApiService settingsApiService;
  final NetworkInfo networkInfo;
  ProjectProposalRepositoryImpl({
    required this.remoteDataSource,
    required this.settingsApiService,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ProjectProposals>>> getProposalToSupervisor(
    String status,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
      }
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
  Future<Either<Failure, Unit>> deleteProjectProposal(
    String id,
    String fileUrl,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
      }
      await remoteDataSource.deleteProjectProposal(id, fileUrl);
      return const Right(unit);
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
  Future<Either<Failure, Unit>> updateProposal(
    ProjectProposals project,
    File? newfile,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
      }
      final projectMap = ProjectProposalsModel.fromEntity(project);

      await remoteDataSource.updateProposal(projectMap, newfile);
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
    required String id,
    required String status,
    String? reason,
  }) async {
    try {
      if (await networkInfo.isConnected) {
        return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
      }
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
      if (await networkInfo.isConnected) {
        return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
      }
      final canUpload = await settingsApiService.canUploadProposal();
      final hasProposal = await settingsApiService.hasProposal();
      if (!canUpload) {
        return left(
          const UploadDisabledFailure('تم إيقاف رفع المشاريع مؤقتاً'),
        );
      }
      if (!hasProposal) {
        return left(
          const UploadDisabledFailure(
            'لايمكنك رفع مشروع اخر لانك كذ رفعت مشروع سابقا',
          ),
        );
      }
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
      if (await networkInfo.isConnected) {
        return const Left(OfflineFailure("لا يوجد اتصال بالإنترنت"));
      }
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
