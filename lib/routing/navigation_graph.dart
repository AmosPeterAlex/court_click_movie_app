import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:court_click_movie_app/core/service_locator/app_injector.dart';
import 'package:court_click_movie_app/features/discover/bloc/discover_bloc.dart';
import 'package:court_click_movie_app/features/explore/bloc/explore_bloc.dart';
import 'package:court_click_movie_app/features/launch/splash_screen.dart';
import 'package:court_click_movie_app/features/premieres/bloc/premieres_bloc.dart';
import 'package:court_click_movie_app/features/user_accounts/profile_picker_screen.dart';
import 'package:court_click_movie_app/routing/main_scaffold.dart';

abstract final class NavigationGraph {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/profiles',
        builder: (context, state) => const ProfilePickerScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) {
          final profileName = (state.extra as String?) ?? 'Emenalo';
          return MultiBlocProvider(
            providers: [
              BlocProvider<DiscoverBloc>(
                create: (_) => sl<DiscoverBloc>(),
              ),
              BlocProvider<ExploreBloc>(
                create: (_) => sl<ExploreBloc>(),
              ),
              BlocProvider<PremieresBloc>(
                create: (_) => sl<PremieresBloc>(),
              ),
            ],
            child: MainScaffold(profileName: profileName),
          );
        },
      ),
    ],
  );
}
