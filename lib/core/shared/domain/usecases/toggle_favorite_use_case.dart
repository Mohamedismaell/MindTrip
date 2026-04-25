import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository _repository;

  const ToggleFavoriteUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<void>> call({
    required String placeId,
    required bool isFavorite,
  }) {
    return _repository.toggleFavorite(placeId: placeId, isFavorite: isFavorite);
  }
}
