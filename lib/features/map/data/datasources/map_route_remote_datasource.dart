import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../../domain/entities/map_route.dart';
import '../../domain/entities/navigation_profile.dart';
import '../../domain/entities/route_leg.dart';
import '../../domain/entities/route_step.dart';

abstract class MapRouteRemoteDatasource {
  Future<MapRoute> getRoute(
    List<Position> waypoints,
    NavigationProfile profile, {
    CancelToken? cancelToken,
  });
}

class MapRouteRemoteDatasourceImpl implements MapRouteRemoteDatasource {
  final Dio dio;
  static const String _accessToken = String.fromEnvironment('ACCESS_TOKEN');

  MapRouteRemoteDatasourceImpl({required this.dio});

  @override
  Future<MapRoute> getRoute(
    List<Position> waypoints,
    NavigationProfile profile, {
    CancelToken? cancelToken,
  }) async {
    final coords = waypoints.map((p) => '${p.lng},${p.lat}').join(';');

    final queryParams = <String, dynamic>{
      'geometries': 'geojson',
      'overview': 'full',
      'steps': 'true',
      'banner_instructions': 'true',
      'language': 'en',
      'access_token': _accessToken,
    };

    //! Add congestion annotations only for driving-traffic
    if (profile.supportsCongestion) {
      queryParams['annotations'] = 'congestion,duration,distance';
    } else {
      queryParams['annotations'] = 'duration,distance';
    }

    final response = await dio.get(
      'https://api.mapbox.com/directions/v5/mapbox/${profile.apiValue}/$coords',
      cancelToken: cancelToken,
      options: Options(
        extra: {
          'logResponseData': false, // Prevents dumping thousands of coordinates
        },
      ),
      queryParameters: queryParams,
    );

    final route = response.data['routes'][0];
    final geometry = route['geometry'];
    final distance = (route['distance'] as num).toDouble();
    final duration = (route['duration'] as num).toDouble();

    // Parse legs and steps
    final rawLegs = route['legs'] as List;
    final legs = rawLegs.map((rawLeg) => _parseLeg(rawLeg, profile)).toList();

    // Flatten congestion levels across all legs
    List<String>? congestionLevels;
    if (profile.supportsCongestion) {
      congestionLevels = legs
          .where((leg) => leg.congestionLevels != null)
          .expand((leg) => leg.congestionLevels!)
          .toList();
    }

    return MapRoute(
      waypoints: waypoints,
      geoJsonGeometry: jsonEncode(geometry),
      distance: distance,
      duration: duration,
      legs: legs,
      profile: profile,
      congestionLevels: congestionLevels,
    );
  }

  RouteLeg _parseLeg(Map<String, dynamic> rawLeg, NavigationProfile profile) {
    final legDistance = (rawLeg['distance'] as num).toDouble();
    final legDuration = (rawLeg['duration'] as num).toDouble();

    // Parse steps
    final rawSteps = (rawLeg['steps'] as List?) ?? [];
    final steps = rawSteps.map((s) => _parseStep(s)).toList();

    // Parse congestion annotations
    List<String>? congestionLevels;
    if (profile.supportsCongestion) {
      final annotation = rawLeg['annotation'];
      if (annotation != null && annotation['congestion'] != null) {
        congestionLevels = (annotation['congestion'] as List)
            .map((e) => e.toString())
            .toList();
      }
    }

    return RouteLeg(
      steps: steps,
      distance: legDistance,
      duration: legDuration,
      congestionLevels: congestionLevels,
    );
  }

  RouteStep _parseStep(Map<String, dynamic> rawStep) {
    final maneuver = rawStep['maneuver'] as Map<String, dynamic>;

    // Parse banner instructions
    String? bannerText;
    String? bannerType;
    String? bannerModifier;
    final bannerInstructions = rawStep['bannerInstructions'] as List?;
    if (bannerInstructions != null && bannerInstructions.isNotEmpty) {
      final primary = bannerInstructions[0]['primary'];
      if (primary != null) {
        bannerText = primary['text'] as String?;
        bannerType = primary['type'] as String?;
        bannerModifier = primary['modifier'] as String?;
      }
    }

    return RouteStep(
      instruction: maneuver['instruction'] as String? ?? '',
      maneuverType: maneuver['type'] as String? ?? '',
      maneuverModifier: maneuver['modifier'] as String?,
      distance: (rawStep['distance'] as num).toDouble(),
      duration: (rawStep['duration'] as num).toDouble(),
      bannerText: bannerText,
      bannerType: bannerType,
      bannerModifier: bannerModifier,
    );
  }
}
