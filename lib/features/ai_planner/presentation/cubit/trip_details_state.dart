import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

enum TripDetailsStatus { loading, loaded, error }

enum ItineraryEditStatus { idle, saving, saved, error }

class TripDetailsState extends Equatable {
  final Trip? trip;
  final TripItinerary? itinerary;
  final TripDetailsStatus status;
  final int? activeDay;
  final String? errorMessage;
  final ItineraryEditStatus editStatus;
  final String? lastEditMessage;

  const TripDetailsState({
    this.trip,
    this.itinerary,
    this.status = TripDetailsStatus.loading,
    this.activeDay,
    this.errorMessage,
    this.editStatus = ItineraryEditStatus.idle,
    this.lastEditMessage,
  });

  TripDetailsState copyWith({
    Trip? trip,
    TripItinerary? itinerary,
    TripDetailsStatus? status,
    int? activeDay,
    bool clearActiveDay = false,
    String? errorMessage,
    ItineraryEditStatus? editStatus,
    String? lastEditMessage,
  }) {
    return TripDetailsState(
      trip: trip ?? this.trip,
      itinerary: itinerary ?? this.itinerary,
      status: status ?? this.status,
      activeDay: clearActiveDay ? null : (activeDay ?? this.activeDay),
      errorMessage: errorMessage ?? this.errorMessage,
      editStatus: editStatus ?? this.editStatus,
      lastEditMessage: lastEditMessage ?? this.lastEditMessage,
    );
  }

  @override
  List<Object?> get props => [
    trip,
    itinerary,
    status,
    activeDay,
    errorMessage,
    editStatus,
    lastEditMessage,
  ];
}
