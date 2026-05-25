import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';

/// Wraps [List<TripDay>] so it can be passed through go_router `extra`.
class MapTripExtra {
  const MapTripExtra({required this.days});
  final List<TripDay> days;
}
