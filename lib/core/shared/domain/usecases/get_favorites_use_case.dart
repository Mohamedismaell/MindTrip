import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class GetFavoritesUseCase {
  final FavoritesRepository _repository;

  const GetFavoritesUseCase({required FavoritesRepository repository})
    : _repository = repository;

  Future<Result<Set<String>>> call() async {
    return await _repository.getFavoriteIds();
  }
}
