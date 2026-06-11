import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/itinerary/domain/entities/time_slot.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/generate_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/get_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_by_id_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_trip_containing_place_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/save_trip_use_case.dart';
import 'package:uuid/uuid.dart';

class AddToTripCubit extends Cubit<AddToTripState> {
  final GetTripContainingPlaceUseCase _getTripContainingPlace;
  final GetAllTripsUseCase _getAllTrips;
  final GetItineraryUseCase _getItinerary;
  final AddPlaceToTripUseCase _addPlaceUseCase;
  final RemovePlaceFromTripUseCase _removePlaceUseCase;
  final MovePlaceInTripUseCase _movePlaceInTripUseCase;
  final MovePlaceBetweenTripsUseCase _movePlaceBetweenTripsUseCase;
  final GetTripByIdUseCase _getTripById;
  final SaveTripUseCase _saveTrip;
  final GenerateItineraryUseCase _generateItinerary;
  final SaveItineraryUseCase _saveItinerary;

  AddToTripCubit({
    required PlaceEntity place,
    required GetTripContainingPlaceUseCase getTripContainingPlace,
    required GetAllTripsUseCase getAllTrips,
    required GetItineraryUseCase getItinerary,
    required AddPlaceToTripUseCase addPlaceUseCase,
    required RemovePlaceFromTripUseCase removePlaceUseCase,
    required MovePlaceInTripUseCase movePlaceInTripUseCase,
    required MovePlaceBetweenTripsUseCase movePlaceBetweenTripsUseCase,
    required GetTripByIdUseCase getTripById,
    required SaveTripUseCase saveTrip,
    required GenerateItineraryUseCase generateItinerary,
    required SaveItineraryUseCase saveItinerary,
  }) : _getTripContainingPlace = getTripContainingPlace,
       _getAllTrips = getAllTrips,
       _getItinerary = getItinerary,
       _addPlaceUseCase = addPlaceUseCase,
       _removePlaceUseCase = removePlaceUseCase,
       _movePlaceInTripUseCase = movePlaceInTripUseCase,
       _movePlaceBetweenTripsUseCase = movePlaceBetweenTripsUseCase,
       _getTripById = getTripById,
       _saveTrip = saveTrip,
       _generateItinerary = generateItinerary,
       _saveItinerary = saveItinerary,
       super(AddToTripState(place: place));

  //  Initialization ─

  Future<void> init() async {
    final result = await _getTripContainingPlace(state.place.id);
    if (isClosed) return;

    result.when(
      success: (trip) {
        if (trip != null) {
          emit(
            state.copyWith(
              placeAlreadyInTrip: true,
              hostTripName: trip.title,
              hostTripId: trip.id,
            ),
          );
        } else {
          emit(state.copyWith(placeAlreadyInTrip: false, clearHostTrip: true));
        }
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsLoadStatus.error,
            errorMessage: 'Initialization failed: ${error.message}',
          ),
        );
      },
    );
  }

  void reset() {
    emit(
      state.copyWith(
        addingStatus: ActionStatus.initial,
        creatingStatus: ActionStatus.initial,
      ),
    );
  }

  void clearSelection() {
    emit(
      state.copyWith(
        clearSelectedTrip: true,
        clearSelectedItinerary: true,
        clearSelectedDayPeriod: true,
        itineraryStatus: TripsLoadStatus.initial,
        addingStatus: ActionStatus.initial,
      ),
    );
  }

  //  Trip List

  Future<void> loadTrips() async {
    emit(state.copyWith(tripsStatus: TripsLoadStatus.loading));

    final result = await _getAllTrips();
    if (isClosed) return;
    await Future.delayed(const Duration(seconds: 2));
    result.when(
      success: (trips) {
        emit(
          state.copyWith(
            tripsStatus: TripsLoadStatus.loaded,
            trips: trips
                .where(
                  (t) =>
                      t.status != TripStatus.completed &&
                      t.status != TripStatus.draft,
                )
                .toList(),
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsLoadStatus.error,
            errorMessage: 'Failed to load trips: ${error.message}',
          ),
        );
      },
    );
  }

  //  Selection & Navigation

  /// Loads the itinerary for [trip]. Returns `true` on success.
  Future<bool> selectTrip(Trip trip) async {
    emit(state.copyWith(itineraryStatus: TripsLoadStatus.loading));

    final result = await _getItinerary(trip.id);
    if (isClosed) return false;
    await Future.delayed(const Duration(seconds: 2));

    return result.when(
      success: (itinerary) {
        if (itinerary == null) {
          emit(
            state.copyWith(
              itineraryStatus: TripsLoadStatus.error,
              errorMessage: 'Itinerary not found',
            ),
          );
          return false;
        }
        emit(
          state.copyWith(
            itineraryStatus: TripsLoadStatus.loaded,
            selectedTrip: trip,
            selectedItinerary: itinerary,
            clearSelectedDayPeriod: true,
          ),
        );
        return true;
      },
      failure: (error) {
        emit(
          state.copyWith(
            itineraryStatus: TripsLoadStatus.error,
            errorMessage: 'Failed to load itinerary: ${error.message}',
          ),
        );
        return false;
      },
    );
  }

  Future<bool> loadHostTripItinerary() async {
    if (state.hostTripId == null) return false;
    emit(state.copyWith(itineraryStatus: TripsLoadStatus.loading));

    final result = await _getTripById(state.hostTripId!);
    if (isClosed) return false;
    await Future.delayed(const Duration(seconds: 2));

    return result.when(
      success: (trip) async {
        if (trip != null) {
          return await selectTrip(trip);
        } else {
          emit(
            state.copyWith(
              itineraryStatus: TripsLoadStatus.error,
              errorMessage: 'Original trip could not be found.',
            ),
          );
          return false;
        }
      },
      failure: (error) {
        emit(
          state.copyWith(
            itineraryStatus: TripsLoadStatus.error,
            errorMessage: 'Failed to load trip: ${error.message}',
          ),
        );
        return false;
      },
    );
  }

  void selectPeriod(int dayNumber, PlaceDayPeriod period) {
    emit(state.copyWith(selectedDay: dayNumber, selectedPeriod: period));
  }

  //  Actions

  Future<bool> addToTrip({int? dayNumber, PlaceDayPeriod? period}) async {
    if (state.selectedTrip == null) return false;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _addPlaceUseCase(
      tripId: state.selectedTrip!.id,
      place: state.place,
      dayNumber: dayNumber ?? state.selectedDay,
      period: period ?? state.selectedPeriod,
    );
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return false;

    return result.when(
      success: (_) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.success,
            placeAlreadyInTrip: true,
            hostTripId: state.selectedTrip!.id,
            hostTripName: state.selectedTrip!.title,
          ),
        );
        return true;
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: 'Failed to add place: ${error.message}',
          ),
        );
        return false;
      },
    );
  }

  Future<bool> moveToDay({
    required int toDayNumber,
    required PlaceDayPeriod toPeriod,
  }) async {
    if (state.hostTripId == null) return false;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _movePlaceInTripUseCase(
      tripId: state.hostTripId!,
      placeId: state.place.id,
      toDayNumber: toDayNumber,
      toPeriod: toPeriod,
    );
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return false;

    return result.when(
      success: (_) {
        emit(state.copyWith(addingStatus: ActionStatus.success));
        return true;
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> moveToAnotherTrip(
    Trip targetTrip,
    int toDayNumber,
    PlaceDayPeriod toPeriod,
  ) async {
    if (state.hostTripId == null) return false;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _movePlaceBetweenTripsUseCase(
      sourceTripId: state.hostTripId!,
      targetTripId: targetTrip.id,
      placeId: state.place.id,
      toDayNumber: toDayNumber,
      toPeriod: toPeriod,
    );
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return false;

    return result.when(
      success: (_) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.success,
            hostTripId: targetTrip.id,
            hostTripName: targetTrip.title,
          ),
        );
        return true;
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  Future<bool> removeFromTrip() async {
    if (state.hostTripId == null) return false;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _removePlaceUseCase(
      tripId: state.hostTripId!,
      placeId: state.place.id,
    );
    await Future.delayed(const Duration(seconds: 2));
    if (isClosed) return false;

    return result.when(
      success: (_) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.success,
            placeAlreadyInTrip: false,
            clearHostTrip: true,
          ),
        );
        return true;
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: error.message,
          ),
        );
        return false;
      },
    );
  }

  //  AI Planner

  void selectTripDate(DateTime day) {
    final picked = DateTime(day.year, day.month, day.day);
    if (state.startDate == null ||
        (state.startDate != null && state.endDate != null)) {
      emit(state.copyWith(startDate: picked, clearEndDate: true));
      return;
    }
    if (picked.isBefore(state.startDate!)) {
      emit(state.copyWith(startDate: picked));
      return;
    }
    emit(state.copyWith(endDate: picked));
  }

  void updateBudget(String budget) {
    emit(state.copyWith(selectedBudget: budget));
  }

  void updatePeople(int people) {
    emit(state.copyWith(numberOfPeople: people.clamp(1, 10)));
  }

  Future<bool> quickGenerateTrip() async {
    if (state.startDate == null || state.endDate == null) return false;

    emit(state.copyWith(creatingStatus: ActionStatus.processing));

    final destination = state.place.location.address;
    final now = DateTime.now();
    final tripId = const Uuid().v4();

    final trip = Trip(
      id: tripId,
      title: 'Trip to $destination',
      status: TripStatus.draft,
      createdAt: now,
      updatedAt: now,
      destination: destination,
      tripStart: state.startDate!,
      tripEnd: state.endDate!,
      adults: state.numberOfPeople,
      children: 0,
      budgetTier: state.selectedBudget ?? 'Economic',
      customBudget: '',
      interests: const [],
    );

    final saveResult = await _saveTrip(trip);
    if (isClosed) return false;

    return await saveResult.when(
      success: (_) async {
        final itResult = await _generateItinerary(trip);
        if (isClosed) return false;

        return await itResult.when(
          success: (itinerary) async {
            final saveItResult = await _saveItinerary(itinerary);
            if (isClosed) return false;

            return await saveItResult.when(
              success: (_) async {
                final result = await _addPlaceUseCase(
                  tripId: trip.id,
                  place: state.place,
                  dayNumber: 1, // Default for new generated trips
                  period: PlaceDayPeriod.morning,
                );

                if (isClosed) return false;

                return result.when(
                  success: (_) {
                    emit(
                      state.copyWith(
                        creatingStatus: ActionStatus.success,
                        addingStatus: ActionStatus.success,
                        selectedTrip: trip,
                        placeAlreadyInTrip: true,
                        hostTripId: trip.id,
                        hostTripName: trip.title,
                      ),
                    );
                    return true;
                  },
                  failure: (error) {
                    emit(
                      state.copyWith(
                        creatingStatus: ActionStatus.error,
                        errorMessage:
                            'Trip created, but failed to add place: ${error.message}',
                      ),
                    );
                    return false;
                  },
                );
              },
              failure: (error) {
                emit(
                  state.copyWith(
                    creatingStatus: ActionStatus.error,
                    errorMessage: 'Failed to save itinerary: ${error.message}',
                  ),
                );
                return false;
              },
            );
          },
          failure: (error) {
            emit(
              state.copyWith(
                creatingStatus: ActionStatus.error,
                errorMessage: 'Failed to generate itinerary: ${error.message}',
              ),
            );
            return false;
          },
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            creatingStatus: ActionStatus.error,
            errorMessage: 'Failed to create trip: ${error.message}',
          ),
        );
        return false;
      },
    );
  }
}
