import 'package:dartz/dartz.dart';
import 'package:graduation_management_idea_system/core/error/failure.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/project_group.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/supervisor_detail_entity.dart';

abstract class SupervisorRepository {
  // 1. جلب تفاصيل المشرف (عدد المجموعات الحالي والأقصى)
  Future<Either<Failure, SupervisorDetailsEntity>> getSupervisorDetails();

  // 2. تحديث الحد الأقصى للمجموعات
  Future<Either<Failure, void>> updateMaxGroups(int newMaxCount);

  // 3. جلب جميع المجموعات/المقترحات الموجهة لهذا المشرف
  Future<Either<Failure, List<ProjectGroupEntity>>> getSupervisorProposals();

  // 4. الرد على المقترح (موافقة، أو رفض مع ذكر السبب)
  Future<Either<Failure, void>> respondToProposal({
    required int groupId,
    required String
    decision, // AppProjectsStatus.approved أو AppProjectsStatus.rejected
    String? rejectionReason,
  });
}
