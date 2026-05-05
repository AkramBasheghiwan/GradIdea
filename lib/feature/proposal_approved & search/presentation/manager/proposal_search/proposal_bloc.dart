import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/domain/repository/proposal_approved_repository.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_search/proposal_event.dart';
import 'package:graduation_management_idea_system/feature/proposal_approved%20&%20search/presentation/manager/proposal_search/proposal_state.dart';

import 'package:rxdart/rxdart.dart'; // لعمل Debounce

class ProposalSearchBloc
    extends Bloc<ProposalSearchEvent, ProposalSearchState> {
  final ProposalApprovedRepository repository;

  ProposalSearchBloc(this.repository) : super(ProposalSearchInitial()) {
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

    on<FetchNextProposalPage>(_onFetchNextPage, transformer: dropDelay());
  }

  // --- دوال المعالجة (Handlers) ---

  Future<void> _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<ProposalSearchState> emit,
  ) async {
    // نحافظ على الفلاتر القديمة إذا كانت موجودة
    String? dept, year;
    if (state is ProposalSearchLoaded) {
      dept = (state as ProposalSearchLoaded).currentDept;
      year = (state as ProposalSearchLoaded).currentYear;
    }
    await _performSearch(event.query, dept, year, emit);
  }

  Future<void> _onSearchFiltersApplied(
    SearchFiltersApplied event,
    Emitter<ProposalSearchState> emit,
  ) async {
    String query = '';
    if (state is ProposalSearchLoaded) {
      query = (state as ProposalSearchLoaded).currentQuery;
    }
    await _performSearch(query, event.department, event.year, emit);
  }

  Future<void> _performSearch(
    String query,
    String? dept,
    String? year,
    Emitter<ProposalSearchState> emit,
  ) async {
    emit(ProposalSearchLoading());
    final result = await repository.searchProposals(
      query: query,
      department: dept,
      year: year,
      page: 0,
    );

    result.fold(
      (failure) => emit(ProposalSearchError(failure.message)),
      (projects) => emit(
        ProposalSearchLoaded(
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
    FetchNextProposalPage event,
    Emitter<ProposalSearchState> emit,
  ) async {
    if (state is! ProposalSearchLoaded) return;
    final currentState = state as ProposalSearchLoaded;
    if (currentState.hasReachedMax) return;

    final nextPage = currentState.currentPage + 1;
    final result = await repository.searchProposals(
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
