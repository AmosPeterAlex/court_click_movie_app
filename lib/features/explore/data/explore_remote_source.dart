import 'package:dio/dio.dart';
import '../../../foundation/constants/tmdb_endpoints.dart';
import '../../../foundation/http/rest_client.dart';

class ExploreRemoteSource {
  ExploreRemoteSource({required RestClient restClient}) : _dio = restClient.dio;

  final Dio _dio;

  Future<List<dynamic>> searchMovies(String query, {int page = 1}) async {
    final response = await _dio.get(
      TmdbEndpoints.searchMovie,
      queryParameters: {
        'query': query,
        'page': page,
      },
    );
    return (response.data['results'] as List<dynamic>?) ?? [];
  }

  Future<List<dynamic>> getSuggestedSearches({int page = 1}) async {
    final response = await _dio.get(
      TmdbEndpoints.popularMovies,
      queryParameters: {
        'page': page,
      },
    );
    return (response.data['results'] as List<dynamic>?) ?? [];
  }
}
