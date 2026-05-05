import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';

import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_state.dart';

class StudentProjectCubit extends Cubit<StudentProjectState> {
  final String status;
  final UploudProjectRepository repository;

  StudentProjectCubit({required this.status, required this.repository})
    : super(StudentProjectInitial());

  Future<void> fetchMyProjects() async {
    emit(StudentProjectLoading());
    final result = await repository.fetchMyProjects(status: status);
    result.fold(
      (failure) => emit(StudentProjectError(failure.message)),
      (proposals) => emit(StudentProjectLoaded(proposals)),
    );
  }
}
