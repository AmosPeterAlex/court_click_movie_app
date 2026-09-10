import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/service_locator/app_injector.dart';
import 'foundation/helpers/debug_tracer.dart';
import 'foundation/theme/stream_theme.dart';
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
    return MaterialApp.router(
      title: 'StreamPulse',
      debugShowCheckedModeBanner: false,
      theme: StreamTheme.darkTheme,
      routerConfig: NavigationGraph.router,
    );
  }
}
