import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/premieres_repository.dart';
import 'premieres_event.dart';
import 'premieres_state.dart';

class PremieresBloc extends Bloc<PremieresEvent, PremieresState> {
  PremieresBloc({required this.repository}) : super(const PremieresInitial()) {
    on<FetchPremieresFeed>(_onFetchPremieresFeed);
    on<RefreshPremieresFeed>(_onRefreshPremieresFeed);
  }

  final PremieresRepository repository;

  Future<void> _onFetchPremieresFeed(
    FetchPremieresFeed event,
    Emitter<PremieresState> emit,
  ) async {
    emit(const PremieresLoading());
    await _loadPremieres(emit);
  }

  Future<void> _onRefreshPremieresFeed(
    RefreshPremieresFeed event,
    Emitter<PremieresState> emit,
  ) async {
    await _loadPremieres(emit);
  }

  Future<void> _loadPremieres(Emitter<PremieresState> emit) async {
    final result = await repository.fetchUpcomingReleases();
    result.when(
      onSuccess: (items) {
        if (items.isEmpty) {
          emit(const PremieresLoaded());
          return;
        }
        final notifications = items.take(2).toList();
        final upcoming = items.length > 2 ? items.sublist(2) : items;
        emit(
          PremieresLoaded(
            notificationPreviews: notifications,
            upcomingFeed: upcoming,
          ),
        );
      },
      onFailure: (error) => emit(PremieresError(error.message)),
    );
  }
}
