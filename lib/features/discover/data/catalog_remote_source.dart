import 'package:dio/dio.dart';
import '../../../foundation/constants/tmdb_endpoints.dart';
import '../../../foundation/http/rest_client.dart';

class CatalogRemoteSource {
  CatalogRemoteSource({required RestClient restClient}) : _dio = restClient.dio;

  final Dio _dio;

  Future<List<dynamic>> getWeeklyTrends() async {
    final response = await _dio.get(TmdbEndpoints.weeklyTrends);
    return (response.data['results'] as List<dynamic>?) ?? [];
  }

  Future<List<dynamic>> getPopularTitles() async {
    final response = await _dio.get(TmdbEndpoints.popularMovies);
    return (response.data['results'] as List<dynamic>?) ?? [];
  }

  Future<List<dynamic>> getInTheaters() async {
    final response = await _dio.get(TmdbEndpoints.nowPlayingMovies);
    return (response.data['results'] as List<dynamic>?) ?? [];
  }

  Future<List<dynamic>> getCriticallyAcclaimed() async {
    final response = await _dio.get(TmdbEndpoints.topRatedMovies);
    return (response.data['results'] as List<dynamic>?) ?? [];
  }
}
