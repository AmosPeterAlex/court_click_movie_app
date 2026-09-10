import 'package:dio/dio.dart';
import '../../../foundation/constants/tmdb_endpoints.dart';
import '../../../foundation/http/rest_client.dart';

class ExploreRemoteSource {
  ExploreRemoteSource({required RestClient restClient}) : _dio = restClient.dio;

  final Dio _dio;

  Future<List<dynamic>> searchMovies(String query) async {
    final response = await _dio.get(
      TmdbEndpoints.searchMovie,
      queryParameters: {'query': query},
    );
    return (response.data['results'] as List<dynamic>?) ?? [];
  }

  Future<List<dynamic>> getSuggestedSearches() async {
    final response = await _dio.get(TmdbEndpoints.popularMovies);
    return (response.data['results'] as List<dynamic>?) ?? [];
  }
}
