import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

enum AddToTripFlowStatus {
  initial,
  selectTrip,
  selectDay,
  managing,
  creatingNew,
  added,
}

enum TripsLoadStatus { initial, loading, loaded, error }

enum ActionStatus { initial, processing, success, error }

class AddToTripState extends Equatable {
  final AddToTripFlowStatus flowStatus;
  final TripsLoadStatus tripsStatus;
  final ActionStatus addingStatus;
  final ActionStatus creatingStatus;
  final PlaceEntity place;
  final List<Trip> trips;
  final Trip? selectedTrip;
  final TripItinerary? selectedItinerary;
  final int? selectedDay;
  final bool placeAlreadyInTrip;
  final String? hostTripName;
  final String? hostTripId;
  final String? errorMessage;

  const AddToTripState({
    this.flowStatus = AddToTripFlowStatus.initial,
    this.tripsStatus = TripsLoadStatus.initial,
    this.addingStatus = ActionStatus.initial,
    this.creatingStatus = ActionStatus.initial,
    required this.place,
    this.trips = const [],
    this.selectedTrip,
    this.selectedItinerary,
    this.placeAlreadyInTrip = false,
    this.hostTripName,
    this.hostTripId,
    this.errorMessage,
    this.selectedDay,
  });

  AddToTripState copyWith({
    AddToTripFlowStatus? flowStatus,
    TripsLoadStatus? tripsStatus,
    ActionStatus? addingStatus,
    ActionStatus? creatingStatus,
    PlaceEntity? place,
    List<Trip>? trips,
    Trip? selectedTrip,
    TripItinerary? selectedItinerary,
    bool? placeAlreadyInTrip,
    String? hostTripName,
    String? hostTripId,
    String? errorMessage,
    bool clearHostTrip = false,
    int? selectedDay,
  }) {
    return AddToTripState(
      flowStatus: flowStatus ?? this.flowStatus,
      tripsStatus: tripsStatus ?? this.tripsStatus,
      addingStatus: addingStatus ?? this.addingStatus,
      creatingStatus: creatingStatus ?? this.creatingStatus,
      place: place ?? this.place,
      trips: trips ?? this.trips,
      selectedTrip: selectedTrip ?? this.selectedTrip,
      selectedItinerary: selectedItinerary ?? this.selectedItinerary,
      placeAlreadyInTrip: placeAlreadyInTrip ?? this.placeAlreadyInTrip,
      hostTripName: clearHostTrip ? null : (hostTripName ?? this.hostTripName),
      hostTripId: clearHostTrip ? null : (hostTripId ?? this.hostTripId),
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDay: selectedDay ?? this.selectedDay,
    );
  }

  @override
  List<Object?> get props => [
    flowStatus,
    tripsStatus,
    addingStatus,
    creatingStatus,
    place,
    trips,
    selectedTrip,
    selectedItinerary,
    placeAlreadyInTrip,
    hostTripName,
    hostTripId,
    errorMessage,
    selectedDay,
  ];
}
