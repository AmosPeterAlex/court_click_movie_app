import 'package:dio/dio.dart';
import '../../../foundation/http/api_exceptions.dart';
import '../../../foundation/http/resource_result.dart';
import '../../discover/domain/media_item.dart';
import '../domain/explore_repository.dart';
import 'explore_remote_source.dart';

class ExploreRepositoryImpl implements ExploreRepository {
  ExploreRepositoryImpl({required this.remoteSource});

  final ExploreRemoteSource remoteSource;

  List<MediaItem> _extractMediaList(List<dynamic> list) {
    return list
        .whereType<Map<String, dynamic>>()
        .map(MediaItem.fromJson)
        .toList();
  }

  @override
  Future<ResourceResult<List<MediaItem>>> queryTitles(String searchTerm) async {
    try {
      final raw = await remoteSource.searchMovies(searchTerm);
      return Success(_extractMediaList(raw));
    } on DioException catch (e) {
      return Failure(mapDioError(e));
    } catch (e) {
      return Failure(JsonDecodingException(cause: e));
    }
  }

  @override
  Future<ResourceResult<List<MediaItem>>> fetchSuggestedSearches() async {
    try {
      final raw = await remoteSource.getSuggestedSearches();
      return Success(_extractMediaList(raw));
    } on DioException catch (e) {
      return Failure(mapDioError(e));
    } catch (e) {
      return Failure(JsonDecodingException(cause: e));
    }
  }
}
