import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class SyncFavoritesUseCase {
  final FavoritesRepository _repository;

  const SyncFavoritesUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<void>> call() {
    return _repository.syncPendingFavorites();
  }
}
