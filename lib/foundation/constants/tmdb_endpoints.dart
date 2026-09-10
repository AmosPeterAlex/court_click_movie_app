abstract final class TmdbEndpoints {
  // Base URLs
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String posterBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String originalImageBaseUrl = 'https://image.tmdb.org/t/p/original';

  // API Endpoints
  static const String weeklyTrends = '/trending/all/week';
  static const String popularMovies = '/movie/popular';
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';
  static const String searchMovie = '/search/movie';
  static const String searchMulti = '/search/multi';

  // Compile-time credentials passed via --dart-define
  static const String _envApiKey = String.fromEnvironment(
    'TMDB_API_KEY',
    defaultValue: String.fromEnvironment('TMDB_KEY', defaultValue: ''),
  );

  static const String _envBearerToken = String.fromEnvironment(
    'TMDB_TOKEN',
    defaultValue: String.fromEnvironment('TMDB_BEARER_TOKEN', defaultValue: ''),
  );

  static String get apiKey => _envApiKey;
  static String get bearerToken => _envBearerToken;
  static bool get hasAuth => _envApiKey.isNotEmpty || _envBearerToken.isNotEmpty;
}
