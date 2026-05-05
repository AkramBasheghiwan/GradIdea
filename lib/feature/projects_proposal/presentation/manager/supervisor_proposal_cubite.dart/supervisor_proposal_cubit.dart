import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/project_proposal_repository.dart';
import 'supervior_proposal_state.dart';

class ProjectProposalCubit extends Cubit<ProjectProposalState> {
  final String status;
  final ProjectProposalRepository repository;

  ProjectProposalCubit({required this.status, required this.repository})
    : super(ProjectProposalInitial());

  Future<void> fetchProposalsToSupervisor() async {
    emit(ProjectProposalLoading());
    final result = await repository.getProposalToSupervisor(status);
    result.fold(
      (failure) => emit(ProjectProposalError(failure.message)),
      (proposals) => emit(ProjectProposalLoaded(proposals)),
    );
  }

  Future<void> acceptProposal(int id) async {
    emit(ProjectProposalLoading());
    final result = await repository.updateProposalStatus(
      id: id,
      status: AppProjectsStatus.approved,
    );

    result.fold((failure) => emit(ProjectProposalError(failure.message)), (_) {
      emit(const ProjectProposalActionSuccess("تم قبول المشروع بنجاح ✅"));
      fetchProposalsToSupervisor();
    });
  }

  Future<void> rejectProposal(int id, String reason) async {
    emit(ProjectProposalLoading());
    final result = await repository.updateProposalStatus(
      id: id,
      status: AppProjectsStatus.rejected,
      reason: reason,
    );

    result.fold((failure) => emit(ProjectProposalError(failure.message)), (_) {
      emit(
        const ProjectProposalActionSuccess(
          "تم رفض المقترح وإرسال السبب للطلاب ❌",
        ),
      );
      fetchProposalsToSupervisor();
    });
  }

  // 5. حذف مقترح مشروع
  Future<void> deleteProposal(int id) async {
    emit(ProjectProposalLoading());
    final result = await repository.deleteProjectProposal(id);

    result.fold((failure) => emit(ProjectProposalError(failure.message)), (_) {
      emit(const ProjectProposalActionSuccess("تم حذف المقترح بنجاح"));
      fetchProposalsToSupervisor();
    });
  }
}
