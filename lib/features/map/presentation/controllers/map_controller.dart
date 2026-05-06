import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/features/map/domain/entities/map_annotation_entry.dart';
import 'package:mindtrip/features/map/domain/entities/place_category.dart';
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

  /// Stores the GooglePlaceEntity associated with the current search result marker,
  /// so it can be re-tapped to show details again.
  GooglePlaceEntity? _searchResultGooglePlace;

  /// Cancelable handle for the unified annotation tap listener.
  Cancelable? _tapEventsCancelable;

  /// Timestamp of the last tap handled by a specific interaction (POI or annotation).
  /// Used to prevent the general map tap from double-firing.
  DateTime _lastHandledTapTime = DateTime(0);

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

  void _markTapHandled() {
    _lastHandledTapTime = DateTime.now();
  }

  bool _wasTapRecentlyHandled() {
    return DateTime.now().difference(_lastHandledTapTime).inMilliseconds < 500;
  }

  void setupPOITapInteraction(
    void Function(String name, String? category, double lat, double lng) onTap,
  ) {
    if (_mapboxMap == null) return;

    _mapboxMap!.addInteraction(
      TapInteraction(StandardPOIs(), (feature, context) {
        _markTapHandled();

        final geom = feature.geometry;
        double lat = 0.0;
        double lng = 0.0;

        // geometry is a raw GeoJSON Map, not a typed Point object
        final coords = geom['coordinates'];
        if (coords is List && coords.length >= 2) {
          lng = (coords[0] as num).toDouble();
          lat = (coords[1] as num).toDouble();
        }

        onTap(
          feature.name ?? 'Unknown',
          feature.properties['class'] as String?,
          lat,
          lng,
        );
      }, radius: 12),
      interactionID: "tap_poi",
    );
  }

  /// Sets up a unified tap handler for ALL point annotations
  /// (place annotations, google place annotations, and search result marker).
  /// Call this once after [init] completes.
  void setupAnnotationTapHandler({
    required void Function(String placeId) onPlaceTap,
    required void Function(GooglePlaceEntity place) onGooglePlaceTap,
  }) {
    _tapEventsCancelable?.cancel();
    _tapEventsCancelable = _pointAnnotationManager?.tapEvents(
      onTap: (annotation) {
        _markTapHandled();

        // Check place annotations (mock / passed-in places)
        final placeId = _annotationIdToPlaceId[annotation.id];
        if (placeId != null) {
          onPlaceTap(placeId);
          return;
        }

        // Check google place annotations (nearby search results)
        final googlePlace = _annotationIdToGooglePlace[annotation.id];
        if (googlePlace != null) {
          onGooglePlaceTap(googlePlace);
          return;
        }

        // Check search result marker
        if (_searchResultAnnotation != null &&
            annotation.id == _searchResultAnnotation!.id &&
            _searchResultGooglePlace != null) {
          onGooglePlaceTap(_searchResultGooglePlace!);
          return;
        }
      },
    );
  }

  /// Sets up a general map tap listener for tapping on empty areas.
  /// Suppressed if a POI or annotation tap was just handled.
  void setupMapTapListener(
    void Function(double lat, double lng) onTap,
  ) {
    _mapboxMap?.setOnMapTapListener((context) {
      if (_wasTapRecentlyHandled()) return;
      final coordinates = context.point.coordinates;
      onTap(coordinates.lat.toDouble(), coordinates.lng.toDouble());
    });
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
    //! chekc
    _annotationCoordinates.clear();
    for (final entry in entries) {
      final category = PlaceCategory.fromCategoryId(entry.place.categoryId);
      final img = await _loadImage(category.annotationAssetPath);
      final coord = Position(
        entry.place.location.longitude,
        entry.place.location.latitude,
      );

      final annotation = await _pointAnnotationManager!.create(
        PointAnnotationOptions(
          geometry: Point(coordinates: coord),
          image: img,
          iconSize: 0.2,
        ),
      );

      _annotationCoordinates.add(coord);
      _annotationIdToPlaceId[annotation.id] = entry.place.id;
    }
  }

  Future<void> addGooglePlaceAnnotations(
    List<GooglePlaceEntity> places,
  ) async {
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
    }
  }

  /// Fits the camera to show all place annotations.
  Future<void> fitToAnnotations() async {
    if (_annotationCoordinates.isEmpty) return;

    if (_annotationCoordinates.length == 1) {
      final c = _annotationCoordinates.first;
      await flyTo(c.lat.toDouble(), c.lng.toDouble(), zoom: 14);
      return;
    }

    await fitBounds(_annotationCoordinates);
  }

  Future<void> addSearchResultMarker(
    double lat,
    double lng, {
    GooglePlaceEntity? place,
  }) async {
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
    _searchResultGooglePlace = place;
  }

  Future<void> removeSearchResultMarker() async {
    if (_pointAnnotationManager != null && _searchResultAnnotation != null) {
      await _pointAnnotationManager!.delete(_searchResultAnnotation!);
      _searchResultAnnotation = null;
      _searchResultGooglePlace = null;
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
    _searchResultGooglePlace = null;
  }
}
