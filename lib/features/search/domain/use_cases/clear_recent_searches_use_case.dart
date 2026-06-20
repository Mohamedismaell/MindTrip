import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/search/domain/repositories/search_repository.dart';

class ClearRecentSearchesUseCase {
  final SearchRepository _repository;

  ClearRecentSearchesUseCase(this._repository);

  Future<Result<void>> call() {
    return _repository.clearRecentSearches();
  }
}
