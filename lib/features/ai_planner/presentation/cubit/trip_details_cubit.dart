import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/edit_itinerary_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_state.dart';

class TripDetailsCubit extends Cubit<TripDetailsState> {
  final TripRepository _tripRepository;
  final EditItineraryUseCase _editUseCase;

  TripDetailsCubit(this._tripRepository, this._editUseCase)
      : super(const TripDetailsState());

  // ────────────────────────────────────────────────────────────
  //  LOAD
  // ────────────────────────────────────────────────────────────

  Future<void> loadTripDetails(String tripId) async {
    if (isClosed) return;
    emit(state.copyWith(status: TripDetailsStatus.loading));

    try {
      final trip = await _tripRepository.getTripById(tripId);
      final itinerary = await _tripRepository.getItinerary(tripId);

      if (isClosed) return;
      emit(
        state.copyWith(
          trip: trip,
          itinerary: itinerary,
          status: TripDetailsStatus.loaded,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: TripDetailsStatus.error,
          errorMessage: 'Failed to load trip details: $e',
        ),
      );
    }
  }

  // ────────────────────────────────────────────────────────────
  //  DAY TOGGLE
  // ────────────────────────────────────────────────────────────

  void toggleActiveDay(int dayNumber) {
    if (isClosed) return;
    if (state.activeDay == dayNumber) {
      emit(state.copyWith(clearActiveDay: true));
    } else {
      emit(state.copyWith(activeDay: dayNumber));
    }
  }

  // ────────────────────────────────────────────────────────────
  //  ADD PLACE
  // ────────────────────────────────────────────────────────────

  /// Adds [place] to the specified [dayNumber] and [period].
  Future<void> addPlace({
    required int dayNumber,
    required DayPeriod period,
    required PlaceEntity place,
  }) async {
    if (state.itinerary == null || isClosed) return;

    final updated = _editUseCase.addPlace(
      state.itinerary!,
      dayNumber: dayNumber,
      period: period,
      place: place,
    );

    emit(state.copyWith(
      itinerary: updated,
      editStatus: ItineraryEditStatus.saved,
      lastEditMessage: '${place.name} added to Day $dayNumber',
    ));

    await _persistItinerary(updated);
  }

  /// Lets the algorithm pick the best (least-loaded) slot.
  Future<void> addPlaceAuto(PlaceEntity place) async {
    if (state.itinerary == null || isClosed) return;

    final (dayNumber, period) =
        _editUseCase.suggestBestSlot(state.itinerary!);

    await addPlace(dayNumber: dayNumber, period: period, place: place);
  }

  // ────────────────────────────────────────────────────────────
  //  REMOVE PLACE
  // ────────────────────────────────────────────────────────────

  Future<void> removePlace(String placeId) async {
    if (state.itinerary == null || isClosed) return;

    final updated = _editUseCase.removePlace(
      state.itinerary!,
      placeId: placeId,
    );

    emit(state.copyWith(
      itinerary: updated,
      editStatus: ItineraryEditStatus.saved,
      lastEditMessage: 'Place removed',
    ));

    await _persistItinerary(updated);
  }

  // ────────────────────────────────────────────────────────────
  //  MOVE PLACE (within same trip)
  // ────────────────────────────────────────────────────────────

  Future<void> movePlace({
    required String placeId,
    required int toDayNumber,
    required DayPeriod toPeriod,
  }) async {
    if (state.itinerary == null || isClosed) return;

    final updated = _editUseCase.movePlace(
      state.itinerary!,
      placeId: placeId,
      toDayNumber: toDayNumber,
      toPeriod: toPeriod,
    );

    emit(state.copyWith(
      itinerary: updated,
      editStatus: ItineraryEditStatus.saved,
      lastEditMessage: 'Moved to Day $toDayNumber',
    ));

    await _persistItinerary(updated);
  }

  // ────────────────────────────────────────────────────────────
  //  REORDER PLACE (drag & drop)
  // ────────────────────────────────────────────────────────────

  Future<void> reorderPlace({
    required int dayNumber,
    required DayPeriod period,
    required int oldIndex,
    required int newIndex,
  }) async {
    if (state.itinerary == null || isClosed) return;

    final updated = _editUseCase.reorderPlace(
      state.itinerary!,
      dayNumber: dayNumber,
      period: period,
      oldIndex: oldIndex,
      newIndex: newIndex,
    );

    emit(state.copyWith(itinerary: updated));
    await _persistItinerary(updated);
  }

  // ────────────────────────────────────────────────────────────
  //  PERSIST HELPERS
  // ────────────────────────────────────────────────────────────

  /// Saves the itinerary to Hive and syncs trip card previews.
  Future<void> _persistItinerary(dynamic updated) async {
    try {
      await _tripRepository.saveItinerary(updated);
      await _syncTripPreviews(updated);
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
        editStatus: ItineraryEditStatus.error,
        errorMessage: 'Failed to save: $e',
      ));
    }
  }

  /// Keeps the Trip card's placePreviews in sync using existing updateTrip().
  Future<void> _syncTripPreviews(dynamic itinerary) async {
    if (state.trip == null) return;

    final allPlaces = itinerary.days
        .expand((day) => day.timeSlots.expand((slot) => slot.places))
        .toList();

    final previews = allPlaces
        .map<Map<String, String>>((p) => {
              'name': p.name as String,
              'imageUrl': (p.imageUrls?.isNotEmpty == true
                  ? p.imageUrls!.first
                  : '') as String,
            })
        .toList();

    final updatedTrip = state.trip!.copyWith(
      placePreviews: previews,
      updatedAt: DateTime.now(),
    );

    await _tripRepository.updateTrip(updatedTrip);
    if (isClosed) return;
    emit(state.copyWith(trip: updatedTrip));
  }
}
