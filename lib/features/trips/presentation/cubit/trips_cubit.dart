import 'package:flutter/material.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/domain/use_cases/delete_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/get_all_trips_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/rename_trip_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/share_trip_use_case.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';

class TripsCubit extends SafeCubit<TripsState> {
  final GetAllTripsUseCase _getAllTripsUseCase;
  final DeleteTripUseCase _deleteTripUseCase;
  final RenameTripUseCase _renameTripUseCase;
  final ShareTripUseCase _shareTripUseCase;

  TripsCubit(
    this._getAllTripsUseCase,
    this._deleteTripUseCase,
    this._renameTripUseCase,
    this._shareTripUseCase,
  ) : super(TripsState(focusedDay: DateTime.now()));

  void resetActionStatus() {
    emit(
      state.copyWith(actionStatus: TripsActionStatus.idle, actionError: null),
    );
  }

  Future<void> loadTrips({bool silent = false}) async {
    if (!silent) emitSafe(state.copyWith(tripsStatus: TripsStatus.loading));
    final result = await _getAllTripsUseCase();
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

  Future<void> deleteTrip(String tripId) async {
    emitSafe(state.copyWith(actionStatus: TripsActionStatus.loading));
    final result = await _deleteTripUseCase(tripId);
    result.when(
      success: (_) {
        final updatedTrips = state.trips
            .where((t) => t.tripId != tripId)
            .toList();
        emitSafe(
          state.copyWith(
            actionStatus: TripsActionStatus.success,
            trips: updatedTrips,
          ),
        );
      },
      failure: (error) => emitSafe(
        state.copyWith(
          actionStatus: TripsActionStatus.error,
          actionError: error.message,
        ),
      ),
      cancelled: () => resetActionStatus(),
    );
  }

  Future<void> shareTrip(String tripId) async {
    emitSafe(state.copyWith(actionStatus: TripsActionStatus.loading));
    final result = await _shareTripUseCase(tripId);
    result.when(
      success: (_) {
        emitSafe(state.copyWith(actionStatus: TripsActionStatus.success));
      },
      failure: (error) => emitSafe(
        state.copyWith(
          actionStatus: TripsActionStatus.error,
          actionError: error.message,
        ),
      ),
      cancelled: () => resetActionStatus(),
    );
  }

  Future<void> renameTrip(String tripId, String newName) async {
    emitSafe(state.copyWith(actionStatus: TripsActionStatus.loading));
    final result = await _renameTripUseCase(tripId, newName);
    result.when(
      success: (_) {
        emitSafe(state.copyWith(actionStatus: TripsActionStatus.success));
        loadTrips(silent: true);
      },
      failure: (error) => emitSafe(
        state.copyWith(
          actionStatus: TripsActionStatus.error,
          actionError: error.message,
        ),
      ),
      cancelled: () => resetActionStatus(),
    );
  }

  void onSearchChanged(String query) {
    emitSafe(state.copyWith(searchQuery: query));
  }

  void onTabChanged(int index) {
    final tab = TripFilterTab.values[index];
    emitSafe(state.copyWith(selectedTab: tab));
  }

  Future<void> updateSearchQuary(String? searchQuary) async {
    emitSafe(state.copyWith(searchQuery: searchQuary));
  }

  Future<void> updateSelectedTab(TripFilterTab? selectedTap) async {
    emitSafe(state.copyWith(selectedTab: selectedTap));
  }

  // Future<void> loadTrips() async {
  //   emitSafe(state.copyWith(tripsStatus: TripsStatus.loading));
  //   final result = await _repository.getAllTrips();
  //   result.when(
  //     success: (trips) {
  //       emitSafe(state.copyWith(tripsStatus: TripsStatus.loaded, trips: trips));
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsStatus.error,
  //           errorMessage: 'Failed to load trips: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // Future<String> createDraft(String destination) async {
  //   final now = DateTime.now();
  //   final newTrip = Trip(
  //     id: _uuid.v4(),
  //     title: 'Trip to $destination',
  //     status: TripStatus.draft,
  //     createdAt: now,
  //     updatedAt: now,
  //     destination: destination,
  //     people: 1,
  //     totalBudget: 0,
  //     totalCost: 0,
  //     interests: const [],
  //   );
  //   final updatedTrips = List<Trip>.from(state.trips)..add(newTrip);
  //   emitSafe(state.copyWith(trips: updatedTrips));
  //   return newTrip.id;
  // }

  // Future<void> saveTripDraft(Trip trip) async {
  //   final result = await _repository.saveTrip(trip);
  //   result.when(
  //     success: (_) {
  //       final index = state.trips.indexWhere((t) => t.id == trip.id);
  //       final updatedTrips = List<Trip>.from(state.trips);
  //       if (index != -1) {
  //         updatedTrips[index] = trip;
  //       } else {
  //         updatedTrips.add(trip);
  //       }
  //       emitSafe(state.copyWith(trips: updatedTrips));
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsStatus.error,
  //           errorMessage: 'Failed to save draft: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // Future<void> completeTrip(String tripId) async {
  //   final index = state.getTripIndex(tripId);
  //   if (index == -1) return;
  //   final trip = state.trips[index].copyWith(
  //     status: TripStatus.upcoming,
  //     updatedAt: DateTime.now(),
  //   );
  //   final result = await _repository.confirmTrip(tripId);
  //   result.when(
  //     success: (_) {
  //       final updatedTrips = List<Trip>.from(state.trips);
  //       updatedTrips[index] = trip;
  //       emitSafe(state.copyWith(trips: updatedTrips));
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsStatus.error,
  //           errorMessage: 'Failed to complete trip: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // Future<void> generateTrip(Trip trip) async {
  //   final index = state.getTripIndex(trip.id);
  //   emitSafe(state.copyWith(isGenerating: true, clearGeneratedTripId: true));
  //   final planResult = await _generatePlanUseCase(trip);
  //   planResult.when(
  //     success: (plan) async {
  //       final updatedTrip = trip.copyWith(
  //         status: TripStatus.draft,
  //         updatedAt: DateTime.now(),
  //       );
  //       final saveTripResult = await _repository.createTrip(updatedTrip, plan);
  //       saveTripResult.when(
  //         success: (savedTrip) {
  //           final updatedTrips = List<Trip>.from(state.trips);
  //           if (index != -1) {
  //             updatedTrips[index] = savedTrip;
  //           } else {
  //             updatedTrips.add(savedTrip);
  //           }
  //           emitSafe(
  //             state.copyWith(
  //               trips: updatedTrips,
  //               isGenerating: false,
  //               generatedTripId: savedTrip.id,
  //             ),
  //           );
  //         },
  //         failure: (error) {
  //           emitSafe(
  //             state.copyWith(
  //               tripsStatus: TripsStatus.error,
  //               isGenerating: false,
  //               errorMessage: 'Failed to create trip: ${error.message}',
  //             ),
  //           );
  //         },
  //         cancelled: () {},
  //       );
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsStatus.error,
  //           isGenerating: false,
  //           errorMessage: 'Failed to generate plan: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // Future<void> deleteTrip(String tripId) async {
  //   final result = await _repository.deleteTrip(tripId);
  //   result.when(
  //     success: (_) {
  //       final updatedTrips = state.trips.where((t) => t.id != tripId).toList();
  //       emitSafe(state.copyWith(trips: updatedTrips));
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsStatus.error,
  //           errorMessage: 'Failed to delete trip: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  // Future<void> updateTripTitle(String tripId, String newTitle) async {
  //   final index = state.getTripIndex(tripId);
  //   if (index == -1) return;
  //   final trip = state.trips[index].copyWith(
  //     title: newTitle,
  //     updatedAt: DateTime.now(),
  //   );
  //   final result = await _repository.updateTrip(trip);
  //   result.when(
  //     success: (_) {
  //       final updatedTrips = List<Trip>.from(state.trips);
  //       updatedTrips[index] = trip;
  //       emitSafe(state.copyWith(trips: updatedTrips));
  //     },
  //     failure: (error) {
  //       emitSafe(
  //         state.copyWith(
  //           tripsStatus: TripsStatus.error,
  //           errorMessage: 'Failed to update title: ${error.message}',
  //         ),
  //       );
  //     },
  //     cancelled: () {},
  //   );
  // }

  List<Trip> getTripsForMonth(DateTime month) {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    return state.trips.where((trip) {
      final start = trip.tripStart;
      final end = trip.tripEnd;

      return start.isBefore(endOfMonth.add(const Duration(days: 1))) &&
          end.isAfter(startOfMonth.subtract(const Duration(days: 1)));
    }).toList();
  }

  List<Trip> getTripsForDay(DateTime day, List<Trip> trips) {
    final current = DateUtils.dateOnly(day);

    return trips.where((trip) {
      final start = DateUtils.dateOnly(trip.tripStart);
      final end = DateUtils.dateOnly(trip.tripEnd);

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
