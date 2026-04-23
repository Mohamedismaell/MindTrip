import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/features/map/Services/location_service/location_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  final double cairoLng = 31.2357;
  final double cairoLat = 30.0444;
  @override
  void initState() {
    // requestLocation();
    super.initState();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;

    final locationService = sl<LocationService>();
    final position = await locationService.getCurrentLocation();

    if (position == null) return;

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        15,
      ),
    );
  }

  // Future<void> _onMapTap(LatLng position) async {
  //   final place = await _reverseGeocode(position.longitude, position.latitude);

  //   if (place == null) return;

  //   _mapController?.animateCamera(CameraUpdate.newLatLngZoom(position, 15));

  //   setState(() {
  //     _markers.clear();
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId("selected"),
  //         position: position,
  //         infoWindow: InfoWindow(title: place),
  //       ),
  //     );
  //   });

  //   print(place);
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
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(cairoLat, cairoLng),
              zoom: 14,
            ),
            onMapCreated: _onMapCreated,
            onPoiTap: (poi) {
              print("POI tapped: ${poi.name}");
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          // Positioned(top: 20, child: MapSerachBar()),
        ],
      ),
    );
  }
}
