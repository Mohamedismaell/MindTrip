import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class BootstrapFavoriteTripsUseCase {
  final FavoritesRepository _repository;

  const BootstrapFavoriteTripsUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<void>> call() {
    return _repository.bootstrapFavoriteTripsFromServer();
  }
}
