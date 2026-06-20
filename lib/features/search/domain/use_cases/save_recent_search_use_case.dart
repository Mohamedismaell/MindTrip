import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/search/domain/entity/recent_search_entity.dart';
import 'package:mindtrip/features/search/domain/repositories/search_repository.dart';

class SaveRecentSearchUseCase {
  final SearchRepository _repository;

  SaveRecentSearchUseCase(this._repository);

  Future<Result<void>> call(String query) {
    return _repository.saveRecentSearch(
      RecentSearchEntity(
        query: query,
        timestamp: DateTime.now(),
      ),
    );
  }
}
