import '../../../foundation/http/resource_result.dart';
import '../../discover/domain/media_item.dart';

abstract interface class ExploreRepository {
  Future<ResourceResult<List<MediaItem>>> queryTitles(String searchTerm);
  Future<ResourceResult<List<MediaItem>>> fetchSuggestedSearches();
}
