import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';

part 'trip_favorite_state.freezed.dart';

@freezed
abstract class TripFavoriteState with _$TripFavoriteState {
  const factory TripFavoriteState({
    @Default(<String>{}) Set<String> favoriteTripIds,
    @Default(<FavoriteTripEntity>[]) List<FavoriteTripEntity> favoriteTrips,
    @Default(FavoritesStatus.initial) FavoritesStatus status,
    String? errorMessage,
  }) = _TripFavoriteState;
}
