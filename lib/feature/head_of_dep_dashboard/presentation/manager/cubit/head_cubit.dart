import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/feature/head_of_dep_dashboard/presentation/manager/cubit/head_state.dart';

import '../../../domain/head_repo/head_repository.dart';


class HeadOfDepartmentCubit extends Cubit<HeadOfDepartmentState> {
  final HeadRepository repository;

  HeadOfDepartmentCubit({required this.repository}) : super(HeadOfDepartmentInitial());

  // --- دالة جلب المشاريع المعلقة ---
  Future<void> getPendingProjects() async {
    emit(HeadOfDepartmentLoading());
    final result = await repository.getPendingProjects();

    result.fold(
      (failure) => emit(HeadOfDepartmentError(failure.message)),
      (projects) => emit(HeadOfDepartmentLoaded(projects)),
    );
  }

  
  Future<void> approveProject(String projectId) async {
    // يمكنك استخدام هذه الحالة لإظهار مؤشر تحميل خاص بالعنصر الذي يتم تحديثه
    // emit(HeadOfDepartmentProjectUpdating(projectId));

    final result = await repository.approveProject(projectId);

    result.fold(
      (failure) => emit(HeadOfDepartmentError(failure.message)),
      (success) {
        // بعد النجاح، أعد جلب القائمة المحدثة
        getPendingProjects();
        // يمكنك أيضًا إرسال حالة خاصة لإظهار رسالة نجاح
        // emit(HeadOfDepartmentUpdateSuccess('Project Approved Successfully!'));
      },
    );
  }

  // --- دالة رفض المشروع ---
  Future<void> rejectProject(String projectId, String reason) async {
    // emit(HeadOfDepartmentProjectUpdating(projectId));

    final result = await repository.rejectProject(projectId, reason);

    result.fold(
      (failure) => emit(HeadOfDepartmentError(failure.message)),
      (success) {
        // بعد النجاح، أعد جلب القائمة المحدثة
        getPendingProjects();
        // emit(HeadOfDepartmentUpdateSuccess('Project Rejected Successfully!'));
      },
    );
  }
}
