import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/exceptions.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/data/datasource/supervisor_remote_data_source.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/project_group.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/supervisor_detail_entity.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/repo/supervisor_repository.dart';

class SupervisorRepositoryImpl implements SupervisorRepository {
  final SupervisorRemoteDataSource remoteDataSource;
  // إذا كان لديك NetworkInfo للتحقق من الإنترنت، يمكنك حقنه هنا

  SupervisorRepositoryImpl({required this.remoteDataSource});

  // ==========================================
  // 1. جلب تفاصيل المشرف
  // ==========================================
  @override
  Future<Either<Failure, SupervisorDetailsEntity>>
  getSupervisorDetails() async {
    try {
      final details = await remoteDataSource.getSupervisorDetails();
      return Right(
        details,
      ); // details هنا هي SupervisorDetailsModel وهي ترث من Entity
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  // ==========================================
  // 2. تحديث الحد الأقصى للمجموعات
  // ==========================================
  @override
  Future<Either<Failure, Unit>> updateMaxGroups(int newMaxCount) async {
    try {
      await remoteDataSource.updateMaxGroups(newMaxCount);
      return const Right(unit); // دالة void ترجع unit في dartz
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  // ==========================================
  // 3. جلب المقترحات الموجهة للمشرف
  // ==========================================
  @override
  Future<Either<Failure, List<ProjectGroupEntity>>>
  getSupervisorProposals() async {
    try {
      final proposals = await remoteDataSource.getSupervisorProposals();
      return Right(proposals); // proposals هنا هي List<ProjectGroupModel>
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  // ==========================================
  // 4. الرد على المقترح
  // ==========================================
  @override
  Future<Either<Failure, void>> respondToProposal({
    required int groupId,
    required String decision,
    String? rejectionReason,
  }) async {
    try {
      await remoteDataSource.respondToProposal(
        groupId: groupId,
        decision: decision,
        rejectionReason: rejectionReason,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
