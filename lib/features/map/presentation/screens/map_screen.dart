import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service.dart';
import 'package:mindtrip/features/map/widgets/map_serach_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  CircleAnnotationManager? circleManager;
  final double cairoLng = 31.2357;
  final double cairoLat = 30.0444;
  @override
  void initState() {
    // requestLocation();
    super.initState();
  }

  Future<void> _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    //! remove the waterMark and attribution
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
    mapboxMap.logo.updateSettings(LogoSettings(enabled: false));
    mapboxMap.attribution.updateSettings(AttributionSettings(enabled: false));
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
    // circleManager = await mapboxMap.annotations.createCircleAnnotationManager();
    final locationService = sl<LocationService>();

    final position = await locationService.getCurrentLocation();

    if (position == null) return;

    mapboxMap.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(position.longitude, position.latitude),
        ),
        zoom: 15,
        // bearing: 0,
        // pitch: 30,
      ),
      MapAnimationOptions(duration: 1500),
    );
    mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        pulsingMaxRadius: 40,
        showAccuracyRing: true,
        accuracyRingColor: 0xFFC4E0F9,
        // accuracyRingBorderColor: 0xFFC4E0F9,
      ),
    );
    mapboxMap.gestures.updateSettings(GesturesSettings());
  }

  Future<void> _onMapTap(double lng, double lat) async {
    // 1. Call reverse geocoding
    final place = await _reverseGeocode(lng, lat);

    if (place == null) return;

    // 2. Move camera
    mapboxMap?.flyTo(
      CameraOptions(center: Point(coordinates: Position(lng, lat)), zoom: 15),
      MapAnimationOptions(duration: 1000),
    );

    // 3. Add marker (reuse your manager)
    // await _addMarker(lng, lat);

    // 4. Show UI (later → bottom sheet)
    print(place);
  }

  Future<String?> _reverseGeocode(double lng, double lat) async {
    final token = const String.fromEnvironment("ACCESS_TOKEN");

    final url =
        "https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?types=poi&access_token=$token";

    final response = await Dio().get(url);

    if (response.statusCode == 200) {
      final features = response.data["features"];
      if (features.isNotEmpty) {
        return features[0]["place_name"];
      }
    }

    return null;
  }
  // Future<void> _addMarker(double lng, double lat) async {
  //   if (pointAnnotationManager == null) {
  //     pointAnnotationManager =
  //         await mapboxMap!.annotations.createPointAnnotationManager();
  //   }

  //   await pointAnnotationManager!.deleteAll();

  //   await pointAnnotationManager!.create(
  //     PointAnnotationOptions(
  //       geometry: Point(coordinates: Position(lng, lat)),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        // actions: [MapSerachBar()],
        // backgroundColor: Colors.red,
        elevation: 0,
        bottomOpacity: 3,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // centerTitle: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        // fit: StackFit.expand,
        children: [
          MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: _onMapCreated,
            onTapListener: (context) {
              final point = context.point;
              final coordinates = point.coordinates;

              _onMapTap(coordinates.lng.toDouble(), coordinates.lat.toDouble());
            },
            styleUri: "mapbox://styles/mapbox/outdoors-v12",

            // cameraOptions: cameraOptions,
          ),
          // Positioned(top: 20, child: MapSerachBar()),
        ],
      ),
    );
  }
}
