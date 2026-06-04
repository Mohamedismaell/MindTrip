import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
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
  final TripsLoadStatus itineraryStatus;
  final ActionStatus addingStatus;
  final ActionStatus creatingStatus;
  final PlaceEntity place;
  final List<Trip> trips;
  final Trip? selectedTrip;
  final TripItinerary? selectedItinerary;
  final int? selectedDay;
  final PlaceDayPeriod? selectedPeriod;
  final bool placeAlreadyInTrip;
  final bool comeFromSelection;
  final String? hostTripName;
  final String? hostTripId;
  final String? errorMessage;

  const AddToTripState({
    this.flowStatus = AddToTripFlowStatus.initial,
    this.tripsStatus = TripsLoadStatus.initial,
    this.itineraryStatus = TripsLoadStatus.initial,
    this.addingStatus = ActionStatus.initial,
    this.creatingStatus = ActionStatus.initial,
    required this.place,
    this.trips = const [],
    this.selectedTrip,
    this.selectedItinerary,
    this.placeAlreadyInTrip = false,
    this.comeFromSelection = false,
    this.hostTripName,
    this.hostTripId,
    this.errorMessage,
    this.selectedDay,
    this.selectedPeriod,
  });

  AddToTripState copyWith({
    AddToTripFlowStatus? flowStatus,
    TripsLoadStatus? tripsStatus,
    TripsLoadStatus? itineraryStatus,
    ActionStatus? addingStatus,
    ActionStatus? creatingStatus,
    PlaceEntity? place,
    List<Trip>? trips,
    Trip? selectedTrip,
    TripItinerary? selectedItinerary,
    bool? placeAlreadyInTrip,
    bool? comeFromSelection,
    String? hostTripName,
    String? hostTripId,
    String? errorMessage,
    bool clearHostTrip = false,
    int? selectedDay,
    PlaceDayPeriod? selectedPeriod,
  }) {
    return AddToTripState(
      flowStatus: flowStatus ?? this.flowStatus,
      tripsStatus: tripsStatus ?? this.tripsStatus,
      itineraryStatus: itineraryStatus ?? this.itineraryStatus,
      addingStatus: addingStatus ?? this.addingStatus,
      creatingStatus: creatingStatus ?? this.creatingStatus,
      place: place ?? this.place,
      trips: trips ?? this.trips,
      selectedTrip: selectedTrip ?? this.selectedTrip,
      selectedItinerary: selectedItinerary ?? this.selectedItinerary,
      placeAlreadyInTrip: placeAlreadyInTrip ?? this.placeAlreadyInTrip,
      comeFromSelection: comeFromSelection ?? this.comeFromSelection,
      hostTripName: clearHostTrip ? null : (hostTripName ?? this.hostTripName),
      hostTripId: clearHostTrip ? null : (hostTripId ?? this.hostTripId),
      errorMessage: errorMessage ?? this.errorMessage,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  List<Object?> get props => [
    flowStatus,
    tripsStatus,
    itineraryStatus,
    addingStatus,
    creatingStatus,
    place,
    trips,
    selectedTrip,
    selectedItinerary,
    placeAlreadyInTrip,
    comeFromSelection,
    hostTripName,
    hostTripId,
    errorMessage,
    selectedDay,
    selectedPeriod,
  ];

  String get loadingTitle {
    if (tripsStatus == TripsLoadStatus.loading) return 'Loading Trips';
    if (itineraryStatus == TripsLoadStatus.loading) {
      return 'Loading Itinerary';
    }
    if (addingStatus == ActionStatus.processing) {
      if (placeAlreadyInTrip) return 'Updating your Trip';
      'Adding to Trip';
    }
    if (creatingStatus == ActionStatus.processing) return 'Creating Your Trip';
    return 'Processing';
  }

  String get loadingDescription {
    if (tripsStatus == TripsLoadStatus.loading) {
      return 'Please wait while we load your available trips.';
    }
    if (itineraryStatus == TripsLoadStatus.loading) {
      return 'Please wait while we fetch the latest plan for the trip.';
    }
    if (addingStatus == ActionStatus.processing) {
      return 'We are organizing your itinerary. Just a moment!';
    }
    if (creatingStatus == ActionStatus.processing) {
      return 'Stand by while we prepare your new trip plan.';
    }
    return 'Please wait while we handle your request.';
  }
}
