import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/models/paginated_response.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/features/places/data/models/nearby_places_request_model.dart';

class PlaceDetailsRemoteDataSource {
  final ApiConsumer _consumer;
  PlaceDetailsRemoteDataSource(this._consumer);

  Future<PlaceModel> getPlaceDetails(String placeId) async {
    final response = await _consumer.get(EndPoints.placeDetails(placeId));
    return PlaceModel.fromJson(response['data'] ?? response);
  }

  Future<PaginatedResponse<PlaceModel>> getNearbyPlaces({
    required NearbyPlacesRequestModel request,
  }) async {
    final response = await _consumer.post(
      EndPoints.getNearbyPlaces,
      data: request.toJson(),
    );
    return PaginatedResponse<PlaceModel>.fromJson(
      response,
      (json) => PlaceModel.fromJson(json),
    );
  }
}
