part of 'favorites_screen_cubit.dart';

enum FavoritesTabStatus { initial, loading, loaded, empty, error }

class FavoritesScreenState extends Equatable {
  final List<PlaceModel> places;
  final FavoritesTabStatus placesStatus;
  final String? errorMessage;

  const FavoritesScreenState({
    this.places = const [],
    this.placesStatus = FavoritesTabStatus.initial,
    this.errorMessage,
  });

  FavoritesScreenState copyWith({
    List<PlaceModel>? places,
    FavoritesTabStatus? placesStatus,
    String? errorMessage,
  }) =>
      FavoritesScreenState(
        places: places ?? this.places,
        placesStatus: placesStatus ?? this.placesStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [places, placesStatus, errorMessage];
}
