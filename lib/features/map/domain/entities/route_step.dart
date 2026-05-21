import 'package:equatable/equatable.dart';

class RouteStep extends Equatable {
  /// Human-readable instruction (e.g., "Turn left onto Main St")
  final String instruction;

  /// Maneuver type: "turn", "arrive", "depart", "roundabout", "merge", etc.
  final String maneuverType;

  /// Maneuver modifier: "left", "right", "straight", "slight left", etc.
  final String? maneuverModifier;

  /// Distance for this step in meters
  final double distance;

  /// Duration for this step in seconds
  final double duration;

  /// Pre-formatted banner text for UI display
  final String? bannerText;

  /// Banner type (e.g., "turn", "arrive") for choosing an icon
  final String? bannerType;

  /// Banner modifier for icon direction
  final String? bannerModifier;

  const RouteStep({
    required this.instruction,
    required this.maneuverType,
    this.maneuverModifier,
    required this.distance,
    required this.duration,
    this.bannerText,
    this.bannerType,
    this.bannerModifier,
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
  ];
}
