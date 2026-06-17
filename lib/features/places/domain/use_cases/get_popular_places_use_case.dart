import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/features/places/domain/repositories/place_repository.dart';

class GetPopularPlacesUseCase {
  final PlaceRepository repository;

  GetPopularPlacesUseCase({required this.repository});

  Future<Result<PaginatedResponse<PlaceEntity>>> call({
    Map<String, dynamic>? filters,
    int page = 1,
    int limit = 10,
  }) async {
    return await repository.getPopularPlaces(
      filters: filters,
      page: page,
      limit: limit,
    );
  }
}
