import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/entities/project_entity.dart';

abstract class ProjectSearchState extends Equatable {
  const ProjectSearchState();
  @override
  List<Object?> get props => [];
}

class ProjectSearchInitial extends ProjectSearchState {}

class ProjectSearchLoading extends ProjectSearchState {}

class ProjectSearchError extends ProjectSearchState {
  final String message;
  const ProjectSearchError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProjectSearchLoaded extends ProjectSearchState {
  final List<ProjectEntity> projects;
  final bool hasReachedMax;
  final int currentPage;

  // حفظ الفلاتر الحالية مهم جداً للـ Pagination
  final String currentQuery;
  final String? currentDept;
  final String? currentYear;
  final String? paginationError;

  const ProjectSearchLoaded({
    required this.projects,
    required this.hasReachedMax,
    required this.currentPage,
    required this.currentQuery,
    this.currentDept,
    this.currentYear,
    this.paginationError,
  });

  ProjectSearchLoaded copyWith({
    List<ProjectEntity>? projects,
    bool? hasReachedMax,
    int? currentPage,
    String? currentQuery,
    String? currentDept,
    String? currentYear,
    String? paginationError,
    bool clearError = false,
  }) {
    return ProjectSearchLoaded(
      projects: projects ?? this.projects,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentQuery: currentQuery ?? this.currentQuery,
      currentDept: currentDept ?? this.currentDept,
      currentYear: currentYear ?? this.currentYear,
      paginationError: clearError
          ? null
          : (paginationError ?? this.paginationError),
    );
  }

  @override
  List<Object?> get props => [
    projects,
    hasReachedMax,
    currentPage,
    currentQuery,
    currentDept,
    currentYear,
    paginationError,
  ];
}
