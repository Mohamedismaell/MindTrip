import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';

class PlaceDetailsRemoteDataSource {
  final ApiConsumer _consumer;
  PlaceDetailsRemoteDataSource(this._consumer);

  Future<PlaceModel> getPlaceDetails(String placeId) async {
    final response = await _consumer.get(EndPoints.placeDetails(placeId));
    return PlaceModel.fromJson(response['data'] ?? response);
  }

  Future<PaginatedResponse<PlaceModel>> getNearbyPlaces(
    String placeId, {
    int page = 1,
    int limit = 10,
    double? lat,
    double? lng,
  }) async {
    // No endpoint for nearby yet
    return PaginatedResponse(
      results: [],
      page: page,
      limit: limit,
      total: 0,
      totalPages: 0,
    );
  }
}
