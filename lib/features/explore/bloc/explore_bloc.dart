import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/explore_repository.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc({required this.repository}) : super(const ExploreInitial()) {
    on<LoadExploreSuggestions>(_onLoadExploreSuggestions);
    on<SearchQueryChanged>(_onSearchQueryChanged);
    on<ClearSearchQuery>(_onClearSearchQuery);
  }

  final ExploreRepository repository;

  Future<void> _onLoadExploreSuggestions(
    LoadExploreSuggestions event,
    Emitter<ExploreState> emit,
  ) async {
    emit(const ExploreLoading());
    final result = await repository.fetchSuggestedSearches();
    result.when(
      onSuccess: (items) => emit(ExploreSuggestionsLoaded(items)),
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
    final result = await repository.queryTitles(query);
    result.when(
      onSuccess: (items) {
        if (items.isEmpty) {
          emit(ExploreEmptyResults(query));
        } else {
          emit(ExploreSearchResultsLoaded(results: items, query: query));
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
}
