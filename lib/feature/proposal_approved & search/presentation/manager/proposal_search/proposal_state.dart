import 'package:equatable/equatable.dart';
import 'package:graduation_management_idea_system/feature/projects_proposal/domain/entities/project_proposals.dart';

abstract class ProposalSearchState extends Equatable {
  const ProposalSearchState();
  @override
  List<Object?> get props => [];
}

class ProposalSearchInitial extends ProposalSearchState {}

class ProposalSearchLoading extends ProposalSearchState {}

class ProposalSearchError extends ProposalSearchState {
  final String message;
  const ProposalSearchError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProposalSearchLoaded extends ProposalSearchState {
  final List<ProjectProposals> projects;
  final bool hasReachedMax;
  final int currentPage;

  // حفظ الفلاتر الحالية مهم جداً للـ Pagination
  final String currentQuery;
  final String? currentDept;
  final String? currentYear;
  final String? paginationError;

  const ProposalSearchLoaded({
    required this.projects,
    required this.hasReachedMax,
    required this.currentPage,
    required this.currentQuery,
    this.currentDept,
    this.currentYear,
    this.paginationError,
  });

  ProposalSearchLoaded copyWith({
    List<ProjectProposals>? projects,
    bool? hasReachedMax,
    int? currentPage,
    String? currentQuery,
    String? currentDept,
    String? currentYear,
    String? paginationError,
    bool clearError = false,
  }) {
    return ProposalSearchLoaded(
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
