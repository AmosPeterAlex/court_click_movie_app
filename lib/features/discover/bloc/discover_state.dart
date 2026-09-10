import 'package:equatable/equatable.dart';
import '../domain/media_item.dart';

sealed class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object?> get props => [];
}

final class DiscoverInitial extends DiscoverState {
  const DiscoverInitial();
}

final class DiscoverLoading extends DiscoverState {
  const DiscoverLoading();
}

final class DiscoverLoaded extends DiscoverState {
  const DiscoverLoaded({
    this.featuredTitle,
    this.trendingWeekly = const [],
    this.popularNow = const [],
    this.inTheaters = const [],
    this.criticallyAcclaimed = const [],
  });

  final MediaItem? featuredTitle;
  final List<MediaItem> trendingWeekly;
  final List<MediaItem> popularNow;
  final List<MediaItem> inTheaters;
  final List<MediaItem> criticallyAcclaimed;

  @override
  List<Object?> get props => [
        featuredTitle,
        trendingWeekly,
        popularNow,
        inTheaters,
        criticallyAcclaimed,
      ];
}

final class DiscoverError extends DiscoverState {
  const DiscoverError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
