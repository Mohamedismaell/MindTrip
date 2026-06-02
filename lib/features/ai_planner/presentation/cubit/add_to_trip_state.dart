import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';

enum AddToTripStatus {
  initial,
  loadingTrips,
  selectTrip,
  selectDay,
  processing,
  added,
  managing,
  creatingNew,
  error
}

class AddToTripState extends Equatable {
  final AddToTripStatus status;
  final PlaceEntity place;
  final List<Trip> trips;
  final Trip? selectedTrip;
  final TripItinerary? selectedItinerary;
  final bool placeAlreadyInTrip;
  final String? hostTripName;
  final String? hostTripId;
  final String? errorMessage;

  const AddToTripState({
    this.status = AddToTripStatus.initial,
    required this.place,
    this.trips = const [],
    this.selectedTrip,
    this.selectedItinerary,
    this.placeAlreadyInTrip = false,
    this.hostTripName,
    this.hostTripId,
    this.errorMessage,
  });

  AddToTripState copyWith({
    AddToTripStatus? status,
    PlaceEntity? place,
    List<Trip>? trips,
    Trip? selectedTrip,
    TripItinerary? selectedItinerary,
    bool? placeAlreadyInTrip,
    String? hostTripName,
    String? hostTripId,
    String? errorMessage,
    bool clearHostTrip = false,
  }) {
    return AddToTripState(
      status: status ?? this.status,
      place: place ?? this.place,
      trips: trips ?? this.trips,
      selectedTrip: selectedTrip ?? this.selectedTrip,
      selectedItinerary: selectedItinerary ?? this.selectedItinerary,
      placeAlreadyInTrip: placeAlreadyInTrip ?? this.placeAlreadyInTrip,
      hostTripName: clearHostTrip ? null : (hostTripName ?? this.hostTripName),
      hostTripId: clearHostTrip ? null : (hostTripId ?? this.hostTripId),
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        place,
        trips,
        selectedTrip,
        selectedItinerary,
        placeAlreadyInTrip,
        hostTripName,
        hostTripId,
        errorMessage,
      ];
}
