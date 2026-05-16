import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

enum TripDetailsStatus { loading, loaded, error }

class TripDetailsState extends Equatable {
  final Trip? trip;
  final TripItinerary? itinerary;
  final TripDetailsStatus status;
  final Set<int> expandedDays;
  final String? errorMessage;

  const TripDetailsState({
    this.trip,
    this.itinerary,
    this.status = TripDetailsStatus.loading,
    this.expandedDays = const {},
    this.errorMessage,
  });

  TripDetailsState copyWith({
    Trip? trip,
    TripItinerary? itinerary,
    TripDetailsStatus? status,
    Set<int>? expandedDays,
    String? errorMessage,
  }) {
    return TripDetailsState(
      trip: trip ?? this.trip,
      itinerary: itinerary ?? this.itinerary,
      status: status ?? this.status,
      expandedDays: expandedDays ?? this.expandedDays,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [trip, itinerary, status, expandedDays, errorMessage];
}
