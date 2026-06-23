import 'package:flutter/material.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/save_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/delete_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_trip_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/generate_itinerary_use_case.dart';
import 'package:mindtrip/features/itinerary/domain/use_cases/save_itinerary_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';
import 'package:uuid/uuid.dart';

class TripsCubit extends SafeCubit<TripsState> {
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
  }) : _getAllTrips = getAllTrips,
       _saveTrip = saveTrip,
       _deleteTrip = deleteTrip,
       _updateTrip = updateTrip,
       _generateItinerary = generateItinerary,
       _saveItinerary = saveItinerary,
       super(TripsState(focusedDay: DateTime.now()));

  Future<void> updateSearchQuary(String? searchQuary) async {
    emitSafe(state.copyWith(searchQuery: searchQuary));
  }

  Future<void> updateSelectedTab(TripFilterTab? selectedTap) async {
    emitSafe(state.copyWith(selectedTab: selectedTap));
  }

  Future<void> loadTrips() async {
    emitSafe(state.copyWith(tripsStatus: TripsStatus.loading));

    final result = await _getAllTrips();
    
    result.when(
      success: (trips) {
        emitSafe(state.copyWith(tripsStatus: TripsStatus.loaded, trips: trips));
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to load trips: ${error.message}',
          ),
        );
      },
      cancelled: () {},
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
      customBudget: '',
      interests: const [],
    );

    final updatedTrips = List<Trip>.from(state.trips)..add(newTrip);
    emitSafe(state.copyWith(trips: updatedTrips));
    return newTrip.id;
  }

  Future<void> saveTripDraft(Trip trip) async {
    final result = await _saveTrip(trip);
    
    result.when(
      success: (_) {
        final index = state.trips.indexWhere((t) => t.id == trip.id);
        final updatedTrips = List<Trip>.from(state.trips);
        if (index != -1) {
          updatedTrips[index] = trip;
        } else {
          updatedTrips.add(trip);
        }
        emitSafe(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to save draft: ${error.message}',
          ),
        );
      },
      cancelled: () {},
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
    
    result.when(
      success: (_) {
        final updatedTrips = List<Trip>.from(state.trips);
        updatedTrips[index] = trip;
        emitSafe(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to complete trip: ${error.message}',
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> generateTrip(String tripId) async {
    final index = state.getTripIndex(tripId);
    if (index == -1) return;

    emitSafe(state.copyWith(isGenerating: true, clearGeneratedTripId: true));

    final trip = state.trips[index];

    final itineraryResult = await _generateItinerary(trip);
    
    itineraryResult.when(
      success: (itinerary) async {
        final saveItineraryResult = await _saveItinerary(itinerary);
        
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
            
            saveTripResult.when(
              success: (_) {
                final updatedTrips = List<Trip>.from(state.trips);
                updatedTrips[index] = updatedTrip;

                emitSafe(
                  state.copyWith(
                    trips: updatedTrips,
                    isGenerating: false,
                    generatedTripId: tripId,
                  ),
                );
              },
              failure: (error) {
                emitSafe(
                  state.copyWith(
                    tripsStatus: TripsStatus.error,
                    isGenerating: false,
                    errorMessage:
                        'Failed to update trip object: ${error.message}',
                  ),
                );
              },
              cancelled: () {},
            );
          },
          failure: (error) {
            emitSafe(
              state.copyWith(
                tripsStatus: TripsStatus.error,
                isGenerating: false,
                errorMessage: 'Failed to save itinerary: ${error.message}',
              ),
            );
          },
          cancelled: () {},
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            isGenerating: false,
            errorMessage: 'Failed to generate itinerary: ${error.message}',
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> deleteTrip(String tripId) async {
    final result = await _deleteTrip(tripId);
    
    result.when(
      success: (_) {
        final updatedTrips = state.trips.where((t) => t.id != tripId).toList();
        emitSafe(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to delete trip: ${error.message}',
          ),
        );
      },
      cancelled: () {},
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
    
    result.when(
      success: (_) {
        final updatedTrips = List<Trip>.from(state.trips);
        updatedTrips[index] = trip;
        emitSafe(state.copyWith(trips: updatedTrips));
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            tripsStatus: TripsStatus.error,
            errorMessage: 'Failed to update title: ${error.message}',
          ),
        );
      },
      cancelled: () {},
    );
  }

  List<Trip> getTripsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);

    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    return state.trips.where((trip) {
      if (trip.tripStart == null) return false;

      final start = trip.tripStart!;
      final end = trip.tripEnd ?? start;

      return start.isBefore(endOfMonth.add(const Duration(days: 1))) &&
          end.isAfter(startOfMonth.subtract(const Duration(days: 1)));
    }).toList();
  }

  List<Trip> getTripsForDay(DateTime day, List<Trip> trips) {
    final current = DateUtils.dateOnly(day);

    return trips.where((trip) {
      if (trip.tripStart == null || trip.tripEnd == null) {
        return false;
      }

      final start = DateUtils.dateOnly(trip.tripStart!);
      final end = DateUtils.dateOnly(trip.tripEnd!);

      return !current.isBefore(start) && !current.isAfter(end);
    }).toList();
  }

  void nextMonth(DateTime focusedDay) {
    emitSafe(
      state.copyWith(
        focusedDay: DateTime(focusedDay.year, focusedDay.month + 1),
      ),
    );
  }

  void previouseMonth(DateTime focusedDay) {
    emitSafe(
      state.copyWith(
        focusedDay: DateTime(focusedDay.year, focusedDay.month - 1),
      ),
    );
  }

  void changeMonth(DateTime focusedDay) {
    emitSafe(state.copyWith(focusedDay: focusedDay));
  }

  void selectDay(DateTime selected, DateTime focused) {
    emitSafe(state.copyWith(selectedDay: selected, focusedDay: focused));
  }
}
