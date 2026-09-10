import 'package:dio/dio.dart';

sealed class NetworkFailureException implements Exception {
  const NetworkFailureException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => cause != null ? '$message (cause: $cause)' : message;
}

final class OfflineException extends NetworkFailureException {
  const OfflineException({super.cause})
      : super('No active internet connection. Please verify your network.');
}

final class RemoteServerException extends NetworkFailureException {
  const RemoteServerException(int code, {super.cause})
      : super('Server responded with error ($code). Please retry later.');
}

final class JsonDecodingException extends NetworkFailureException {
  const JsonDecodingException({super.cause})
      : super('Failed to parse server payload.');
}

NetworkFailureException mapDioError(DioException error) {
  return switch (error.type) {
    DioExceptionType.connectionError ||
    DioExceptionType.connectionTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.sendTimeout =>
      OfflineException(cause: error),
    DioExceptionType.badResponse =>
      RemoteServerException(error.response?.statusCode ?? 0, cause: error),
    _ => OfflineException(cause: error),
  };
}
