import 'package:dio/dio.dart';
import '../../../foundation/http/api_exceptions.dart';
import '../../../foundation/http/resource_result.dart';
import '../../discover/domain/media_item.dart';
import '../domain/premieres_repository.dart';
import 'premieres_remote_source.dart';

class PremieresRepositoryImpl implements PremieresRepository {
  PremieresRepositoryImpl({required this.remoteSource});

  final PremieresRemoteSource remoteSource;

  List<MediaItem> _extractMediaList(List<dynamic> list) {
    return list
        .whereType<Map<String, dynamic>>()
        .map(MediaItem.fromJson)
        .toList();
  }

  @override
  Future<ResourceResult<List<MediaItem>>> fetchUpcomingReleases() async {
    try {
      final raw = await remoteSource.getUpcomingMovies();
      return Success(_extractMediaList(raw));
    } on DioException catch (e) {
      return Failure(mapDioError(e));
    } catch (e) {
      return Failure(JsonDecodingException(cause: e));
    }
  }
}
