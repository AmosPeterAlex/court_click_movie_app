import 'package:equatable/equatable.dart';
import '../../discover/domain/media_item.dart';

sealed class PremieresState extends Equatable {
  const PremieresState();

  @override
  List<Object?> get props => [];
}

final class PremieresInitial extends PremieresState {
  const PremieresInitial();
}

final class PremieresLoading extends PremieresState {
  const PremieresLoading();
}

final class PremieresLoaded extends PremieresState {
  const PremieresLoaded({
    this.notificationPreviews = const [],
    this.upcomingFeed = const [],
  });

  final List<MediaItem> notificationPreviews;
  final List<MediaItem> upcomingFeed;

  @override
  List<Object?> get props => [notificationPreviews, upcomingFeed];
}

final class PremieresError extends PremieresState {
  const PremieresError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
