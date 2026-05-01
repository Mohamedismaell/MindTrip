import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/domain/entities/search_suggestion.dart';
import 'package:mindtrip/features/map/domain/entities/map_search_result.dart';

abstract class MapSearchRepository {
  Future<Result<List<SearchSuggestion>>> suggest(String query);
  Future<Result<MapSearchResult>> retrieve(String mapboxId);
}
