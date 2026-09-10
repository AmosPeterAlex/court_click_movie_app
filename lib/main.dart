import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/service_locator/app_injector.dart';
import 'features/user_accounts/bloc/active_profile_cubit.dart';
import 'foundation/helpers/debug_tracer.dart';
import 'foundation/theme/stream_theme.dart';
import 'foundation/theme/theme_cubit.dart';
import 'routing/navigation_graph.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  Bloc.observer = StreamBlocObserver();

  runApp(const CourtClickMovieApp());
}

class CourtClickMovieApp extends StatelessWidget {
  const CourtClickMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: sl<ThemeCubit>()),
        BlocProvider<ActiveProfileCubit>.value(value: sl<ActiveProfileCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Court Click Test',
            debugShowCheckedModeBanner: false,
            theme: StreamTheme.lightTheme,
            darkTheme: StreamTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: NavigationGraph.router,
          );
        },
      ),
    );
  }
}
