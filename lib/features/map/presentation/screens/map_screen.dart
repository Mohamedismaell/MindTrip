import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

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

    circleManager = await mapboxMap.annotations.createCircleAnnotationManager();

    mapboxMap.location.updateSettings(LocationComponentSettings(enabled: true));
  }

  @override
  Widget build(BuildContext context) {
    CameraOptions cameraOptions = CameraOptions(
      center: Point(
        coordinates: Position(cairoLng, cairoLat),
        // Cairo
      ),
      zoom: 13,
      bearing: 0,
      pitch: 30,
    );
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        onMapCreated: _onMapCreated,
        cameraOptions: cameraOptions,
      ),
    );
  }
}
