import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/save_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/delete_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/generate_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';
import 'package:uuid/uuid.dart';

class TripsCubit extends Cubit<TripsState> {
  final GetAllTripsUseCase _getAllTrips;
  final SaveTripUseCase _saveTrip;
  final DeleteTripUseCase _deleteTrip;
  final UpdateTripUseCase _updateTrip;
  final GenerateItineraryUseCase _generateItinerary;
  final SaveItineraryUseCase _saveItinerary;
  final _uuid = const Uuid();

  TripsCubit({
    required GetAllTripsUseCase getAllTrips,
    required SaveTripUseCase saveTrip,
    required DeleteTripUseCase deleteTrip,
    required UpdateTripUseCase updateTrip,
    required GenerateItineraryUseCase generateItinerary,
    required SaveItineraryUseCase saveItinerary,
  })  : _getAllTrips = getAllTrips,
        _saveTrip = saveTrip,
        _deleteTrip = deleteTrip,
        _updateTrip = updateTrip,
        _generateItinerary = generateItinerary,
        _saveItinerary = saveItinerary,
        super(TripsState(focusedDay: DateTime.now()));

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

    final result = await _getAllTrips();
    if (isClosed) return;

    result.when(
      success: (trips) {
        emit(state.copyWith(tripsStatus: TripsStatus.loaded, trips: trips));
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to load trips: ${error.message}',
          ),
        );
      },
    );
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
    );

    if (isClosed) return newTrip.id;
    final updatedTrips = List<Trip>.from(state.trips)..add(newTrip);
    emit(state.copyWith(trips: updatedTrips));
    return newTrip.id;
  }

  Future<void> saveTripDraft(Trip trip) async {
    final result = await _saveTrip(trip);
    if (isClosed) return;

    result.when(
      success: (_) {
        final index = state.trips.indexWhere((t) => t.id == trip.id);
        final updatedTrips = List<Trip>.from(state.trips);
        if (index != -1) {
          updatedTrips[index] = trip;
        } else {
          updatedTrips.add(trip);
        }
        emit(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to save draft: ${error.message}',
          ),
        );
      },
    );
  }

  Future<void> completeTrip(String tripId) async {
    final index = state.getTripIndex(tripId);
    if (index == -1) return;

    final trip = state.trips[index].copyWith(
      status: TripStatus.inProgress,
      updatedAt: DateTime.now(),
    );

    final result = await _saveTrip(trip);
    if (isClosed) return;

    result.when(
      success: (_) {
        final updatedTrips = List<Trip>.from(state.trips);
        updatedTrips[index] = trip;
        emit(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to complete trip: ${error.message}',
          ),
        );
      },
    );
  }

  Future<void> generateTrip(String tripId) async {
    final index = state.getTripIndex(tripId);
    if (index == -1) return;

    emit(state.copyWith(isGenerating: true, clearGeneratedTripId: true));

    final trip = state.trips[index];

    final itineraryResult = await _generateItinerary(trip);
    if (isClosed) return;

    itineraryResult.when(
      success: (itinerary) async {
        final saveItineraryResult = await _saveItinerary(itinerary);
        if (isClosed) return;

        saveItineraryResult.when(
          success: (_) async {
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

            final updatedTrip = trip.copyWith(
              status: TripStatus.draft,
              updatedAt: DateTime.now(),
              itineraryCoverUrl: coverUrl,
              placePreviews: previews,
            );

            final saveTripResult = await _saveTrip(updatedTrip);
            if (isClosed) return;

            saveTripResult.when(
              success: (_) {
                final updatedTrips = List<Trip>.from(state.trips);
                updatedTrips[index] = updatedTrip;

                emit(
                  state.copyWith(
                    trips: updatedTrips,
                    isGenerating: false,
                    generatedTripId: tripId,
                  ),
                );
              },
              failure: (error) {
                emit(
                  state.copyWith(
                    tripsStatus: TripsStatus.error,
                    isGenerating: false,
                    errorMessage: 'Failed to update trip object: ${error.message}',
                  ),
                );
              },
            );
          },
          failure: (error) {
            emit(
              state.copyWith(
                tripsStatus: TripsStatus.error,
                isGenerating: false,
                errorMessage: 'Failed to save itinerary: ${error.message}',
              ),
            );
          },
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            isGenerating: false,
            errorMessage: 'Failed to generate itinerary: ${error.message}',
          ),
        );
      },
    );
  }

  Future<void> deleteTrip(String tripId) async {
    final result = await _deleteTrip(tripId);
    if (isClosed) return;

    result.when(
      success: (_) {
        final updatedTrips = state.trips.where((t) => t.id != tripId).toList();
        emit(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to delete trip: ${error.message}',
          ),
        );
      },
    );
  }

  Future<void> updateTripTitle(String tripId, String newTitle) async {
    final index = state.getTripIndex(tripId);
    if (index == -1) return;

    final trip = state.trips[index].copyWith(
      title: newTitle,
      updatedAt: DateTime.now(),
    );
    
    final result = await _updateTrip(trip);
    if (isClosed) return;

    result.when(
      success: (_) {
        final updatedTrips = List<Trip>.from(state.trips);
        updatedTrips[index] = trip;
        emit(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emit(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to update title: ${error.message}',
          ),
        );
      },
    );
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
