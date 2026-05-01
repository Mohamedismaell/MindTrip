import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/map/domain/entities/search_suggestion.dart';
import 'package:mindtrip/features/map/domain/entities/map_search_result.dart';
import 'package:mindtrip/features/map/domain/repositories/map_search_repository.dart';

class MapSearchUseCase {
  final MapSearchRepository _repository;

  const MapSearchUseCase({required MapSearchRepository repository})
    : _repository = repository;

  Future<Result<List<SearchSuggestion>>> suggest(String query) {
    return _repository.suggest(query);
  }

  Future<Result<MapSearchResult>> retrieve(String mapboxId) {
    return _repository.retrieve(mapboxId);
  }
}
