import '../../../foundation/http/resource_result.dart';
import '../../discover/domain/media_item.dart';

abstract interface class PremieresRepository {
  Future<ResourceResult<List<MediaItem>>> fetchUpcomingReleases();
}
