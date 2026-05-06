// // lib/features/map/presentation/pages/map_poi_test_screen.dart
// // Self-contained test — no external dependencies needed

// import 'package:flutter/material.dart';
// import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

// // ─── Data ────────────────────────────────────────────────────────────────────

// class _SelectedPOI {
//   final String name;
//   final String? category;
//   final String? maki;

//   const _SelectedPOI({required this.name, this.category, this.maki});
// }

// // ─── Screen ──────────────────────────────────────────────────────────────────

// class MapPOITestScreen extends StatefulWidget {
//   const MapPOITestScreen({super.key});

//   @override
//   State<MapPOITestScreen> createState() => _MapPOITestScreenState();
// }

// class _MapPOITestScreenState extends State<MapPOITestScreen> {
//   MapboxMap? _mapboxMap;
//   _SelectedPOI? _selectedPOI;

//   Future<void> _onMapCreated(MapboxMap mapboxMap) async {
//     _mapboxMap = mapboxMap;

//     // Keep the outdoor/daylight look
//     await mapboxMap.style.setStyleImportConfigProperties("basemap", {
//       "lightPreset": "day",
//       "showPointOfInterestLabels": true,
//     });

//     // Make ALL built-in POI icons tappable
//     mapboxMap.addInteraction(
//       TapInteraction(StandardPOIs(), (feature, _) {
//         final maki = feature.properties?['maki'] as String?;
//         final category = feature.properties?['class'] as String?;
//         setState(() {
//           _selectedPOI = _SelectedPOI(
//             name: feature.name ?? 'Unknown',
//             maki: maki,
//             category: category,
//           );
//         });
//         debugPrint(
//           'Tapped POI → name: ${feature.name}, maki: $maki, category: $category',
//         );
//       }, radius: 12),
//       interactionID: "tap_poi",
//     );

//     // Long tap anywhere → dismiss bottom sheet
//     mapboxMap.addInteraction(
//       LongTapInteraction.onMap((_) {
//         mapboxMap.resetFeatureStatesForFeatureset(StandardPOIs());
//         setState(() => _selectedPOI = null);
//       }),
//       interactionID: "long_tap_reset",
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('POI Tap Test')),
//       body: Stack(
//         children: [
//           // ── Map ────────────────────────────────────────────────────────────
//           MapWidget(
//             key: const ValueKey("mapWidget"),
//             onMapCreated: _onMapCreated,
//             styleUri: MapboxStyles.STANDARD,
//             cameraOptions: CameraOptions(
//               center: Point(coordinates: Position(31.2357, 30.0444)), // Cairo
//               zoom: 12,
//             ),
//           ),

//           // ── Bottom Sheet ───────────────────────────────────────────────────
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeOut,
//             bottom: _selectedPOI != null ? 0 : -250,
//             left: 0,
//             right: 0,
//             child: _POIBottomSheet(
//               poi: _selectedPOI,
//               onClose: () => setState(() => _selectedPOI = null),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─── Bottom Sheet Widget ──────────────────────────────────────────────────────

// class _POIBottomSheet extends StatelessWidget {
//   final _SelectedPOI? poi;
//   final VoidCallback onClose;

//   const _POIBottomSheet({required this.poi, required this.onClose});

//   @override
//   Widget build(BuildContext context) {
//     if (poi == null) return const SizedBox.shrink();

//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.surface,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black26,
//             blurRadius: 16,
//             offset: Offset(0, -4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Drag handle
//           Container(
//             width: 40,
//             height: 4,
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade300,
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),

//           Row(
//             children: [
//               // Icon
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.primaryContainer,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Icon(
//                   _makiToIcon(poi!.maki),
//                   color: Theme.of(context).colorScheme.primary,
//                   size: 32,
//                 ),
//               ),
//               const SizedBox(width: 16),

//               // Name + Category
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       poi!.name,
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     if (poi!.category != null) ...[
//                       const SizedBox(height: 4),
//                       Text(
//                         poi!.category!,
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                     if (poi!.maki != null) ...[
//                       const SizedBox(height: 2),
//                       Text(
//                         'maki: ${poi!.maki}',
//                         style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                           color: Colors.grey.shade400,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),

//               // Close button
//               IconButton(icon: const Icon(Icons.close), onPressed: onClose),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   IconData _makiToIcon(String? maki) {
//     switch (maki) {
//       case 'hospital':
//         return Icons.local_hospital;
//       case 'pharmacy':
//         return Icons.local_pharmacy;
//       case 'airport':
//         return Icons.local_airport;
//       case 'restaurant':
//         return Icons.restaurant;
//       case 'cafe':
//         return Icons.local_cafe;
//       case 'fast-food':
//         return Icons.fastfood;
//       case 'bar':
//         return Icons.local_bar;
//       case 'hotel':
//         return Icons.hotel;
//       case 'beach':
//         return Icons.beach_access;
//       case 'park':
//         return Icons.park;
//       case 'museum':
//         return Icons.museum;
//       case 'bus':
//         return Icons.directions_bus;
//       case 'rail':
//         return Icons.train;
//       case 'fuel':
//         return Icons.local_gas_station;
//       case 'bank':
//         return Icons.account_balance;
//       case 'atm':
//         return Icons.atm;
//       case 'supermarket':
//         return Icons.shopping_cart;
//       case 'shopping-mall':
//         return Icons.local_mall;
//       case 'school':
//         return Icons.school;
//       case 'place-of-worship':
//         return Icons.mosque;
//       case 'police':
//         return Icons.local_police;
//       case 'fire-station':
//         return Icons.fire_truck;
//       case 'post':
//         return Icons.local_post_office;
//       case 'parking':
//         return Icons.local_parking;
//       default:
//         return Icons.place;
//     }
//   }
// }
