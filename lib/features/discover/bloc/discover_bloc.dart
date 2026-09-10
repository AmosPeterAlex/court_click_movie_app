import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/catalog_repository.dart';
import '../domain/media_item.dart';
import 'discover_event.dart';
import 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  DiscoverBloc({required this.repository}) : super(const DiscoverInitial()) {
    on<FetchCatalogFeed>(_onFetchCatalogFeed);
    on<RefreshCatalogFeed>(_onRefreshCatalogFeed);
  }

  final CatalogRepository repository;

  Future<void> _onFetchCatalogFeed(
    FetchCatalogFeed event,
    Emitter<DiscoverState> emit,
  ) async {
    emit(const DiscoverLoading());
    await _loadCatalog(emit);
  }

  Future<void> _onRefreshCatalogFeed(
    RefreshCatalogFeed event,
    Emitter<DiscoverState> emit,
  ) async {
    await _loadCatalog(emit);
  }

  Future<void> _loadCatalog(Emitter<DiscoverState> emit) async {
    final results = await Future.wait([
      repository.fetchWeeklyTrends(),
      repository.fetchPopularTitles(),
      repository.fetchInTheaters(),
      repository.fetchCriticallyAcclaimed(),
    ]);

    final trendsRes = results[0];
    final popularRes = results[1];
    final nowPlayingRes = results[2];
    final topRatedRes = results[3];

    final hasAnySuccess = trendsRes.isSuccess ||
        popularRes.isSuccess ||
        nowPlayingRes.isSuccess ||
        topRatedRes.isSuccess;

    if (!hasAnySuccess) {
      final firstError = trendsRes.errorOrNull?.message ??
          'Failed to connect to the catalog server. Please check your internet connection.';
      emit(DiscoverError(firstError));
      return;
    }

    final trends = trendsRes.dataOrNull ?? const <MediaItem>[];
    final popular = popularRes.dataOrNull ?? const <MediaItem>[];
    final inTheaters = nowPlayingRes.dataOrNull ?? const <MediaItem>[];
    final topRated = topRatedRes.dataOrNull ?? const <MediaItem>[];

    final featured = trends.isNotEmpty
        ? trends.first
        : (popular.isNotEmpty ? popular.first : null);

    emit(
      DiscoverLoaded(
        featuredTitle: featured,
        trendingWeekly: trends,
        popularNow: popular,
        inTheaters: inTheaters,
        criticallyAcclaimed: topRated,
      ),
    );
  }
}
