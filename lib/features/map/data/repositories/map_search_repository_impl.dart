import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/database/api/api_error_mapper.dart';
import '../../domain/entities/search_suggestion.dart';
import '../../domain/entities/map_search_result.dart';
import '../../domain/repositories/map_search_repository.dart';
import '../datasources/map_search_remote_datasource.dart';

class MapSearchRepositoryImpl implements MapSearchRepository {
  final MapSearchRemoteDatasource _remote;

  MapSearchRepositoryImpl({required MapSearchRemoteDatasource remote})
    : _remote = remote;

  @override
  Future<Result<List<SearchSuggestion>>> suggest(String query) async {
    try {
      final suggestions = await _remote.suggest(query);
      return Result.ok(suggestions);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }

  @override
  Future<Result<MapSearchResult>> retrieve(String mapboxId) async {
    try {
      final result = await _remote.retrieve(mapboxId);
      return Result.ok(result);
    } catch (e) {
      return Result.error(ApiErrorMapper.fromException(e));
    }
  }
}
