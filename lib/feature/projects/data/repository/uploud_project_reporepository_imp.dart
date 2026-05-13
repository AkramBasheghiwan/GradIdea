import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects/data/data_source/supabase_upload_project_remote_data_sourcr.dart';
import 'package:graduation_management_idea_system/feature/projects/data/model/model.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';

class UploudProjectRepositoryImpl implements UploudProjectRepository {
  final UploadProjectRemoteDataSource remoteDataSource;

  UploudProjectRepositoryImpl({required this.remoteDataSource});

  // ==========================================
  // 2. رفع مشروع جديد للأرشيف
  // ==========================================
  @override
  Future<Either<Failure, Unit>> uploadProjectToArchive(
    ProjectEntity project,
  ) async {
    try {
      await remoteDataSource.uploadProject(ProjectModel.fromEntity(project));
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(ServerFailure('حدث خطأ غير متوقع أثناء رفع المشروع.'));
    }
  }

  // ==========================================
  // 4. تحديث بيانات مشروع
  // ==========================================
  @override
  Future<Either<Failure, Unit>> updateProject(ProjectEntity newProject) async {
    try {
      await remoteDataSource.updateProject(ProjectModel.fromEntity(newProject));
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(
        ServerFailure('حدث خطأ أثناء محاولة تحديث بيانات المشروع.'),
      );
    }
  }

  // ==========================================
  // 5. حذف مشروع من الأرشيف
  // ==========================================
  @override
  Future<Either<Failure, Unit>> deleteProject(String projectId) async {
    try {
      await remoteDataSource.deleteProject(projectId);
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(
        ServerFailure('فشل حذف المشروع، يرجى المحاولة لاحقاً.'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchMyProjects({
    required String status,
  }) async {
    try {
      final projects = await remoteDataSource.fetchMyProjects(status: status);
      return Right(
        projects.map((model) => ProjectModel.fromEntity(model)).toList(),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(
        ServerFailure('فشل جلب المشاريع، يرجى المحاولة لاحقاً.'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProjectEntity>>> fetchAllProjectsByDepartment({
    required String departmentId,
    required String status,
  }) async {
    try {
      final projects = await remoteDataSource.fetchAllProjectsByDepartment(
        departmentId: departmentId,
        status: status,
      );
      return Right(
        projects.map((model) => ProjectModel.fromEntity(model)).toList(),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(
        ServerFailure('فشل جلب المشاريع، يرجى المحاولة لاحقاً.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProjectStatus(String id) async {
    try {
      await remoteDataSource.updateProjectsStatus(
        id.toString(),
        AppProjectsStatus.approved,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(
        ServerFailure('فشل جلب المشاريع، يرجى المحاولة لاحقاً.'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProjectsStatusReject({
    required String id,
    required String status,
    String? reason,
  }) async {
    try {
      await remoteDataSource.updateProjectsStatusReject(
        id: id,
        status: status,
        reason: reason,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return const Left(
        ServerFailure('فشل جلب المشاريع، يرجى المحاولة لاحقاً.'),
      );
    }
  }
}
