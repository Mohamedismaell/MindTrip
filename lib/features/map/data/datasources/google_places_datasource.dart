import 'package:dio/dio.dart';
import 'package:mindtrip/features/map/data/models/google_place_model.dart';
import 'package:mindtrip/features/map/data/models/place_prediction.dart';

class GooglePlacesRemoteDatasource {
  final Dio _dio;
  final String _apiKey;

  GooglePlacesRemoteDatasource({required Dio dio})
    : _dio = dio,
      _apiKey = const String.fromEnvironment('GOOGLE_PLACES_KEY');

  Future<List<PlacePrediction>> findAutocompletePredictions(
    String query, {
    double? lat,
    double? lng,
  }) async {
    final params = <String, dynamic>{'input': query, 'key': _apiKey};

    if (lat != null && lng != null) {
      params['location'] = '$lat,$lng';
      params['radius'] = '50000';
    }

    final response = await _dio.get(
      'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      queryParameters: params,
    );

    final predictions = response.data['predictions'] as List<dynamic>? ?? [];
    return predictions.map((json) => PlacePrediction.fromJson(json)).toList();
  }

  Future<GooglePlaceModel> fetchPlaceDetails(String placeId) async {
    final response = await _dio.get(
      'https://maps.googleapis.com/maps/api/place/details/json',
      queryParameters: {
        'place_id': placeId,
        'fields':
            'place_id,name,formatted_address,geometry,rating,'
            'user_ratings_total,types,photos,formatted_phone_number,'
            'website,opening_hours,editorial_summary,price_level',
        'key': _apiKey,
      },
    );

    final result = response.data['result'];
    if (result == null) throw Exception('Place details not found');

    return GooglePlaceModel.fromJson(result);
  }

  String buildPhotoUrl(String photoReference, {int maxWidth = 800}) {
    return 'https://maps.googleapis.com/maps/api/place/photo'
        '?maxwidth=$maxWidth'
        '&photo_reference=$photoReference'
        '&key=$_apiKey';
  }

  Future<List<GooglePlaceModel>> nearbySearch(
    double lat,
    double lng,
    double radiusMeters, {
    List<String>? includedTypes,
  }) async {
    final body = <String, dynamic>{
      'maxResultCount': 20,
      'locationRestriction': {
        'circle': {
          'center': {'latitude': lat, 'longitude': lng},
          'radius': radiusMeters,
        },
      },
    };

    if (includedTypes != null && includedTypes.isNotEmpty) {
      body['includedTypes'] = includedTypes;
    }

    final response = await _dio.post(
      'https://places.googleapis.com/v1/places:searchNearby',
      data: body,
      options: Options(
        headers: {
          'X-Goog-Api-Key': _apiKey,
          'X-Goog-FieldMask':
              'places.id,places.displayName,places.formattedAddress,places.location,places.rating,places.userRatingCount,places.primaryType,places.photos',
        },
      ),
    );

    final placesList = response.data['places'] as List<dynamic>? ?? [];
    return placesList.map((json) {
      return GooglePlaceModel.fromNearbyJson(json);
    }).toList();
  }
}
