import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
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

  Future<void> init() async {
    final result = await _getTripContainingPlace(state.place.id);
    if (isClosed) return;

    result.when(
      success: (trip) {
        if (trip != null) {
          emit(
            state.copyWith(
              flowStatus: AddToTripFlowStatus.initial,
              placeAlreadyInTrip: true,
              hostTripName: trip.title,
              hostTripId: trip.id,
            ),
          );
        } else {
          emit(
            state.copyWith(
              flowStatus: AddToTripFlowStatus.initial,
              placeAlreadyInTrip: false,
              clearHostTrip: true,
            ),
          );
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
        flowStatus: AddToTripFlowStatus.initial,
        addingStatus: ActionStatus.initial,
        creatingStatus: ActionStatus.initial,
      ),
    );
  }

  void backToSelectTrip() {
    emit(
      state.copyWith(
        flowStatus: AddToTripFlowStatus.selectTrip,
        selectedItinerary: null,
        selectedTrip: null,
      ),
    );
  }

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
            flowStatus: state.flowStatus == AddToTripFlowStatus.initial
                ? AddToTripFlowStatus.selectTrip
                : state.flowStatus,
            trips: trips
                .where((t) => t.status != TripStatus.completed)
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

  Future<void> selectTrip(Trip trip) async {
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _getItinerary(trip.id);
    if (isClosed) return;

    result.when(
      success: (itinerary) {
        if (itinerary == null) {
          emit(
            state.copyWith(
              addingStatus: ActionStatus.error,
              errorMessage: 'Itinerary not found',
            ),
          );
          return;
        }
        emit(
          state.copyWith(
            flowStatus: AddToTripFlowStatus.selectDay,
            addingStatus: ActionStatus.initial,
            selectedTrip: trip,
            selectedItinerary: itinerary,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: 'Failed to load itinerary: ${error.message}',
          ),
        );
      },
    );
  }

  void selectDay(int dayNumber) {
    emit(state.copyWith(selectedDay: dayNumber));
  }

  Future<void> addToTrip({int? dayNumber, PlaceDayPeriod? period}) async {
    if (state.selectedTrip == null) return;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _addPlaceUseCase(
      tripId: state.selectedTrip!.id,
      place: state.place,
      dayNumber: dayNumber,
      period: period,
    );
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            flowStatus: AddToTripFlowStatus.added,
            addingStatus: ActionStatus.success,
            placeAlreadyInTrip: true,
            hostTripId: state.selectedTrip!.id,
            hostTripName: state.selectedTrip!.title,
            selectedDay: null,
            selectedItinerary: null,
            selectedTrip: null,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: 'Failed to add place: ${error.message}',
          ),
        );
      },
    );
  }

  void triggerCreateNew() {
    emit(state.copyWith(flowStatus: AddToTripFlowStatus.creatingNew));
  }

  Future<void> onTripGenerated(String tripId) async {
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _getTripById(tripId);
    if (isClosed) return;

    result.when(
      success: (trip) async {
        if (trip != null) {
          emit(state.copyWith(selectedTrip: trip));
          await addToTrip();
        } else {
          emit(
            state.copyWith(
              addingStatus: ActionStatus.error,
              errorMessage: 'Generated trip not found',
            ),
          );
        }
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: 'Failed to load new trip: ${error.message}',
          ),
        );
      },
    );
  }

  void openManage() {
    emit(state.copyWith(flowStatus: AddToTripFlowStatus.managing));
  }

  Future<void> quickGenerateTrip({
    required DateTime startDate,
    required DateTime endDate,
    required String budgetTier,
    required int numberOfPeople,
  }) async {
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
      tripStart: startDate,
      tripEnd: endDate,
      adults: numberOfPeople,
      children: 0,
      pets: 0,
      budgetTier: budgetTier,
      customBudget: '',
      interests: const [],
    );

    final saveResult = await _saveTrip(trip);
    if (isClosed) return;

    saveResult.when(
      success: (_) async {
        final itineraryResult = await _generateItinerary(trip);
        if (isClosed) return;

        itineraryResult.when(
          success: (itinerary) async {
            final saveItineraryResult = await _saveItinerary(itinerary);
            if (isClosed) return;

            saveItineraryResult.when(
              success: (_) async {
                emit(
                  state.copyWith(
                    selectedTrip: trip,
                    creatingStatus: ActionStatus.success,
                  ),
                );
                await addToTrip();
              },
              failure: (error) {
                emit(
                  state.copyWith(
                    creatingStatus: ActionStatus.error,
                    errorMessage:
                        'Failed to save generated itinerary: ${error.message}',
                  ),
                );
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
          },
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            creatingStatus: ActionStatus.error,
            errorMessage: 'Failed to save trip draft: ${error.message}',
          ),
        );
      },
    );
  }

  Future<void> moveToDay(int toDayNumber, PlaceDayPeriod toPeriod) async {
    if (state.hostTripId == null) return;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _movePlaceInTripUseCase(
      tripId: state.hostTripId!,
      placeId: state.place.id,
      toDayNumber: toDayNumber,
      toPeriod: toPeriod,
    );

    if (isClosed) return;

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            flowStatus: AddToTripFlowStatus.added,
            addingStatus: ActionStatus.success,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> moveToAnotherTrip(
    Trip targetTrip,
    int toDayNumber,
    PlaceDayPeriod toPeriod,
  ) async {
    if (state.hostTripId == null) return;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _movePlaceBetweenTripsUseCase(
      sourceTripId: state.hostTripId!,
      targetTripId: targetTrip.id,
      placeId: state.place.id,
      toDayNumber: toDayNumber,
      toPeriod: toPeriod,
    );

    if (isClosed) return;

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            flowStatus: AddToTripFlowStatus.added,
            addingStatus: ActionStatus.success,
            hostTripId: targetTrip.id,
            hostTripName: targetTrip.title,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> removeFromTrip() async {
    if (state.hostTripId == null) return;
    emit(state.copyWith(addingStatus: ActionStatus.processing));

    final result = await _removePlaceUseCase(
      tripId: state.hostTripId!,
      placeId: state.place.id,
    );

    if (isClosed) return;

    result.when(
      success: (_) {
        emit(
          state.copyWith(
            flowStatus: AddToTripFlowStatus.initial,
            addingStatus: ActionStatus.success,
            placeAlreadyInTrip: false,
            clearHostTrip: true,
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            addingStatus: ActionStatus.error,
            errorMessage: error.message,
          ),
        );
      },
    );
  }
}
