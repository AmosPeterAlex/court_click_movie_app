import 'package:dio/dio.dart';
import '../../../foundation/http/api_exceptions.dart';
import '../../../foundation/http/resource_result.dart';
import '../domain/catalog_repository.dart';
import '../domain/media_item.dart';
import 'catalog_remote_source.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({required this.remoteSource});

  final CatalogRemoteSource remoteSource;

  List<MediaItem> _extractMediaList(List<dynamic> list) {
    return list
        .whereType<Map<String, dynamic>>()
        .map(MediaItem.fromJson)
        .toList();
  }

  Future<ResourceResult<List<MediaItem>>> _safeCall(
    Future<List<dynamic>> Function() call,
  ) async {
    try {
      final rawList = await call();
      final items = _extractMediaList(rawList);
      return Success(items);
    } on DioException catch (e) {
      return Failure(mapDioError(e));
    } catch (e) {
      return Failure(JsonDecodingException(cause: e));
    }
  }

  @override
  Future<ResourceResult<List<MediaItem>>> fetchWeeklyTrends() {
    return _safeCall(remoteSource.getWeeklyTrends);
  }

  @override
  Future<ResourceResult<List<MediaItem>>> fetchPopularTitles() {
    return _safeCall(remoteSource.getPopularTitles);
  }

  @override
  Future<ResourceResult<List<MediaItem>>> fetchInTheaters() {
    return _safeCall(remoteSource.getInTheaters);
  }

  @override
  Future<ResourceResult<List<MediaItem>>> fetchCriticallyAcclaimed() {
    return _safeCall(remoteSource.getCriticallyAcclaimed);
  }
}
