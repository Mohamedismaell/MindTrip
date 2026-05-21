import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';
import 'package:uuid/uuid.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepository _tripRepository;
  final _uuid = const Uuid();

  TripsCubit(this._tripRepository)
    : super(TripsState(focusedDay: DateTime.now()));

  Future<void> updateSearchQuary(String? searchQuary) async {
    if (isClosed) return;
    emit(state.copyWith(searchQuery: searchQuary));
  }

  Future<void> updateSelectedTab(TripFilterTab? selectedTap) async {
    if (isClosed) return;
    emit(state.copyWith(selectedTab: selectedTap));
  }

  Future<void> loadTrips() async {
    if (isClosed) return;
    emit(state.copyWith(tripsStatus: TripsStatus.loading));
    try {
      final trips = await _tripRepository.getAllTrips();
      if (isClosed) return;
      emit(state.copyWith(tripsStatus: TripsStatus.loaded, trips: trips));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          tripsStatus: TripsStatus.error,
          errorMessage: 'Failed to load trips: $e',
        ),
      );
    }
  }

  Future<String> createDraft(String destination) async {
    final now = DateTime.now();
    final newTrip = Trip(
      id: _uuid.v4(),
      title: 'Trip to $destination',
      status: TripStatus.draft,
      createdAt: now,
      updatedAt: now,
      destination: destination,
      adults: 1,
      children: 0,
      pets: 0,
      customBudget: '',
      interests: const [],
      currentPage: 0,
      chatMessages: const [],
    );

    if (isClosed) return newTrip.id;
    final updatedTrips = List<Trip>.from(state.trips)..add(newTrip);
    emit(state.copyWith(trips: updatedTrips));
    return newTrip.id;
  }

  Future<void> saveTripDraft(Trip trip) async {
    try {
      await _tripRepository.saveTrip(trip);
      if (isClosed) return;
      final index = state.trips.indexWhere((t) => t.id == trip.id);
      final updatedTrips = List<Trip>.from(state.trips);
      if (index != -1) {
        updatedTrips[index] = trip;
      } else {
        updatedTrips.add(trip);
      }

      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          tripsStatus: TripsStatus.error,
          errorMessage: 'Failed to save draft: $e',
        ),
      );
    }
  }

  Future<void> completeTrip(String tripId) async {
    try {
      final index = state.getTripIndex(tripId);
      if (index == -1) return;

      // 'Save Trip' transitions draft → inProgress (the user is committing to go)
      final trip = state.trips[index].copyWith(
        status: TripStatus.inProgress,
        updatedAt: DateTime.now(),
      );

      await _tripRepository.saveTrip(trip);
      if (isClosed) return;

      final updatedTrips = List<Trip>.from(state.trips);
      updatedTrips[index] = trip;

      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          tripsStatus: TripsStatus.error,
          errorMessage: 'Failed to complete trip: $e',
        ),
      );
    }
  }

  //Todo: edit with real api
  Future<void> generateTrip(String tripId) async {
    final index = state.getTripIndex(tripId);
    if (index == -1) return;

    // Emit generating state so UI can show dialog reactively
    emit(state.copyWith(isGenerating: true, clearGeneratedTripId: true));

    try {
      final trip = state.trips[index];

      // Call backend / mock — this returns the full itinerary
      final itinerary = await _tripRepository.generateItinerary(trip);

      // Save itinerary locally
      await _tripRepository.saveItinerary(itinerary);

      // Extract lightweight preview data from the itinerary
      final allPlaces = itinerary.days
          .expand((day) => day.timeSlots.expand((slot) => slot.places))
          .toList();

      String? coverUrl;
      final previews = <Map<String, String>>[];
      for (final place in allPlaces) {
        final imgUrl = place.imageUrls?.firstOrNull ?? '';
        if (coverUrl == null && imgUrl.isNotEmpty) {
          coverUrl = imgUrl;
        }
        previews.add({'name': place.name, 'imageUrl': imgUrl});
      }

      // Keep trip as draft — status only changes when user taps 'Save Trip'
      final updatedTrip = trip.copyWith(
        status: TripStatus.draft,
        updatedAt: DateTime.now(),
        itineraryCoverUrl: coverUrl,
        placePreviews: previews,
      );
      await _tripRepository.saveTrip(updatedTrip);
      if (isClosed) return;

      final updatedTrips = List<Trip>.from(state.trips);
      updatedTrips[index] = updatedTrip;

      // Emit success state with generatedTripId
      emit(
        state.copyWith(
          trips: updatedTrips,
          isGenerating: false,
          generatedTripId: tripId,
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          tripsStatus: TripsStatus.error,
          isGenerating: false,
          errorMessage: 'Failed to generate itinerary: $e',
        ),
      );
    }
  }

  Future<void> deleteTrip(String tripId) async {
    try {
      await _tripRepository.deleteTrip(tripId);
      if (isClosed) return;

      final updatedTrips = state.trips.where((t) => t.id != tripId).toList();
      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          tripsStatus: TripsStatus.error,
          errorMessage: 'Failed to delete trip: $e',
        ),
      );
    }
  }

  Future<void> updateTripTitle(String tripId, String newTitle) async {
    try {
      final index = state.getTripIndex(tripId);
      if (index == -1) return;

      final trip = state.trips[index].copyWith(
        title: newTitle,
        updatedAt: DateTime.now(),
      );
      //! Same as save jsut for scalling
      await _tripRepository.updateTrip(trip);
      if (isClosed) return;

      final updatedTrips = List<Trip>.from(state.trips);
      updatedTrips[index] = trip;

      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          tripsStatus: TripsStatus.error,
          errorMessage: 'Failed to update title: $e',
        ),
      );
    }
  }

  void nextMonth(DateTime focusedDay) {
    emit(
      state.copyWith(
        focusedDay: DateTime(focusedDay.year, focusedDay.month + 1),
      ),
    );
  }

  void previouseMonth(DateTime focusedDay) {
    emit(
      state.copyWith(
        focusedDay: DateTime(focusedDay.year, focusedDay.month - 1),
      ),
    );
  }

  void changeMonth(DateTime focusedDay) {
    emit(state.copyWith(focusedDay: focusedDay));
  }

  void selectDay(DateTime selected, DateTime focused) {
    emit(state.copyWith(selectedDay: selected, focusedDay: focused));
  }
}
