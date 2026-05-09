import 'package:equatable/equatable.dart';
import 'route_step.dart';

class RouteLeg extends Equatable {
  /// Ordered list of maneuver steps in this leg
  final List<RouteStep> steps;

  /// Total distance for this leg in meters
  final double distance;

  /// Total duration for this leg in seconds
  final double duration;

  /// Per-segment congestion levels (only for driving-traffic profile).
  /// Values: "unknown", "low", "moderate", "heavy", "severe"
  final List<String>? congestionLevels;

  const RouteLeg({
    required this.steps,
    required this.distance,
    required this.duration,
    this.congestionLevels,
  });

  @override
  List<Object?> get props => [steps, distance, duration, congestionLevels];
}
