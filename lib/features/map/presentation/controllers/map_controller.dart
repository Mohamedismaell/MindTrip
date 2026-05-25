import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/domain/entities/map_annotation_entry.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/map/domain/entities/google_place.dart';

class MapController {
  MapboxMap? _mapboxMap;
  PointAnnotationManager? _pointAnnotationManager;
  PolylineAnnotationManager? _polylineAnnotationManager;
  PointAnnotation? _searchResultAnnotation;
  final Map<String, String> _annotationIdToPlaceId = {};
  final Map<String, GooglePlaceEntity> _annotationIdToGooglePlace = {};
  final Map<String, Uint8List> _imageCache = {};
  final List<Position> _annotationCoordinates = [];
  final Map<String, double> _defaultIconSizes = {};
  String? _selectedAnnotationId;
  GooglePlaceEntity? _searchResultGooglePlace;
  Cancelable? _tapEventsCancelable;

  Future<void> init(MapboxMap mapboxMap) async {
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
  }

  void setupAnnotationTapHandler({
    required void Function(String placeId) onPlaceTap,
    required void Function(GooglePlaceEntity place) onGooglePlaceTap,
  }) {
    _tapEventsCancelable?.cancel();
    _tapEventsCancelable = _pointAnnotationManager?.tapEvents(
      onTap: (annotation) {
        _animateSelectedAnnotation(annotation.id);

        final placeId = _annotationIdToPlaceId[annotation.id];
        if (placeId != null) {
          onPlaceTap(placeId);
          return;
        }

        final googlePlace = _annotationIdToGooglePlace[annotation.id];
        if (googlePlace != null) {
          onGooglePlaceTap(googlePlace);
          return;
        }

        if (_searchResultAnnotation != null &&
            annotation.id == _searchResultAnnotation!.id &&
            _searchResultGooglePlace != null) {
          onGooglePlaceTap(_searchResultGooglePlace!);
          return;
        }
      },
    );
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

  Future<void> clearPlaceAnnotations() async {
    if (_pointAnnotationManager == null) return;
    await _pointAnnotationManager!.deleteAll();
    _annotationIdToPlaceId.clear();
    _annotationCoordinates.clear();
    _defaultIconSizes.clear();
    _selectedAnnotationId = null;
  }

  Future<void> addPlaceAnnotations(List<MapAnnotationEntry> entries) async {
    if (_pointAnnotationManager == null) return;
    // Clear old annotations first
    await clearPlaceAnnotations();

    for (final entry in entries) {
      final img = await _loadImage(
        entry.isSearchResult 
            ? PlaceCategory.searchPinAssetPath 
            : entry.place.category.annotationAssetPath
      );
      final coord = Position(
        entry.place.location.longitude,
        entry.place.location.latitude,
      );

      final annotation = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: coord),
          image: img,
          iconSize: entry.isSearchResult ? 0.25 : 0.2,
        ),
      );

      _annotationCoordinates.add(coord);
      _annotationIdToPlaceId[annotation.id] = entry.place.id;
      _defaultIconSizes[annotation.id] = entry.isSearchResult ? 0.25 : 0.2;
    }
  }

  Future<void> addGooglePlaceAnnotations(List<GooglePlaceEntity> places) async {
    if (_pointAnnotationManager == null) return;

    for (final place in places) {
      if (place.latitude == null || place.longitude == null) continue;

      final img = await _loadImage(PlaceCategory.searchPinAssetPath);
      final coord = Position(place.longitude!, place.latitude!);

      final annotation = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: coord),
          image: img,
          iconSize: 0.25,
        ),
      );

      _annotationIdToGooglePlace[annotation.id] = place;
      _defaultIconSizes[annotation.id] = 0.25;
    }
  }

  Future<void> fitToAnnotations() async {
    if (_annotationCoordinates.isEmpty) return;

    if (_annotationCoordinates.length == 1) {
      final c = _annotationCoordinates.first;
      await flyTo(c.lat.toDouble(), c.lng.toDouble(), zoom: 14);
      return;
    }

    await fitBounds(_annotationCoordinates);
  }


  Future<void> drawRoute(
    String geoJsonGeometry, {
    List<String>? congestionLevels,
  }) async {
    if (_polylineAnnotationManager == null) return;

    await clearRoute();

    final geoJson = json.decode(geoJsonGeometry);
    final rawCoords = geoJson['coordinates'] as List;
    final coordinates = rawCoords
        .map(
          (c) => Position((c[0] as num).toDouble(), (c[1] as num).toDouble()),
        )
        .toList();

    if (congestionLevels != null && congestionLevels.isNotEmpty) {
      await _drawCongestionRoute(coordinates, congestionLevels);
    } else {
      await _polylineAnnotationManager!.create(
        PolylineAnnotationOptions(
          geometry: LineString(coordinates: coordinates),
          lineColor: 0xFF2196F3,
          lineWidth: 5.0,
          lineOpacity: 0.8,
        ),
      );
    }

    await fitBounds(coordinates);
  }

  Future<void> _drawCongestionRoute(
    List<Position> coordinates,
    List<String> congestionLevels,
  ) async {
    if (_polylineAnnotationManager == null) return;

    int segStart = 0;
    for (int i = 0; i < congestionLevels.length; i++) {
      final isLast = i == congestionLevels.length - 1;
      final nextDiffers =
          !isLast && congestionLevels[i] != congestionLevels[i + 1];

      if (isLast || nextDiffers) {
        // Draw segment from segStart to i+1 (inclusive end coordinate)
        final endIdx = (i + 1 < coordinates.length)
            ? i + 1
            : coordinates.length - 1;
        final segCoords = coordinates.sublist(segStart, endIdx + 1);

        if (segCoords.length >= 2) {
          await _polylineAnnotationManager!.create(
            PolylineAnnotationOptions(
              geometry: LineString(coordinates: segCoords),
              lineColor: _congestionColor(congestionLevels[i]),
              lineWidth: 5.0,
              lineOpacity: 0.85,
            ),
          );
        }

        segStart = i + 1;
      }
    }
  }

  int _congestionColor(String level) {
    switch (level) {
      case 'low':
        return 0xFF4CAF50;
      case 'moderate':
        return 0xFFFFC107;
      case 'heavy':
        return 0xFFFF9800;
      case 'severe':
        return 0xFFF44336;
      case 'unknown':
      default:
        return 0xFF2196F3;
    }
  }

  Future<void> clearRoute() async {
    if (_polylineAnnotationManager == null) return;
    await _polylineAnnotationManager!.deleteAll();
  }

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
    _tapEventsCancelable?.cancel();
    _imageCache.clear();
    _annotationIdToPlaceId.clear();
    _annotationIdToGooglePlace.clear();
    _defaultIconSizes.clear();
    _selectedAnnotationId = null;
    _searchResultGooglePlace = null;
  }

  Future<void> _updateAnnotationSize(String annotationId, double size) async {
    if (_pointAnnotationManager == null) return;
    final annotations = await _pointAnnotationManager!.getAnnotations();
    for (final a in annotations) {
      if (a.id == annotationId) {
        a.iconSize = size;
        await _pointAnnotationManager!.update(a);
        break;
      }
    }
  }

  Future<void> _animateSelectedAnnotation(String annotationId) async {
    if (_pointAnnotationManager == null) return;

    await _resetSelectedAnnotation();

    _selectedAnnotationId = annotationId;

    final defaultSize = _defaultIconSizes[annotationId] ?? 0.2;

    await _popAnnotation(annotationId, defaultSize);
  }

  Future<void> _popAnnotation(String annotationId, double baseSize) async {
    final frames = [baseSize * 1.45, baseSize * 1.2, baseSize * 1.3];

    final durations = [
      const Duration(milliseconds: 120),
      const Duration(milliseconds: 90),
      const Duration(milliseconds: 70),
    ];

    for (int i = 0; i < frames.length; i++) {
      await _updateAnnotationSize(annotationId, frames[i]);

      await Future.delayed(durations[i]);
    }
  }

  Future<void> _resetSelectedAnnotation() async {
    if (_selectedAnnotationId == null || _pointAnnotationManager == null) {
      return;
    }

    final defaultSize = _defaultIconSizes[_selectedAnnotationId!];

    if (defaultSize != null) {
      await _updateAnnotationSize(_selectedAnnotationId!, defaultSize);
    }

    _selectedAnnotationId = null;
  }
}
