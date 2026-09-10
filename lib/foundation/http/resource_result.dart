import 'api_exceptions.dart';

sealed class ResourceResult<T> {
  const ResourceResult();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(data: final data) => data,
        Failure<T>() => null,
      };

  NetworkFailureException? get errorOrNull => switch (this) {
        Success<T>() => null,
        Failure<T>(exception: final error) => error,
      };

  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(NetworkFailureException error) onFailure,
  }) {
    return switch (this) {
      Success<T>(data: final data) => onSuccess(data),
      Failure<T>(exception: final error) => onFailure(error),
    };
  }
}

final class Success<T> extends ResourceResult<T> {
  const Success(this.data);
  final T data;
}

final class Failure<T> extends ResourceResult<T> {
  const Failure(this.exception);
  final NetworkFailureException exception;
}
