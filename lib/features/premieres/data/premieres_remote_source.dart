import 'package:dio/dio.dart';
import '../../../foundation/constants/tmdb_endpoints.dart';
import '../../../foundation/http/rest_client.dart';

class PremieresRemoteSource {
  PremieresRemoteSource({required RestClient restClient}) : _dio = restClient.dio;

  final Dio _dio;

  Future<List<dynamic>> getUpcomingMovies() async {
    final response = await _dio.get(TmdbEndpoints.upcomingMovies);
    return (response.data['results'] as List<dynamic>?) ?? [];
  }
}
