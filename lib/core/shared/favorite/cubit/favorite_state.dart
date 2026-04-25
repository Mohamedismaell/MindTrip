part of 'favorite_cubit.dart';

enum FavoritesStatus { initial, loaded, syncing, error }

class FavoriteState extends Equatable {
  final Set<String> favoriteIds;
  final FavoritesStatus status;

  const FavoriteState({
    this.favoriteIds = const {},
    this.status = FavoritesStatus.initial,
  });
  FavoriteState copyWith({Set<String>? favoriteIds, FavoritesStatus? status}) =>
      FavoriteState(
        favoriteIds: favoriteIds ?? this.favoriteIds,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [favoriteIds, status];
}
