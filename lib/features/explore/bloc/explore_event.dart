import 'package:equatable/equatable.dart';

sealed class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

final class LoadExploreSuggestions extends ExploreEvent {
  const LoadExploreSuggestions();
}

final class SearchQueryChanged extends ExploreEvent {
  const SearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class ClearSearchQuery extends ExploreEvent {
  const ClearSearchQuery();
}
