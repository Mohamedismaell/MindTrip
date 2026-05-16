import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';

class TripItinerary extends Equatable {
  const TripItinerary({
    required this.tripId,
    required this.days,
    required this.estimatedTotalCost,
  });

  final String tripId;
  final List<TripDay> days;
  final double estimatedTotalCost;

  @override
  List<Object?> get props => [tripId, days, estimatedTotalCost];
}
