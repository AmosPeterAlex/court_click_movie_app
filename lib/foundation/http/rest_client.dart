import 'package:dio/dio.dart';
import '../constants/tmdb_endpoints.dart';
import '../helpers/debug_tracer.dart';

class RestClient {
  RestClient({Dio? dio}) : _dio = dio ?? _createDefaultDio();

  final Dio _dio;

  Dio get dio => _dio;

  static Dio _createDefaultDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: TmdbEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (TmdbEndpoints.bearerToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer ${TmdbEndpoints.bearerToken}';
          }
          if (TmdbEndpoints.apiKey.isNotEmpty) {
            options.queryParameters['api_key'] = TmdbEndpoints.apiKey;
          }

          DebugTracer.network(
            '--> ${options.method.toUpperCase()} ${options.baseUrl}${options.path} '
            'Params: ${options.queryParameters.keys.toList()}',
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          DebugTracer.network(
            '<-- ${response.statusCode} ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          DebugTracer.error(
            '<-- ERROR ${error.type} ${error.requestOptions.path}: ${error.message}',
          );
          return handler.next(error);
        },
      ),
    );

    return dio;
  }
}
