import 'package:equatable/equatable.dart';

sealed class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object?> get props => [];
}

final class FetchCatalogFeed extends DiscoverEvent {
  const FetchCatalogFeed();
}

final class RefreshCatalogFeed extends DiscoverEvent {
  const RefreshCatalogFeed();
}
