import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';

class GetFavoriteTripsLocalUseCase {
  final FavoritesRepository repository;

  GetFavoriteTripsLocalUseCase({required this.repository});

  Future<Result<List<FavoriteTripEntity>>> call() async {
    return await repository.getFavoriteTripsLocal();
  }
}
