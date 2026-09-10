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
  const ExploreSuggestionsLoaded(this.suggestions);

  final List<MediaItem> suggestions;

  @override
  List<Object?> get props => [suggestions];
}

final class ExploreSearchResultsLoaded extends ExploreState {
  const ExploreSearchResultsLoaded({
    required this.results,
    required this.query,
  });

  final List<MediaItem> results;
  final String query;

  @override
  List<Object?> get props => [results, query];
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
