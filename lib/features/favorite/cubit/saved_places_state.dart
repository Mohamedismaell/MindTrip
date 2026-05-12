part of 'saved_places_cubit.dart';

enum FavoritesTabStatus { initial, loading, loaded, empty, error }

class FavoritesScreenState extends Equatable {
  final List<PlaceModel> places;
  final FavoritesTabStatus placesStatus;
  final String? errorMessage;
  final PlaceCategory selectedCategory;

  const FavoritesScreenState({
    this.places = const [],
    this.placesStatus = FavoritesTabStatus.initial,
    this.errorMessage,
    this.selectedCategory = PlaceCategory.all,
  });

  List<PlaceModel> get filteredPlaces {
    if (selectedCategory == PlaceCategory.all) return places;
    return places
        .where(
          (p) => p.category == selectedCategory,
        )
        .toList();
  }

  FavoritesScreenState copyWith({
    List<PlaceModel>? places,
    FavoritesTabStatus? placesStatus,
    String? errorMessage,
    PlaceCategory? selectedCategory,
  }) => FavoritesScreenState(
    places: places ?? this.places,
    placesStatus: placesStatus ?? this.placesStatus,
    errorMessage: errorMessage ?? this.errorMessage,
    selectedCategory: selectedCategory ?? this.selectedCategory,
  );

  @override
  List<Object?> get props => [
    places,
    placesStatus,
    errorMessage,
    selectedCategory,
  ];
}
