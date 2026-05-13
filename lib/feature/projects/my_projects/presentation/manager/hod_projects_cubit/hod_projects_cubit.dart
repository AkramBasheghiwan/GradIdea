import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/core/utils/app_projects_status.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';
import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/hod_projects_cubit/hod_projects_state.dart';

class HodProjectsCubit extends Cubit<HodProjectsState> {
  final String status;
  final String departmentId;
  final UploudProjectRepository repository;

  HodProjectsCubit({
    required this.status,
    required this.repository,
    required this.departmentId,
  }) : super(HodProjectsInitial());

  Future<void> fetchAllProjectsByDepartment() async {
    emit(HodProjectsLoading());
    final result = await repository.fetchAllProjectsByDepartment(
      departmentId: departmentId,
      status: status,
    );
    result.fold(
      (failure) => emit(HodProjectsError(failure.message)),
      (proposals) => emit(HodProjectsLoaded(proposals)),
    );
  }

  Future<void> acceptProposal(String projectId) async {
    emit(HodProjectsLoading());
    final result = await repository.updateProjectStatus(projectId);

    result.fold((failure) => emit(HodProjectsError(failure.message)), (_) {
      emit(const HodProjectsActionSuccess("تم قبول المشروع بنجاح ✅"));
      fetchAllProjectsByDepartment();
    });
  }

  Future<void> rejectProposal(String id, String reason) async {
    emit(HodProjectsLoading());
    final result = await repository.updateProjectsStatusReject(
      id: id,
      status: AppProjectsStatus.rejected,
      reason: reason,
    );

    result.fold((failure) => emit(HodProjectsError(failure.message)), (_) {
      emit(
        const HodProjectsActionSuccess("تم رفض المقترح وإرسال السبب للطلاب ❌"),
      );
      fetchAllProjectsByDepartment();
    });
  }

  // 5. حذف مقترح مشروع
  Future<void> deleteProposal(int id) async {
    emit(HodProjectsLoading());
    final result = await repository.deleteProject(id.toString());

    result.fold((failure) => emit(HodProjectsError(failure.message)), (_) {
      emit(const HodProjectsActionSuccess("تم حذف المقترح بنجاح"));
      fetchAllProjectsByDepartment();
    });
  }
}
