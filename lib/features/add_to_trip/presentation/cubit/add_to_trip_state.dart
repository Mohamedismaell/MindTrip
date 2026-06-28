import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

part 'add_to_trip_state.freezed.dart';

enum AddToTripStatus {
  initial,
  loadingTrips,
  loadingTripsFailure,

  generatingNewTripPlan,
  creatingTrip,

  editingExistingTripPlan,
  updatingTrip,

  success,
  generateFailure,
  saveFailure,
}

@freezed
abstract class AddToTripState with _$AddToTripState {
  const AddToTripState._();

  const factory AddToTripState({
    required PlaceEntity place,
    @Default(AddToTripStatus.initial) AddToTripStatus status,
    @Default([]) List<Trip> trips,
    Trip? selectedTrip,
    @Default('') String errorMessage,
    DateTime? startDate,
    DateTime? endDate,
    @Default(0) int adultCount,
    @Default('') String budget,
    @Default('') String customBudget,
    @Default(0) int currentPage,
  }) = _AddToTripState;

  String get finalBudget =>
      customBudget.trim().isNotEmpty ? customBudget.trim() : budget;

  bool get canCreateTrip =>
      startDate != null &&
      endDate != null &&
      finalBudget.isNotEmpty &&
      adultCount > 0;

  bool get isActionInProgress {
    switch (status) {
      case AddToTripStatus.generatingNewTripPlan:
      case AddToTripStatus.creatingTrip:
      case AddToTripStatus.editingExistingTripPlan:
      case AddToTripStatus.updatingTrip:
        return true;
      default:
        return false;
    }
  }

  bool get hasFailure {
    switch (status) {
      case AddToTripStatus.loadingTripsFailure:
      case AddToTripStatus.generateFailure:
      case AddToTripStatus.saveFailure:
        return true;
      default:
        return false;
    }
  }

  String get loadingTitle {
    switch (status) {
      case AddToTripStatus.loadingTrips:
        return 'Loading Trips';
      case AddToTripStatus.generatingNewTripPlan:
        return 'Generating Your Trip Plan';
      case AddToTripStatus.creatingTrip:
        return 'Creating Your Trip';
      case AddToTripStatus.editingExistingTripPlan:
        return 'Editing Existing Trip Plan';
      case AddToTripStatus.updatingTrip:
        return 'Updating Trip';
      default:
        return 'Processing';
    }
  }

  String get loadingDescription {
    switch (status) {
      case AddToTripStatus.loadingTrips:
        return 'Please wait while we load your available trips.';
      case AddToTripStatus.generatingNewTripPlan:
        return 'We are generating a new itinerary for this place.';
      case AddToTripStatus.creatingTrip:
        return 'We are saving your new trip.';
      case AddToTripStatus.editingExistingTripPlan:
        return 'We are editing the selected trip plan.';
      case AddToTripStatus.updatingTrip:
        return 'We are saving the updated trip plan.';
      default:
        return 'Please wait while we handle your request.';
    }
  }
}
