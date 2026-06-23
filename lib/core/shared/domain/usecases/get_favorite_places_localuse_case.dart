import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class GetFavoritePlacesLocalUseCase {
  final FavoritesRepository repository;

  GetFavoritePlacesLocalUseCase({required this.repository});

  Future<Result<List<PlaceEntity>>> call() async {
    return await repository.getFavoritePlacesLocal();
  }
}
