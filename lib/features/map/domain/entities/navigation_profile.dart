import 'package:flutter/material.dart';

enum NavigationProfile {
  driving('driving', 'Drive', Icons.directions_car),
  drivingTraffic('driving-traffic', 'Traffic', Icons.traffic),
  walking('walking', 'Walk', Icons.directions_walk),
  cycling('cycling', 'Cycle', Icons.directions_bike);

  const NavigationProfile(this.apiValue, this.label, this.icon);

  final String apiValue;
  final String label;
  final IconData icon;

  /// Whether this profile supports congestion annotations
  bool get supportsCongestion => this == NavigationProfile.drivingTraffic;
}
