import 'package:equatable/equatable.dart';
import '../../discover/domain/media_item.dart';

sealed class ExploreState extends Equatable {
  const ExploreState();

  @override
  List<Object?> get props => [];
}

final class ExploreInitial extends ExploreState {
  const ExploreInitial();
}

final class ExploreLoading extends ExploreState {
  const ExploreLoading();
}

final class ExploreSuggestionsLoaded extends ExploreState {
  const ExploreSuggestionsLoaded(
    this.suggestions, {
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<MediaItem> suggestions;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;

  ExploreSuggestionsLoaded copyWith({
    List<MediaItem>? suggestions,
    int? page,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return ExploreSuggestionsLoaded(
      suggestions ?? this.suggestions,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [suggestions, page, hasReachedMax, isLoadingMore];
}

final class ExploreSearchResultsLoaded extends ExploreState {
  const ExploreSearchResultsLoaded({
    required this.results,
    required this.query,
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  final List<MediaItem> results;
  final String query;
  final int page;
  final bool hasReachedMax;
  final bool isLoadingMore;

  ExploreSearchResultsLoaded copyWith({
    List<MediaItem>? results,
    String? query,
    int? page,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return ExploreSearchResultsLoaded(
      results: results ?? this.results,
      query: query ?? this.query,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [results, query, page, hasReachedMax, isLoadingMore];
}

final class ExploreEmptyResults extends ExploreState {
  const ExploreEmptyResults(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ExploreError extends ExploreState {
  const ExploreError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
