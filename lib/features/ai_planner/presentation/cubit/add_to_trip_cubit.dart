import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/add_place_to_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/move_place_between_trips_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/move_place_in_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/remove_place_from_trip_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:uuid/uuid.dart';

class AddToTripCubit extends Cubit<AddToTripState> {
  final TripRepository _tripRepository;
  final AddPlaceToTripUseCase _addPlaceUseCase;
  final RemovePlaceFromTripUseCase _removePlaceUseCase;
  final MovePlaceInTripUseCase _movePlaceInTripUseCase;
  final MovePlaceBetweenTripsUseCase _movePlaceBetweenTripsUseCase;

  AddToTripCubit({
    required PlaceEntity place,
    required TripRepository tripRepository,
    required AddPlaceToTripUseCase addPlaceUseCase,
    required RemovePlaceFromTripUseCase removePlaceUseCase,
    required MovePlaceInTripUseCase movePlaceInTripUseCase,
    required MovePlaceBetweenTripsUseCase movePlaceBetweenTripsUseCase,
  })  : _tripRepository = tripRepository,
        _addPlaceUseCase = addPlaceUseCase,
        _removePlaceUseCase = removePlaceUseCase,
        _movePlaceInTripUseCase = movePlaceInTripUseCase,
        _movePlaceBetweenTripsUseCase = movePlaceBetweenTripsUseCase,
        super(AddToTripState(place: place));

  Future<void> init() async {
    try {
      final trip = await _tripRepository.getTripContainingPlace(state.place.id);
      if (isClosed) return;
      if (trip != null) {
        emit(state.copyWith(
          status: AddToTripStatus.initial,
          placeAlreadyInTrip: true,
          hostTripName: trip.title,
          hostTripId: trip.id,
        ));
      } else {
        emit(state.copyWith(
          status: AddToTripStatus.initial,
          placeAlreadyInTrip: false,
          clearHostTrip: true,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: 'Initialization failed: $e',
      ));
    }
  }

  void reset() {
    emit(state.copyWith(status: AddToTripStatus.initial));
  }

  Future<void> loadTrips() async {
    emit(state.copyWith(status: AddToTripStatus.loadingTrips));
    try {
      final trips = await _tripRepository.getAllTrips();
      if (isClosed) return;
      // Filter out completed trips
      emit(state.copyWith(
        status: AddToTripStatus.selectTrip,
        trips: trips.where((t) => t.status != TripStatus.completed).toList(),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: 'Failed to load trips: $e',
      ));
    }
  }

  Future<void> selectTrip(Trip trip) async {
    emit(state.copyWith(status: AddToTripStatus.processing));
    try {
      final itinerary = await _tripRepository.getItinerary(trip.id);
      if (isClosed) return;
      if (itinerary == null) {
        throw Exception('Itinerary not found');
      }
      emit(state.copyWith(
        status: AddToTripStatus.selectDay,
        selectedTrip: trip,
        selectedItinerary: itinerary,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: 'Failed to load itinerary: $e',
      ));
    }
  }

  Future<void> addToTrip({int? dayNumber, DayPeriod? period}) async {
    if (state.selectedTrip == null) return;
    
    emit(state.copyWith(status: AddToTripStatus.processing));
    
    try {
      await _addPlaceUseCase(
        tripId: state.selectedTrip!.id,
        place: state.place,
        dayNumber: dayNumber,
        period: period,
      );
      
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.added, 
        placeAlreadyInTrip: true,
        hostTripId: state.selectedTrip!.id,
        hostTripName: state.selectedTrip!.title,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: 'Failed to add place: $e',
      ));
    }
  }

  void triggerCreateNew() {
    emit(state.copyWith(status: AddToTripStatus.creatingNew));
  }

  Future<void> onTripGenerated(String tripId) async {
     emit(state.copyWith(status: AddToTripStatus.processing));
     try {
       final trip = await _tripRepository.getTripById(tripId);
       if (isClosed) return;
       if (trip != null) {
          emit(state.copyWith(selectedTrip: trip));
          await addToTrip(); // Add via AI slot
       } else {
         throw Exception('Generated trip not found');
       }
     } catch(e) {
       if (isClosed) return;
       emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: 'Failed to add place to new trip: $e',
      ));
     }
  }

  void openManage() {
    emit(state.copyWith(status: AddToTripStatus.managing));
  }

  /// Called from the Quick AI Trip Planning sheet.
  /// Creates a draft trip from minimal form data then triggers generation.
  Future<void> quickGenerateTrip({
    required DateTime startDate,
    required DateTime endDate,
    required String budgetTier,
    required int numberOfPeople,
  }) async {
    emit(state.copyWith(status: AddToTripStatus.processing));
    try {
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
        currentPage: 4, // mark as ready-to-generate
        chatMessages: const [],
      );

      // Persist the draft
      await _tripRepository.saveTrip(trip);
      if (isClosed) return;

      // Generate the itinerary
      final itinerary = await _tripRepository.generateItinerary(trip);
      if (isClosed) return;
      await _tripRepository.saveItinerary(itinerary);
      if (isClosed) return;

      // Now add the place to the newly generated trip (AI decides the best slot)
      emit(state.copyWith(selectedTrip: trip));
      await addToTrip();

    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: 'Failed to create trip: $e',
      ));
    }
  }

  Future<void> moveToDay(int toDayNumber, DayPeriod toPeriod) async {
    if (state.hostTripId == null) return;
    emit(state.copyWith(status: AddToTripStatus.processing));
    try {
      await _movePlaceInTripUseCase(
        tripId: state.hostTripId!,
        placeId: state.place.id,
        toDayNumber: toDayNumber,
        toPeriod: toPeriod,
      );
      if (isClosed) return;
      emit(state.copyWith(status: AddToTripStatus.added));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> moveToAnotherTrip(
    Trip targetTrip,
    int toDayNumber,
    DayPeriod toPeriod,
  ) async {
    if (state.hostTripId == null) return;
    emit(state.copyWith(status: AddToTripStatus.processing));
    try {
      await _movePlaceBetweenTripsUseCase(
        sourceTripId: state.hostTripId!,
        targetTripId: targetTrip.id,
        placeId: state.place.id,
        toDayNumber: toDayNumber,
        toPeriod: toPeriod,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.added,
        hostTripId: targetTrip.id,
        hostTripName: targetTrip.title,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> removeFromTrip() async {
    if (state.hostTripId == null) return;
    emit(state.copyWith(status: AddToTripStatus.processing));
    try {
      await _removePlaceUseCase(
        tripId: state.hostTripId!,
        placeId: state.place.id,
      );
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.initial,
        placeAlreadyInTrip: false,
        clearHostTrip: true,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        status: AddToTripStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
