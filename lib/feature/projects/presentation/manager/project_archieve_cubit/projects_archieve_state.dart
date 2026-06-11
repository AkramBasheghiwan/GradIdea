import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class ProjectsArchieveState {
  const ProjectsArchieveState();
}

class ProjectArchieveInitial extends ProjectsArchieveState {}

class ProjectArchieveLoading extends ProjectsArchieveState {}

class ProjectArchieveLoaded extends ProjectsArchieveState {
  final List<ProjectEntity> projects;
  final int page;
  final bool hasReachedMax;

  ProjectArchieveLoaded({
    required this.projects,
    required this.page,
    required this.hasReachedMax,
  });

  ProjectArchieveLoaded copyWith({
    List<ProjectEntity>? projects,
    int? page,
    bool? hasReachedMax,
  }) {
    return ProjectArchieveLoaded(
      projects: projects ?? this.projects,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class ProjectArchieveError extends ProjectsArchieveState {
  final String message;
  ProjectArchieveError({required this.message});
}
