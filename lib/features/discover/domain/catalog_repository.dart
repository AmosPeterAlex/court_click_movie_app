import '../../../foundation/http/resource_result.dart';
import 'media_item.dart';

abstract interface class CatalogRepository {
  Future<ResourceResult<List<MediaItem>>> fetchWeeklyTrends();
  Future<ResourceResult<List<MediaItem>>> fetchPopularTitles();
  Future<ResourceResult<List<MediaItem>>> fetchInTheaters();
  Future<ResourceResult<List<MediaItem>>> fetchCriticallyAcclaimed();
}
