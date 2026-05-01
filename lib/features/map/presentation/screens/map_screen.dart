import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service_imp.dart';
import 'package:mindtrip/features/map/widgets/map_serach_bar.dart';
import 'package:mindtrip/features/map/widgets/place_info_bottom_sheet.dart';

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
  // final double cairoLng = 31.2357;
  // final double cairoLat = 30.0444;
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
    final locationService = sl<LocationService>();

    final position = await locationService.getCurrentLocation();
    if (!mounted || position == null || this.mapboxMap == null) return;

    mapboxMap.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(position.longitude, position.latitude),
        ),
        zoom: 15,
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
      ),
    );

    mapboxMap.gestures.updateSettings(GesturesSettings());
  }

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
