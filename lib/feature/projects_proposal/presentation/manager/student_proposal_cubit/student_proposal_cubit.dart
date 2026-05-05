import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/repository/student_project_proposal_repository.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/presentation/manager/student_proposal_cubit/student_proposal_state.dart';

class StudentProposalCubit extends Cubit<StudentProposalState> {
  final String status;
  final StudentProjectProposalRepository repository;

  StudentProposalCubit({required this.status, required this.repository})
    : super(StudentProposalInitial());

  // 1. جلب المقترحات الخاصة بالمشرف
  Future<void> fetchMyProposals() async {
    emit(StudentProposalLoading());
    final result = await repository.getMyProposals(status);
    result.fold(
      (failure) => emit(StudentProposalError(failure.message)),
      (proposals) => emit(StudentProposalLoaded(proposals)),
    );
  }
}
