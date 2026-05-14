import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/trip_repository.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';
import 'package:uuid/uuid.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepository _tripRepository;
  final _uuid = const Uuid();

  TripsCubit(this._tripRepository) : super(const TripsState());

  Future<void> loadTrips() async {
    emit(state.copyWith(status: TripsStatus.loading));
    try {
      final trips = await _tripRepository.getAllTrips();
      emit(state.copyWith(status: TripsStatus.loaded, trips: trips));
    } catch (e) {
      emit(
        state.copyWith(
          status: TripsStatus.error,
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

    try {
      await _tripRepository.saveTrip(newTrip);
      final updatedTrips = List<Trip>.from(state.trips)..add(newTrip);
      emit(state.copyWith(trips: updatedTrips));
      return newTrip.id;
    } catch (e) {
      emit(
        state.copyWith(
          status: TripsStatus.error,
          errorMessage: 'Failed to create draft: $e',
        ),
      );
      rethrow;
    }
  }

  Future<void> saveTripDraft(Trip trip) async {
    try {
      await _tripRepository.saveTrip(trip);
      final index = state.trips.indexWhere((t) => t.id == trip.id);
      final updatedTrips = List<Trip>.from(state.trips);
      if (index != -1) {
        updatedTrips[index] = trip;
      } else {
        updatedTrips.add(trip);
      }

      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      emit(
        state.copyWith(
          status: TripsStatus.error,
          errorMessage: 'Failed to save draft: $e',
        ),
      );
    }
  }

  Future<void> completeTrip(String tripId) async {
    try {
      final index = state.trips.indexWhere((t) => t.id == tripId);
      if (index == -1) return;

      final trip = state.trips[index].copyWith(
        status: TripStatus.completed,
        updatedAt: DateTime.now(),
      );

      await _tripRepository.saveTrip(trip);

      final updatedTrips = List<Trip>.from(state.trips);
      updatedTrips[index] = trip;

      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      emit(
        state.copyWith(
          status: TripsStatus.error,
          errorMessage: 'Failed to complete trip: $e',
        ),
      );
    }
  }

  Future<void> deleteTrip(String tripId) async {
    try {
      await _tripRepository.deleteTrip(tripId);

      final updatedTrips = state.trips.where((t) => t.id != tripId).toList();
      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      emit(
        state.copyWith(
          status: TripsStatus.error,
          errorMessage: 'Failed to delete trip: $e',
        ),
      );
    }
  }

  Future<void> updateTripTitle(String tripId, String newTitle) async {
    try {
      final index = state.trips.indexWhere((t) => t.id == tripId);
      if (index == -1) return;

      final trip = state.trips[index].copyWith(
        title: newTitle,
        updatedAt: DateTime.now(),
      );
      //! Same as save jsut for scalling
      await _tripRepository.updateTrip(trip);

      final updatedTrips = List<Trip>.from(state.trips);
      updatedTrips[index] = trip;

      emit(state.copyWith(trips: updatedTrips));
    } catch (e) {
      emit(
        state.copyWith(
          status: TripsStatus.error,
          errorMessage: 'Failed to update title: $e',
        ),
      );
    }
  }
}
