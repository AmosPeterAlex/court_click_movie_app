import 'package:get_it/get_it.dart';
import '../../features/discover/bloc/discover_bloc.dart';
import '../../features/discover/data/catalog_remote_source.dart';
import '../../features/discover/data/catalog_repository_impl.dart';
import '../../features/discover/domain/catalog_repository.dart';
import '../../features/explore/bloc/explore_bloc.dart';
import '../../features/explore/data/explore_remote_source.dart';
import '../../features/explore/data/explore_repository_impl.dart';
import '../../features/explore/domain/explore_repository.dart';
import '../../features/premieres/bloc/premieres_bloc.dart';
import '../../features/premieres/data/premieres_remote_source.dart';
import '../../features/premieres/data/premieres_repository_impl.dart';
import '../../features/premieres/domain/premieres_repository.dart';
import '../../foundation/http/rest_client.dart';
import '../../foundation/theme/theme_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Theme Cubit
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());

  // Network Client
  sl.registerLazySingleton<RestClient>(() => RestClient());

  // Discover / Catalog Feature
  sl.registerLazySingleton<CatalogRemoteSource>(
    () => CatalogRemoteSource(restClient: sl()),
  );
  sl.registerLazySingleton<CatalogRepository>(
    () => CatalogRepositoryImpl(remoteSource: sl()),
  );
  sl.registerFactory<DiscoverBloc>(
    () => DiscoverBloc(repository: sl()),
  );

  // Explore / Search Feature
  sl.registerLazySingleton<ExploreRemoteSource>(
    () => ExploreRemoteSource(restClient: sl()),
  );
  sl.registerLazySingleton<ExploreRepository>(
    () => ExploreRepositoryImpl(remoteSource: sl()),
  );
  sl.registerFactory<ExploreBloc>(
    () => ExploreBloc(repository: sl()),
  );

  // Premieres / Upcoming Feature
  sl.registerLazySingleton<PremieresRemoteSource>(
    () => PremieresRemoteSource(restClient: sl()),
  );
  sl.registerLazySingleton<PremieresRepository>(
    () => PremieresRepositoryImpl(remoteSource: sl()),
  );
  sl.registerFactory<PremieresBloc>(
    () => PremieresBloc(repository: sl()),
  );
}
