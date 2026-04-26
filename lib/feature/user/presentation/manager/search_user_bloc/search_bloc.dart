// ==========================================
// 3. الـ Bloc والـ Transformer
// ==========================================
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_management_idea_system/feature/user/domain/repository/search_user_repository.dart';
import 'package:graduation_management_idea_system/feature/user/presentation/manager/search_user_bloc/search_state_event.dart';

EventTransformer<T> debounceAndCancel<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

// لاحظ أننا نستخدم droppable للتمرير اللانهائي لكي لا يطلب الصفحة مرتين بالخطأ
EventTransformer<T> dropDelay<T>() {
  return (events, mapper) =>
      events.exhaustMap(mapper); // أو droppable في bloc_concurrency
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUserRepository repository;

  SearchBloc(this.repository) : super(SearchInitial()) {
    // 1. عند البحث لأول مرة (استخدام الـ Debounce)
    on<SearchQueryChanged>(
      _onSearchQueryChanged,
      transformer: debounceAndCancel(const Duration(milliseconds: 500)),
    );

    // 2. عند طلب الصفحة التالية (بدون Debounce، لكن نمنع الطلبات المتزامنة)
    on<FetchNextPage>(_onFetchNextPage, transformer: dropDelay());

    on<ClearSearch>((event, emit) => emit(SearchInitial()));
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await repository.searchUser(query: query, page: 0);

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (newUsers) => emit(
        SearchLoaded(
          users: newUsers,
          hasReachedMax: newUsers.length < 15,
          currentPage: 0,
          currentQuery: query,
        ),
      ),
    );
  }

  Future<void> _onFetchNextPage(
    FetchNextPage event,
    Emitter<SearchState> emit,
  ) async {
    if (state is! SearchLoaded) return;

    final currentState = state as SearchLoaded;
    if (currentState.hasReachedMax) return;

    final nextPage = currentState.currentPage + 1;

    final result = await repository.searchUser(
      query: currentState.currentQuery,
      page: nextPage,
    );

    result.fold((failure) => emit(SearchError(failure.message)), (moreUsers) {
      emit(
        currentState.copyWith(
          users: List.of(currentState.users)..addAll(moreUsers),
          hasReachedMax: moreUsers.length < 15,
          currentPage: nextPage,
        ),
      );
    });
  }
}
