import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_day.dart';

class TripItinerary extends Equatable {
  const TripItinerary({
    required this.tripId,
    required this.days,
    required this.estimatedTotalCost,
  });

  final String tripId;
  final List<TripDay> days;
  final double estimatedTotalCost;

  TripItinerary copyWith({
    String? tripId,
    List<TripDay>? days,
    double? estimatedTotalCost,
  }) {
    return TripItinerary(
      tripId: tripId ?? this.tripId,
      days: days ?? this.days,
      estimatedTotalCost: estimatedTotalCost ?? this.estimatedTotalCost,
    );
  }

  // Total places across all days
  int get totalPlaces => days.fold(
    0,
    (sum, day) =>
        sum + day.timeSlots.fold(0, (s, slot) => s + slot.places.length),
  );

  @override
  List<Object?> get props => [tripId, days, estimatedTotalCost];
}
