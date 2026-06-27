import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

part 'add_to_trip_state.freezed.dart';

enum AddToTripStatus { initial, loading, success, failure }

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
}
// enum TripsLoadStatus { initial, loading, loaded, error }

// enum ActionStatus { initial, processing, success, error }

// class AddToTripState extends Equatable {
//   final TripsLoadStatus tripsStatus;
//   final TripsLoadStatus itineraryStatus;
//   final ActionStatus addingStatus;
//   final ActionStatus creatingStatus;
//   final PlaceEntity place;
//   final List<Trip> trips;
//   final Trip? selectedTrip;
//   final TripItinerary? selectedItinerary;
//   final int? selectedDay;
//   final PlaceDayPeriod? selectedPeriod;
//   final bool placeAlreadyInTrip;
//   final String? hostTripName;
//   final String? hostTripId;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? selectedBudget;
//   final int numberOfPeople;
//   final String? errorMessage;

//   const AddToTripState({
//     this.tripsStatus = TripsLoadStatus.initial,
//     this.itineraryStatus = TripsLoadStatus.initial,
//     this.addingStatus = ActionStatus.initial,
//     this.creatingStatus = ActionStatus.initial,
//     required this.place,
//     this.trips = const [],
//     this.selectedTrip,
//     this.selectedItinerary,
//     this.placeAlreadyInTrip = false,
//     this.hostTripName,
//     this.hostTripId,
//     this.errorMessage,
//     this.selectedDay,
//     this.selectedPeriod,
//     this.startDate,
//     this.endDate,
//     this.selectedBudget,
//     this.numberOfPeople = 0,
//   });

//   AddToTripState copyWith({
//     TripsLoadStatus? tripsStatus,
//     TripsLoadStatus? itineraryStatus,
//     ActionStatus? addingStatus,
//     ActionStatus? creatingStatus,
//     PlaceEntity? place,
//     List<Trip>? trips,
//     Trip? selectedTrip,
//     TripItinerary? selectedItinerary,
//     bool? placeAlreadyInTrip,
//     String? hostTripName,
//     String? hostTripId,
//     String? errorMessage,
//     bool clearHostTrip = false,
//     bool clearSelectedTrip = false,
//     bool clearSelectedItinerary = false,
//     bool clearSelectedDayPeriod = false,
//     int? selectedDay,
//     PlaceDayPeriod? selectedPeriod,
//     DateTime? startDate,
//     DateTime? endDate,
//     String? selectedBudget,
//     int? numberOfPeople,
//     bool clearStartDate = false,
//     bool clearEndDate = false,
//   }) {
//     return AddToTripState(
//       tripsStatus: tripsStatus ?? this.tripsStatus,
//       itineraryStatus: itineraryStatus ?? this.itineraryStatus,
//       addingStatus: addingStatus ?? this.addingStatus,
//       creatingStatus: creatingStatus ?? this.creatingStatus,
//       place: place ?? this.place,
//       trips: trips ?? this.trips,
//       selectedTrip: clearSelectedTrip
//           ? null
//           : (selectedTrip ?? this.selectedTrip),
//       selectedItinerary: clearSelectedItinerary
//           ? null
//           : (selectedItinerary ?? this.selectedItinerary),
//       placeAlreadyInTrip: placeAlreadyInTrip ?? this.placeAlreadyInTrip,
//       hostTripName: clearHostTrip ? null : (hostTripName ?? this.hostTripName),
//       hostTripId: clearHostTrip ? null : (hostTripId ?? this.hostTripId),
//       errorMessage: errorMessage ?? this.errorMessage,
//       selectedDay: clearSelectedDayPeriod
//           ? null
//           : (selectedDay ?? this.selectedDay),
//       selectedPeriod: clearSelectedDayPeriod
//           ? null
//           : (selectedPeriod ?? this.selectedPeriod),
//       startDate: clearStartDate ? null : (startDate ?? this.startDate),
//       endDate: clearEndDate ? null : (endDate ?? this.endDate),
//       selectedBudget: selectedBudget ?? this.selectedBudget,
//       numberOfPeople: numberOfPeople ?? this.numberOfPeople,
//     );
//   }

//   @override
//   List<Object?> get props => [
//     tripsStatus,
//     itineraryStatus,
//     addingStatus,
//     creatingStatus,
//     place,
//     trips,
//     selectedTrip,
//     selectedItinerary,
//     placeAlreadyInTrip,
//     hostTripName,
//     hostTripId,
//     errorMessage,
//     selectedDay,
//     selectedPeriod,
//     startDate,
//     endDate,
//     selectedBudget,
//     numberOfPeople,
//   ];

//   String? get formattedStartDate =>
//       startDate != null ? DateFormat('dd/MM/yyyy').format(startDate!) : null;

//   String? get formattedEndDate =>
//       endDate != null ? DateFormat('dd/MM/yyyy').format(endDate!) : null;

//   bool get isPlanReady =>
//       startDate != null &&
//       endDate != null &&
//       selectedBudget != null &&
//       numberOfPeople > 0;

//   String get loadingTitle {
//     if (tripsStatus == TripsLoadStatus.loading) return 'Loading Trips';
//     if (itineraryStatus == TripsLoadStatus.loading) {
//       return 'Loading Itinerary';
//     }
//     if (addingStatus == ActionStatus.processing) {
//       if (placeAlreadyInTrip) return 'Updating your Trip';
//       return 'Adding to Trip';
//     }
//     if (creatingStatus == ActionStatus.processing) return 'Creating Your Trip';
//     return 'Processing';
//   }

//   String get loadingDescription {
//     if (tripsStatus == TripsLoadStatus.loading) {
//       return 'Please wait while we load your available trips.';
//     }
//     if (itineraryStatus == TripsLoadStatus.loading) {
//       return 'Please wait while we fetch the latest plan for the trip.';
//     }
//     if (addingStatus == ActionStatus.processing) {
//       return 'We are organizing your itinerary. Just a moment!';
//     }
//     if (creatingStatus == ActionStatus.processing) {
//       return 'Stand by while we prepare your new trip plan.';
//     }
//     return 'Please wait while we handle your request.';
//   }
// }
