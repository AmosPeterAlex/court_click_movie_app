import 'package:flutter/material.dart';
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
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      ),
      GoRoute(
        path: '/profiles',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfilePickerScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/main',
        pageBuilder: (context, state) {
          final profileName = (state.extra as String?) ?? 'Emenalo';
          return CustomTransitionPage(
            key: state.pageKey,
            child: MultiBlocProvider(
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
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
