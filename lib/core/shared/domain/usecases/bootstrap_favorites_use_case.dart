import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class BootstrapFavoritesUseCase {
  final FavoritesRepository _repository;

  const BootstrapFavoritesUseCase({required FavoritesRepository repository})
      : _repository = repository;

  Future<Result<void>> call() {
    return _repository.bootstrapFromServer();
  }
}
