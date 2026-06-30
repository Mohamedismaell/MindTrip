import 'package:equatable/equatable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class RouteStep extends Equatable {
  final String instruction;
  final String maneuverType;
  final String? maneuverModifier;
  final double distance;
  final double duration;
  final String? bannerText;
  final String? bannerType;
  final String? bannerModifier;
  final Position? maneuverLocation;

  const RouteStep({
    required this.instruction,
    required this.maneuverType,
    this.maneuverModifier,
    required this.distance,
    required this.duration,
    this.bannerText,
    this.bannerType,
    this.bannerModifier,
    this.maneuverLocation,
  });

  @override
  List<Object?> get props => [
    instruction,
    maneuverType,
    maneuverModifier,
    distance,
    duration,
    bannerText,
    bannerType,
    bannerModifier,
    maneuverLocation,
  ];
}
