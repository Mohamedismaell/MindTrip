import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/domain/entities/map_annotation_entry.dart';
import 'package:mindtrip/features/map/domain/entities/place_category.dart';

class MapController {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  PolylineAnnotationManager? _polylineAnnotationManager;
  PointAnnotation? _searchResultAnnotation;
  final Map<String, String> _annotationIdToPlaceId = {};
  final Map<String, Uint8List> _imageCache = {};

  Future<void> init(MapboxMap mapboxMap, Position userPosition) async {
    _mapboxMap = mapboxMap;

    _mapboxMap!.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    _mapboxMap!.logo.updateSettings(LogoSettings(enabled: false));
    _mapboxMap!.attribution.updateSettings(AttributionSettings(enabled: false));
    _mapboxMap!.compass.updateSettings(CompassSettings(enabled: false));

    _mapboxMap!.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        pulsingMaxRadius: 40,
        showAccuracyRing: true,
        accuracyRingColor: 0xFFC4E0F9,
      ),
    );

    _mapboxMap!.gestures.updateSettings(GesturesSettings());

    _pointAnnotationManager = await _mapboxMap!.annotations
        .createPointAnnotationManager();
    _polylineAnnotationManager = await _mapboxMap!.annotations
        .createPolylineAnnotationManager();

    await flyTo(userPosition.lat.toDouble(), userPosition.lng.toDouble());
  }

  Future<void> flyTo(double lat, double lng, {double zoom = 15}) async {
    if (_mapboxMap == null) return;
    await _mapboxMap!.flyTo(
      CameraOptions(
        center: Point(coordinates: Position(lng, lat)),
        zoom: zoom,
      ),
      MapAnimationOptions(duration: 1500),
    );
  }

  Future<void> fitBounds(List<Position> coordinates) async {
    if (_mapboxMap == null || coordinates.length < 2) return;

    final lats = coordinates.map((c) => c.lat.toDouble());
    final lngs = coordinates.map((c) => c.lng.toDouble());

    final sw = Position(
      lngs.reduce((a, b) => a < b ? a : b),
      lats.reduce((a, b) => a < b ? a : b),
    );
    final ne = Position(
      lngs.reduce((a, b) => a > b ? a : b),
      lats.reduce((a, b) => a > b ? a : b),
    );

    final cameraOptions = await _mapboxMap!.cameraForCoordinateBounds(
      CoordinateBounds(
        southwest: Point(coordinates: sw),
        northeast: Point(coordinates: ne),
        infiniteBounds: false,
      ),
      MbxEdgeInsets(top: 80, left: 40, bottom: 80, right: 40),
      null,
      null,
      null,
      null,
    );

    await _mapboxMap!.flyTo(cameraOptions, MapAnimationOptions(duration: 1500));
  }

  Future<void> addPlaceAnnotations(List<MapAnnotationEntry> entries) async {
    if (_pointAnnotationManager == null) return;

    for (final entry in entries) {
      final category = PlaceCategory.fromCategoryId(entry.place.categoryId);
      final img = await _loadImage(category.annotationAssetPath);

      final annotation = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              entry.place.location.longitude,
              entry.place.location.latitude,
            ),
          ),
          image: img,
          iconSize: 1.0,
        ),
      );

      _annotationIdToPlaceId[annotation.id] = entry.place.id;
    }
  }

  Future<void> addSearchResultMarker(double lat, double lng) async {
    if (_pointAnnotationManager == null) return;

    await removeSearchResultMarker();

    final img = await _loadImage(PlaceCategory.searchPinAssetPath);

    _searchResultAnnotation = await _pointAnnotationManager!.create(
      PointAnnotationOptions(
        geometry: Point(coordinates: Position(lng, lat)),
        image: img,
        iconSize: 0.25,
      ),
    );
  }

  Future<void> removeSearchResultMarker() async {
    if (_pointAnnotationManager != null && _searchResultAnnotation != null) {
      await _pointAnnotationManager!.delete(_searchResultAnnotation!);
      _searchResultAnnotation = null;
    }
  }

  Future<void> drawRoute(String geoJsonGeometry) async {
    if (_polylineAnnotationManager == null) return;

    await clearRoute();

    final geoJson = json.decode(geoJsonGeometry);
    final rawCoords = geoJson['coordinates'] as List;
    final coordinates = rawCoords
        .map(
          (c) => Position((c[0] as num).toDouble(), (c[1] as num).toDouble()),
        )
        .toList();

    await _polylineAnnotationManager!.create(
      PolylineAnnotationOptions(
        geometry: LineString(coordinates: coordinates),
        lineColor: 0xFF2196F3,
        lineWidth: 5.0,
        lineOpacity: 0.8,
      ),
    );

    await fitBounds(coordinates);
  }

  Future<void> clearRoute() async {
    if (_polylineAnnotationManager == null) return;
    await _polylineAnnotationManager!.deleteAll();
  }

  // String? getPlaceIdForAnnotation(String annotationId) {
  //   return _annotationIdToPlaceId[annotationId];
  // }

  Future<Uint8List> _loadImage(String assetPath) async {
    if (_imageCache.containsKey(assetPath)) {
      return _imageCache[assetPath]!;
    }
    final bytes = await rootBundle.load(assetPath);
    final data = bytes.buffer.asUint8List();
    _imageCache[assetPath] = data;
    return data;
  }

  Future<void> dispose() async {
    _imageCache.clear();
    _annotationIdToPlaceId.clear();
  }
}
