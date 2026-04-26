import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class ProjectsArchieveState {
  const ProjectsArchieveState();
}

class ProjectArchieveInitial extends ProjectsArchieveState {}

class ProjectArchieveLoading extends ProjectsArchieveState {}

class ProjectArchieveLoaded extends ProjectsArchieveState {
  final List<ProjectEntity> users;
  final int page;
  final bool hasReachedMax;

  ProjectArchieveLoaded({
    required this.users,
    required this.page,
    required this.hasReachedMax,
  });

  ProjectArchieveLoaded copyWith({
    List<ProjectEntity>? users,
    int? page,
    bool? hasReachedMax,
  }) {
    return ProjectArchieveLoaded(
      users: users ?? this.users,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProjectArchieveError extends ProjectsArchieveState {
  final String message;
  ProjectArchieveError({required this.message});
}
