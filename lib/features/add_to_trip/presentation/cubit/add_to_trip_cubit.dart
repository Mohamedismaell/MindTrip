import 'dart:async';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/generate_plan_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_containing_place_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/save_trip_use_case.dart';
import 'package:uuid/uuid.dart';

class AddToTripCubit extends SafeCubit<AddToTripState> {
  // final GetTripContainingPlaceUseCase _getTripContainingPlace;
  // final GetAllTripsUseCase _getAllTrips;
  // final GetItineraryUseCase _getItinerary;
  // final AddPlaceToTripUseCase _addPlaceUseCase;
  // final RemovePlaceFromTripUseCase _removePlaceUseCase;
  // final MovePlaceInTripUseCase _movePlaceInTripUseCase;
  // final MovePlaceBetweenTripsUseCase _movePlaceBetweenTripsUseCase;
  // final GetTripByIdUseCase _getTripById;
  // final SaveTripUseCase _saveTrip;
  // final SaveItineraryUseCase _saveItinerary;
  final GeneratePlanUseCase _generateItinerary;

  AddToTripCubit({
    required PlaceEntity place,
    // required GetTripContainingPlaceUseCase getTripContainingPlace,
    // required GetAllTripsUseCase getAllTrips,
    // required GetItineraryUseCase getItinerary,
    // required AddPlaceToTripUseCase addPlaceUseCase,
    // required RemovePlaceFromTripUseCase removePlaceUseCase,
    // required MovePlaceInTripUseCase movePlaceInTripUseCase,
    // required MovePlaceBetweenTripsUseCase movePlaceBetweenTripsUseCase,
    // required GetTripByIdUseCase getTripById,
    // required SaveTripUseCase saveTrip,
    required GeneratePlanUseCase generateItinerary,
    // required SaveItineraryUseCase saveItinerary,
  }) : //  _getTripContainingPlace = getTripContainingPlace,
       //  _getAllTrips = getAllTrips,
       //  _getItinerary = getItinerary,
       //  _addPlaceUseCase = addPlaceUseCase,
       //  _removePlaceUseCase = removePlaceUseCase,
       //  _movePlaceInTripUseCase = movePlaceInTripUseCase,
       //  _movePlaceBetweenTripsUseCase = movePlaceBetweenTripsUseCase,
       //  _getTripById = getTripById,
       //  _saveTrip = saveTrip,
       _generateItinerary = generateItinerary,
       //  _saveItinerary = saveItinerary,
       super(AddToTripState(place: place));

  //  Initialization ─

  // Future<void> init() async {
  //   final result = await _getTripContainingPlace(state.place.id);

  //   result.when(
  //     success: (trip) {
  //       if (trip != null) {
  //         emitSafe(
  //           state.copyWith(
  //             placeAlreadyInTrip: true,
  //             hostTripName: trip.title,
  //             hostTripId: trip.id,
  //           ),
  //         );
  //       } else {
  //         emitSafe(state.copyWith(placeAlreadyInTrip: false, clearHostTrip: true));
  //       }
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsLoadStatus.error,
  //           errorMessage: 'Initialization failed: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // void reset() {
  //   emitSafe(
  //     state.copyWith(
  //       addingStatus: ActionStatus.initial,
  //       creatingStatus: ActionStatus.initial,
  //     ),
  //   );
  // }

  // void clearSelection() {
  //   emitSafe(
  //     state.copyWith(
  //       clearSelectedTrip: true,
  //       clearSelectedItinerary: true,
  //       clearSelectedDayPeriod: true,
  //       itineraryStatus: TripsLoadStatus.initial,
  //       addingStatus: ActionStatus.initial,
  //     ),
  //   );
  // }

  // //  Trip List

  // Future<void> loadTrips() async {
  //   emitSafe(state.copyWith(tripsStatus: TripsLoadStatus.loading));

  //   final result = await _getAllTrips();

  //   await Future.delayed(const Duration(seconds: 2));
  //   result.when(
  //     success: (trips) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsLoadStatus.loaded,
  //           trips: trips
  //               .where(
  //                 (t) =>
  //                     t.status != TripStatus.completed &&
  //                     t.status != TripStatus.draft,
  //               )
  //               .toList(),
  //         ),
  //       );
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsLoadStatus.error,
  //           errorMessage: 'Failed to load trips: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // //  Selection & Navigation

  // /// Loads the itinerary for [trip]. Returns `true` on success.
  // Future<bool> selectTrip(Trip trip) async {
  //   emitSafe(state.copyWith(itineraryStatus: TripsLoadStatus.loading));

  //   final result = await _getItinerary(trip.id);

  //   await Future.delayed(const Duration(seconds: 2));

  //   return result.when(
  //     success: (itinerary) {
  //       if (itinerary == null) {
  //         emitSafe(
  //           state.copyWith(
  //             itineraryStatus: TripsLoadStatus.error,
  //             errorMessage: 'Itinerary not found',
  //           ),
  //         );
  //         return false;
  //       }
  //       emitSafe(
  //         state.copyWith(
  //           itineraryStatus: TripsLoadStatus.loaded,
  //           selectedTrip: trip,
  //           selectedItinerary: itinerary,
  //           clearSelectedDayPeriod: true,
  //         ),
  //       );
  //       return true;
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           itineraryStatus: TripsLoadStatus.error,
  //           errorMessage: 'Failed to load itinerary: ${error.message}',
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }

  // Future<bool> loadHostTripItinerary() async {
  //   if (state.hostTripId == null) return false;
  //   emitSafe(state.copyWith(itineraryStatus: TripsLoadStatus.loading));

  //   final result = await _getTripById(state.hostTripId!);

  //   await Future.delayed(const Duration(seconds: 2));

  //   return result.when(
  //     success: (trip) async {
  //       if (trip != null) {
  //         return await selectTrip(trip);
  //       } else {
  //         emitSafe(
  //           state.copyWith(
  //             itineraryStatus: TripsLoadStatus.error,
  //             errorMessage: 'Original trip could not be found.',
  //           ),
  //         );
  //         return false;
  //       }
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           itineraryStatus: TripsLoadStatus.error,
  //           errorMessage: 'Failed to load trip: ${error.message}',
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }

  // void selectPeriod(int dayNumber, PlaceDayPeriod period) {
  //   emitSafe(state.copyWith(selectedDay: dayNumber, selectedPeriod: period));
  // }

  // //  Actions

  // Future<bool> addToTrip({int? dayNumber, PlaceDayPeriod? period}) async {
  //   if (state.selectedTrip == null) return false;
  //   emitSafe(state.copyWith(addingStatus: ActionStatus.processing));

  //   final result = await _addPlaceUseCase(
  //     tripId: state.selectedTrip!.id,
  //     place: state.place,
  //     dayNumber: dayNumber ?? state.selectedDay,
  //     period: period ?? state.selectedPeriod,
  //   );
  //   await Future.delayed(const Duration(seconds: 3));

  //   return result.when(
  //     success: (_) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.success,
  //           placeAlreadyInTrip: true,
  //           hostTripId: state.selectedTrip!.id,
  //           hostTripName: state.selectedTrip!.title,
  //         ),
  //       );
  //       return true;
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.error,
  //           errorMessage: 'Failed to add place: ${error.message}',
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }

  // Future<bool> moveToDay({
  //   required int toDayNumber,
  //   required PlaceDayPeriod toPeriod,
  // }) async {
  //   if (state.hostTripId == null) return false;
  //   emitSafe(state.copyWith(addingStatus: ActionStatus.processing));

  //   final result = await _movePlaceInTripUseCase(
  //     tripId: state.hostTripId!,
  //     placeId: state.place.id,
  //     toDayNumber: toDayNumber,
  //     toPeriod: toPeriod,
  //   );
  //   await Future.delayed(const Duration(seconds: 2));

  //   return result.when(
  //     success: (_) {
  //       emitSafe(state.copyWith(addingStatus: ActionStatus.success));
  //       return true;
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.error,
  //           errorMessage: error.message,
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }

  // Future<bool> moveToAnotherTrip(
  //   Trip targetTrip,
  //   int toDayNumber,
  //   PlaceDayPeriod toPeriod,
  // ) async {
  //   if (state.hostTripId == null) return false;
  //   emitSafe(state.copyWith(addingStatus: ActionStatus.processing));

  //   final result = await _movePlaceBetweenTripsUseCase(
  //     sourceTripId: state.hostTripId!,
  //     targetTripId: targetTrip.id,
  //     placeId: state.place.id,
  //     toDayNumber: toDayNumber,
  //     toPeriod: toPeriod,
  //   );
  //   await Future.delayed(const Duration(seconds: 2));

  //   return result.when(
  //     success: (_) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.success,
  //           hostTripId: targetTrip.id,
  //           hostTripName: targetTrip.title,
  //         ),
  //       );
  //       return true;
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.error,
  //           errorMessage: error.message,
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }

  // Future<bool> removeFromTrip() async {
  //   if (state.hostTripId == null) return false;
  //   emitSafe(state.copyWith(addingStatus: ActionStatus.processing));

  //   final result = await _removePlaceUseCase(
  //     tripId: state.hostTripId!,
  //     placeId: state.place.id,
  //   );
  //   await Future.delayed(const Duration(seconds: 2));

  //   return result.when(
  //     success: (_) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.success,
  //           placeAlreadyInTrip: false,
  //           clearHostTrip: true,
  //         ),
  //       );
  //       return true;
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           addingStatus: ActionStatus.error,
  //           errorMessage: error.message,
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }

  // //  AI Planner

  // void selectTripDate(DateTime day) {
  //   final picked = DateTime(day.year, day.month, day.day);
  //   if (state.startDate == null ||
  //       (state.startDate != null && state.endDate != null)) {
  //     emitSafe(state.copyWith(startDate: picked, clearEndDate: true));
  //     return;
  //   }
  //   if (picked.isBefore(state.startDate!)) {
  //     emitSafe(state.copyWith(startDate: picked));
  //     return;
  //   }
  //   emitSafe(state.copyWith(endDate: picked));
  // }

  // void updateBudget(String budget) {
  //   emitSafe(state.copyWith(selectedBudget: budget));
  // }

  // void updatePeople(int people) {
  //   emitSafe(state.copyWith(numberOfPeople: people.clamp(1, 10)));
  // }

  // Future<bool> quickGenerateTrip() async {
  //   if (state.startDate == null || state.endDate == null) return false;

  //   emitSafe(state.copyWith(creatingStatus: ActionStatus.processing));

  //   final destination = state.place.location.address;
  //   final now = DateTime.now();
  //   final tripId = const Uuid().v4();

  //   final trip = Trip(
  //     id: tripId,
  //     title: 'Trip to $destination',
  //     status: TripStatus.draft,
  //     createdAt: now,
  //     updatedAt: now,
  //     destination: destination,
  //     tripStart: state.startDate!,
  //     tripEnd: state.endDate!,
  //     people: state.numberOfPeople,
  //     totalBudget: 0,
  //     totalCost: 0,
  //     interests: const [],
  //   );

  //   final saveResult = await _saveTrip(trip);

  //   return await saveResult.when(
  //     success: (_) async {
  //       final itResult = await _generateItinerary(trip);

  //       return await itResult.when(
  //         success: (itinerary) async {
  //           final saveItResult = await _saveItinerary(itinerary);

  //           return await saveItResult.when(
  //             success: (_) async {
  //               final result = await _addPlaceUseCase(
  //                 tripId: trip.id,
  //                 place: state.place,
  //                 dayNumber: 1, // Default for new generated trips
  //                 period: PlaceDayPeriod.morning,
  //               );

  //               return result.when(
  //                 success: (_) {
  //                   emitSafe(
  //                     state.copyWith(
  //                       creatingStatus: ActionStatus.success,
  //                       addingStatus: ActionStatus.success,
  //                       selectedTrip: trip,
  //                       placeAlreadyInTrip: true,
  //                       hostTripId: trip.id,
  //                       hostTripName: trip.title,
  //                     ),
  //                   );
  //                   return true;
  //                 },
  //                 failure: (error) {
  //                   emitSafe(
  //                     state.copyWith(
  //                       creatingStatus: ActionStatus.error,
  //                       errorMessage:
  //                           'Trip created, but failed to add place: ${error.message}',
  //                     ),
  //                   );
  //                   return false;
  //                 },
  //                 cancelled: () => false,
  //               );
  //             },
  //             failure: (error) {
  //               emitSafe(
  //                 state.copyWith(
  //                   creatingStatus: ActionStatus.error,
  //                   errorMessage: 'Failed to save itinerary: ${error.message}',
  //                 ),
  //               );
  //               return false;
  //             },
  //             cancelled: () => false,
  //           );
  //         },
  //         failure: (error) {
  //           emitSafe(
  //             state.copyWith(
  //               creatingStatus: ActionStatus.error,
  //               errorMessage: 'Failed to generate itinerary: ${error.message}',
  //             ),
  //           );
  //           return false;
  //         },
  //         cancelled: () => false,
  //       );
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           creatingStatus: ActionStatus.error,
  //           errorMessage: 'Failed to create trip: ${error.message}',
  //         ),
  //       );
  //       return false;
  //     },
  //     cancelled: () => false,
  //   );
  // }
}
