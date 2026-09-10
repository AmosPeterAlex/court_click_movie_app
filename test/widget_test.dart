import 'package:flutter_test/flutter_test.dart';
import 'package:court_click_movie_app/core/service_locator/app_injector.dart';
import 'package:court_click_movie_app/main.dart';
import 'package:court_click_movie_app/features/launch/splash_screen.dart';

void main() {
  setUp(() async {
    await setupServiceLocator();
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('CourtClickMovieApp launches with SplashScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const CourtClickMovieApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
