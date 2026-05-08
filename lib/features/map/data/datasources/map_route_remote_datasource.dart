import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../domain/entities/map_route.dart';

abstract class MapRouteRemoteDatasource {
  Future<MapRoute> getRoute(List<Position> waypoints, String profile);
}

class MapRouteRemoteDatasourceImpl implements MapRouteRemoteDatasource {
  final Dio dio;
  static const String _accessToken = String.fromEnvironment('ACCESS_TOKEN');

  MapRouteRemoteDatasourceImpl({required this.dio});

  @override
  Future<MapRoute> getRoute(List<Position> waypoints, String profile) async {
    final coords = waypoints.map((p) => '${p.lng},${p.lat}').join(';');

    final response = await dio.get(
      'https://api.mapbox.com/directions/v5/mapbox/$profile/$coords',
      options: Options(
        extra: {
          'logResponseData': false, // Prevents dumping thousands of coordinates
        },
      ),
      queryParameters: {
        'geometries': 'geojson',
        'overview': 'full',
        'access_token': _accessToken,
      },
    );

    final route = response.data['routes'][0];
    final geometry = route['geometry'];
    final distance = (route['distance'] as num).toDouble();
    final duration = (route['duration'] as num).toDouble();

    return MapRoute(
      waypoints: waypoints,
      geoJsonGeometry: jsonEncode(geometry),
      distance: distance,
      duration: duration,
    );
  }
}
