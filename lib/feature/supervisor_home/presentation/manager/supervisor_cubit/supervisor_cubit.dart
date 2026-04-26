import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/entities/project_group.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/domain/repo/supervisor_repository.dart';
import 'package:graduation_management_idea_system/feature/supervisor_home/presentation/manager/supervisor_cubit/supervisor_state.dart';

class SupervisorProposalsCubit extends Cubit<SupervisorProposalsState> {
  final SupervisorRepository repository;

  SupervisorProposalsCubit({required this.repository})
    : super(ProposalsInitial());

  // ==========================================
  // 1. جلب قائمة المقترحات الموجهة للمشرف
  // ==========================================
  Future<void> fetchProposals() async {
    emit(ProposalsLoading());

    final result = await repository.getSupervisorProposals();

    result.fold(
      (failure) => emit(ProposalsError(failure.message)),
      (proposals) => emit(ProposalsLoaded(proposals)),
    );
  }

  // ==========================================
  // 2. الرد على مقترح معين (قبول أو رفض)
  // ==========================================
  Future<void> respondToProposal({
    required int groupId,
    required String
    decision, // AppProjectsStatus.approved أو AppProjectsStatus.rejected
    String? rejectionReason,
  }) async {
    // نحتفظ بالقائمة القديمة في الذاكرة لكي لا تختفي الشاشة فجأة أثناء التحميل
    final currentState = state;
    List<ProjectGroupEntity> currentProposals = [];
    if (currentState is ProposalsLoaded) {
      currentProposals = currentState.proposals;
    }

    // نظهر حالة تحميل خاصة بالزر الذي تم ضغطه
    emit(ProposalActionLoading(groupId));

    final result = await repository.respondToProposal(
      groupId: groupId,
      decision: decision,
      rejectionReason: rejectionReason,
    );

    result.fold(
      (failure) {
        // إذا فشل، نظهر رسالة الخطأ، ثم نعيد عرض القائمة كما كانت
        emit(ProposalsError(failure.message));
        if (currentProposals.isNotEmpty) {
          emit(ProposalsLoaded(currentProposals));
        }
      },
      (_) {
        // إذا نجح الرد، نظهر رسالة نجاح
        final actionMessage = decision == AppProjectsStatus.approved
            ? 'تم قبول المقترح بنجاح'
            : 'تم رفض المقترح';
        emit(ProposalActionSuccess(actionMessage));

        // ثم نعيد جلب القائمة من السيرفر لتتحدث الألوان/الحالات أمام المشرف
        fetchProposals();
      },
    );
  }
}
