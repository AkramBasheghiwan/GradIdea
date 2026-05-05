import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/projects/domain/repository/projects_repository.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_event.dart';
import 'package:graduation_management_idea_system/feature/projects/presentation/manager/search_projects_cubit/search_projects_status.dart';
import 'package:rxdart/rxdart.dart'; // لعمل Debounce

class ProjectSearchBloc extends Bloc<ProjectSearchEvent, ProjectSearchState> {
  final ProjectsRepository repository;

  ProjectSearchBloc(this.repository) : super(ProjectSearchInitial()) {
    EventTransformer<T> debounceAndCancel<T>(Duration duration) {
      return (events, mapper) =>
          events.debounceTime(duration).switchMap(mapper);
    }

    EventTransformer<T> dropDelay<T>() {
      return (events, mapper) => events.exhaustMap(mapper);
    }

    EventTransformer<T> restartableCustom<T>() {
      return (events, mapper) => events.switchMap(mapper);
    }

    on<SearchTextChanged>(
      _onSearchTextChanged,
      transformer: debounceAndCancel(const Duration(microseconds: 500)),
    );

    on<SearchFiltersApplied>(
      _onSearchFiltersApplied,
      transformer: restartableCustom(),
    );

    on<FetchNextProjectPage>(_onFetchNextPage, transformer: dropDelay());
  }

  // --- دوال المعالجة (Handlers) ---

  Future<void> _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<ProjectSearchState> emit,
  ) async {
    // نحافظ على الفلاتر القديمة إذا كانت موجودة
    String? dept, year;
    if (state is ProjectSearchLoaded) {
      dept = (state as ProjectSearchLoaded).currentDept;
      year = (state as ProjectSearchLoaded).currentYear;
    }
    await _performSearch(event.query, dept, year, emit);
  }

  Future<void> _onSearchFiltersApplied(
    SearchFiltersApplied event,
    Emitter<ProjectSearchState> emit,
  ) async {
    String query = '';
    if (state is ProjectSearchLoaded) {
      query = (state as ProjectSearchLoaded).currentQuery;
    }
    await _performSearch(query, event.department, event.year, emit);
  }

  Future<void> _performSearch(
    String query,
    String? dept,
    String? year,
    Emitter<ProjectSearchState> emit,
  ) async {
    emit(ProjectSearchLoading());
    final result = await repository.searchProjects(
      query: query,
      department: dept,
      year: year,
      page: 0,
    );

    result.fold(
      (failure) => emit(ProjectSearchError(failure.message)),
      (projects) => emit(
        ProjectSearchLoaded(
          projects: projects,
          hasReachedMax: projects.length < 15,
          currentPage: 0,
          currentQuery: query,
          currentDept: dept,
          currentYear: year,
        ),
      ),
    );
  }

  Future<void> _onFetchNextPage(
    FetchNextProjectPage event,
    Emitter<ProjectSearchState> emit,
  ) async {
    if (state is! ProjectSearchLoaded) return;
    final currentState = state as ProjectSearchLoaded;
    if (currentState.hasReachedMax) return;

    final nextPage = currentState.currentPage + 1;
    final result = await repository.searchProjects(
      query: currentState.currentQuery,
      department: currentState.currentDept,
      year: currentState.currentYear,
      page: nextPage,
    );

    result.fold(
      (failure) {
        emit(currentState.copyWith(paginationError: failure.message));
        emit(currentState.copyWith(clearError: true));
      },
      (newProjects) {
        emit(
          currentState.copyWith(
            projects: List.of(currentState.projects)..addAll(newProjects),
            hasReachedMax: newProjects.length < 15,
            currentPage: nextPage,
          ),
        );
      },
    );
  }
}
