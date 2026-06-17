import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/uploud_project.dart';

import 'package:graduation_management_idea_system/feature/projects/my_projects/presentation/manager/student_project_cubit.dart/student_project_state.dart';

class StudentProjectCubit extends Cubit<StudentProjectState> {
  final String status;
  final UploudProjectRepository repository;
  StreamSubscription? _reviewsSubscription;
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

  void getMyProjects() {
    emit(StudentProjectLoading());

    _reviewsSubscription?.cancel();

    _reviewsSubscription = repository.getMyProjects(status: status).listen((
      result,
    ) {
      result.fold(
        (failure) => emit(StudentProjectError(failure.message)),
        (proposals) => emit(StudentProjectLoaded(proposals)),
      );
    });
  }

  @override
  Future<void> close() {
    _reviewsSubscription?.cancel();
    return super.close();
  }
}
