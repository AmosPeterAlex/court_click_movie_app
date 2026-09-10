import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/explore_repository.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({required this.repository}) : super(const ExploreInitial()) {
    on<LoadExploreSuggestions>(_onLoadExploreSuggestions);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ClearSearchQuery>(_onClearSearchQuery);
    on<LoadMoreResults>(_onLoadMoreResults);
    on<RefreshExplore>(_onRefreshExplore);
  }

  final ExploreRepository repository;

  Future<void> _onLoadExploreSuggestions(
    LoadExploreSuggestions event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreLoading());
    final result = await repository.fetchSuggestedSearches(page: 1);
    result.when(
      onSuccess: (items) => emit(ExploreSuggestionsLoaded(items, page: 1)),
      onFailure: (error) => emit(ExploreError(error.message)),
    );
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChanged event,
    Emitter<ExploreState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) {
      add(const LoadExploreSuggestions());
      return;
    }

    emit(const ExploreLoading());
    final result = await repository.queryTitles(query, page: 1);
    result.when(
      onSuccess: (items) {
        if (items.isEmpty) {
          emit(ExploreEmptyResults(query));
        } else {
          emit(ExploreSearchResultsLoaded(results: items, query: query, page: 1));
        }
      },
      onFailure: (error) => emit(ExploreError(error.message)),
    );
  }

  Future<void> _onClearSearchQuery(
    ClearSearchQuery event,
    Emitter<ExploreState> emit,
  ) async {
    add(const LoadExploreSuggestions());
  }

  Future<void> _onLoadMoreResults(
    LoadMoreResults event,
    Emitter<ExploreState> emit,
  ) async {
    final currentState = state;

    if (currentState is ExploreSearchResultsLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) return;

      emit(currentState.copyWith(isLoadingMore: true));
      final nextPage = currentState.page + 1;
      final result = await repository.queryTitles(currentState.query, page: nextPage);

      result.when(
        onSuccess: (newItems) {
          if (newItems.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true, isLoadingMore: false));
          } else {
            emit(currentState.copyWith(
              results: [...currentState.results, ...newItems],
              page: nextPage,
              isLoadingMore: false,
            ));
          }
        },
        onFailure: (_) {
          emit(currentState.copyWith(isLoadingMore: false));
        },
      );
    } else if (currentState is ExploreSuggestionsLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) return;

      emit(currentState.copyWith(isLoadingMore: true));
      final nextPage = currentState.page + 1;
      final result = await repository.fetchSuggestedSearches(page: nextPage);

      result.when(
        onSuccess: (newItems) {
          if (newItems.isEmpty) {
            emit(currentState.copyWith(hasReachedMax: true, isLoadingMore: false));
          } else {
            emit(currentState.copyWith(
              suggestions: [...currentState.suggestions, ...newItems],
              page: nextPage,
              isLoadingMore: false,
            ));
          }
        },
        onFailure: (_) {
          emit(currentState.copyWith(isLoadingMore: false));
        },
      );
    }
  }

  Future<void> _onRefreshExplore(
    RefreshExplore event,
    Emitter<ExploreState> emit,
  ) async {
    final currentState = state;
    if (currentState is ExploreSearchResultsLoaded) {
      final result = await repository.queryTitles(currentState.query, page: 1);
      result.when(
        onSuccess: (items) {
          if (items.isEmpty) {
            emit(ExploreEmptyResults(currentState.query));
          } else {
            emit(ExploreSearchResultsLoaded(results: items, query: currentState.query, page: 1));
          }
        },
        onFailure: (_) {},
      );
    } else {
      final result = await repository.fetchSuggestedSearches(page: 1);
      result.when(
        onSuccess: (items) => emit(ExploreSuggestionsLoaded(items, page: 1)),
        onFailure: (_) {},
      );
    }
  }
}
