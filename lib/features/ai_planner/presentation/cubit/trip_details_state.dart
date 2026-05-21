import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

enum TripDetailsStatus { loading, loaded, error }

class TripDetailsState extends Equatable {
  final Trip? trip;
  final TripItinerary? itinerary;
  final TripDetailsStatus status;
  final int? activeDay;
  final String? errorMessage;

  const TripDetailsState({
    this.trip,
    this.itinerary,
    this.status = TripDetailsStatus.loading,
    this.activeDay,
    this.errorMessage,
  });

  TripDetailsState copyWith({
    Trip? trip,
    TripItinerary? itinerary,
    TripDetailsStatus? status,
    int? activeDay,
    bool clearActiveDay = false,
    String? errorMessage,
  }) {
    return TripDetailsState(
      trip: trip ?? this.trip,
      itinerary: itinerary ?? this.itinerary,
      status: status ?? this.status,
      activeDay: clearActiveDay ? null : (activeDay ?? this.activeDay),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [trip, itinerary, status, activeDay, errorMessage];
}
