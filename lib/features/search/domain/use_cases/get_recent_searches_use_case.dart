import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/search/domain/entity/recent_search_entity.dart';
import 'package:mindtrip/features/search/domain/repositories/search_repository.dart';

class GetRecentSearchesUseCase {
  final SearchRepository _repository;

  GetRecentSearchesUseCase(this._repository);

  Future<Result<List<RecentSearchEntity>>> call() {
    return _repository.getRecentSearches();
  }
}
