import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_management_idea_system/feature/idea_validation/domain/repository/get_project_repository.dart';
import 'package:graduation_management_idea_system/feature/idea_validation/presentation/manager/get_project_detail/get_project_state.dart';

class GetProjectCubit extends Cubit<GetProjectState> {
  final GetProjectRepository repository;
  GetProjectCubit(this.repository) : super(GetProjectInitail());

  Future<void> getProjectDetaile(String projectId) async {
    emit(GetProjectLoading());
    final result = await repository.getProjectDetaile(projectId);

    result.fold(
      (failure) => emit(GetProjectError(message: failure.message)),
      (project) => emit(GetProjectLoaded(project: project)),
    );
  }
}
