import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class SyncFavoriteTripsUseCase {
  final FavoritesRepository _repository;

  const SyncFavoriteTripsUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<void>> call() {
    return _repository.syncPendingTripFavorites();
  }
}
