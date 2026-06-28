import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/core/shared/domain/usecases/bootstrap_favorite_trips_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorite_trips_local_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/sync_favorite_trips_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/toggle_trip_favorite_use_case.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';
import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_state.dart';

class TripFavoriteCubit extends SafeCubit<TripFavoriteState> {
  final ToggleTripFavoriteUseCase _toggleTripFavoriteUseCase;
  final GetFavoriteTripsLocalUseCase _getFavoriteTripsLocalUseCase;
  final SyncFavoriteTripsUseCase _syncFavoriteTripsUseCase;
  final BootstrapFavoriteTripsUseCase _bootstrapFavoriteTripsUseCase;

  TripFavoriteCubit({
    required ToggleTripFavoriteUseCase toggleTripFavoriteUseCase,
    required GetFavoriteTripsLocalUseCase getFavoriteTripsLocalUseCase,
    required SyncFavoriteTripsUseCase syncFavoriteTripsUseCase,
    required BootstrapFavoriteTripsUseCase bootstrapFavoriteTripsUseCase,
  }) : _toggleTripFavoriteUseCase = toggleTripFavoriteUseCase,
       _getFavoriteTripsLocalUseCase = getFavoriteTripsLocalUseCase,
       _syncFavoriteTripsUseCase = syncFavoriteTripsUseCase,
       _bootstrapFavoriteTripsUseCase = bootstrapFavoriteTripsUseCase,
       super(const TripFavoriteState());

  Future<void> loadFavoriteTrips() async {
    emitSafe(state.copyWith(status: FavoritesStatus.loading));

    await _bootstrapFavoriteTripsUseCase.call();

    final result = await _getFavoriteTripsLocalUseCase.call();
    result.when(
      success: (trips) {
        final ids = trips.map((trip) => trip.tripId).toSet();
        emitSafe(
          state.copyWith(
            favoriteTripIds: ids,
            favoriteTrips: trips,
            status: trips.isEmpty
                ? FavoritesStatus.empty
                : FavoritesStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            status: FavoritesStatus.error,
            errorMessage: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> toggleTripFavorite({
    required String tripId,
    required bool isFavorite,
    FavoriteTripEntity? trip,
  }) async {
    final updatedIds = Set<String>.from(state.favoriteTripIds);
    var updatedTrips = List<FavoriteTripEntity>.from(state.favoriteTrips);

    if (isFavorite) {
      updatedIds.add(tripId);
      if (trip != null && !updatedTrips.any((item) => item.tripId == tripId)) {
        updatedTrips = [...updatedTrips, trip];
      }
    } else {
      updatedIds.remove(tripId);
      updatedTrips = updatedTrips
          .where((item) => item.tripId != tripId)
          .toList();
    }

    emitSafe(
      state.copyWith(
        favoriteTripIds: updatedIds,
        favoriteTrips: updatedTrips,
        status: FavoritesStatus.syncing,
      ),
    );

    await _toggleTripFavoriteUseCase.call(
      tripId: tripId,
      isFavorite: isFavorite,
      trip: trip,
    );

    final localResult = await _getFavoriteTripsLocalUseCase.call();
    localResult.when(
      success: (trips) {
        final ids = trips.map((item) => item.tripId).toSet();
        emitSafe(
          state.copyWith(
            favoriteTripIds: ids,
            favoriteTrips: trips,
            status: ids.isEmpty
                ? FavoritesStatus.empty
                : FavoritesStatus.loaded,
          ),
        );
      },
      failure: (_) {
        emitSafe(
          state.copyWith(
            status: updatedIds.isEmpty
                ? FavoritesStatus.empty
                : FavoritesStatus.loaded,
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> syncPendingTripFavorites() async {
    await _syncFavoriteTripsUseCase.call();
  }

  bool isTripFavorite(String tripId) => state.favoriteTripIds.contains(tripId);

  void clear() => emitSafe(const TripFavoriteState());
}
