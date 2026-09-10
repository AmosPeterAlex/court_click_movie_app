import 'package:equatable/equatable.dart';

sealed class PremieresEvent extends Equatable {
  const PremieresEvent();

  @override
  List<Object?> get props => [];
}

final class FetchPremieresFeed extends PremieresEvent {
  const FetchPremieresFeed();
}

final class RefreshPremieresFeed extends PremieresEvent {
  const RefreshPremieresFeed();
}
