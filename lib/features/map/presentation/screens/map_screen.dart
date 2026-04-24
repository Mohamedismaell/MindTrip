import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service.dart';
import 'package:mindtrip/features/map/widgets/map_serach_bar.dart';
import 'package:mindtrip/features/map/widgets/place_info_bottom_sheet.dart';

//Todo locate yourself
//Todo bottom sheet for the place info
//Todo start navigation into the specif place
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

    if (!mounted || position == null || this.mapboxMap == null) return;

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
    // await PlaceInfoBottomSheet.show(
    //   context,
    //   // placeName: placeName ?? "Selected Location",
    // );

    mapboxMap.gestures.updateSettings(GesturesSettings());
  }

  // Future<void> _onMapTap(double lng, double lat, BuildContext context) async {
  //   // 1. Move camera immediately for responsiveness
  //   mapboxMap?.flyTo(
  //     CameraOptions(center: Point(coordinates: Position(lng, lat)), zoom: 15),
  //     MapAnimationOptions(duration: 1000),
  //   );

  //   // 2. Call reverse geocoding with error handling
  //   String? placeName;
  //   try {
  //     placeName = await _reverseGeocode(lng, lat);
  //   } catch (e) {
  //     debugPrint("Geocoding error: $e");
  //   }

  //   // 3. Show bottom sheet (don't return early if place is null, show "Selected Location" instead)
  //   if (!mounted) return;
  //   await PlaceInfoBottomSheet.show(context, placeName: placeName ?? "Selected Location");
  // }

  // Future<String?> _reverseGeocode(double lng, double lat) async {
  //   final token = const String.fromEnvironment("ACCESS_TOKEN");
  //   if (token.isEmpty) {
  //     debugPrint("Mapbox access token is missing. Please provide it via --dart-define=ACCESS_TOKEN=your_token");
  //     return null;
  //   }

  //   // Broaden types to include address and place, not just poi
  //   final url =
  //       "https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?types=poi,address,place&access_token=$token";

  //   final response = await Dio().get(url);

  //   if (response.statusCode == 200) {
  //     final features = response.data["features"];
  //     if (features != null && features.isNotEmpty) {
  //       return features[0]["place_name"];
  //     }
  //   }

  //   return null;
  // }

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
      // appBar: AppBar(
      //   actions: [MapSerachBar()],
      //   // backgroundColor: Colors.red,
      //   elevation: 0,
      //   bottomOpacity: 3,
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back_ios_new_rounded),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   // centerTitle: false,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30.r),
      //   ),
      // ),
      body: Stack(
        alignment: Alignment.center,
        // fit: StackFit.expand,
        children: [
          MapWidget(
            key: const ValueKey("mapWidget"),
            onMapCreated: _onMapCreated,
            // onTapListener: (ctx) async {
            //   final point = ctx.point;
            //   final coordinates = point.coordinates;

            //   await _onMapTap(
            //     coordinates.lng.toDouble(),
            //     coordinates.lat.toDouble(),
            //     context,
            //   );
            // },
            styleUri: "mapbox://styles/mapbox/outdoors-v12",

            // cameraOptions: cameraOptions,
          ),
          Positioned(top: 10, child: Row(children: [MapSerachBar()])),
          PlaceInfoBottomSheet(),
        ],
      ),
    );
  }
}
