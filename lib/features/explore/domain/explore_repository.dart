import '../../../foundation/http/resource_result.dart';
import '../../discover/domain/media_item.dart';

abstract interface class ExploreRepository {
  Future<ResourceResult<List<MediaItem>>> queryTitles(String searchTerm, {int page = 1});
  Future<ResourceResult<List<MediaItem>>> fetchSuggestedSearches({int page = 1});
}
