import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/explore/domain/use_cases/get_trending_places_use_case.dart';
import 'package:mindtrip/features/explore/domain/use_cases/get_other_places_use_case.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final GetTrendingPlacesUseCase getTrendingPlacesUseCase;
  final GetOtherPlacesUseCase getOtherPlacesUseCase;

  ExploreCubit({
    required this.getTrendingPlacesUseCase,
    required this.getOtherPlacesUseCase,
  }) : super(const ExploreState());

  void loadAllData() {
    loadTrendingPlaces();
    loadOtherPlaces();
  }

  Future<void> loadTrendingPlaces() async {
    emit(state.copyWith(trendingPlacesStatus: ExploreDataStatus.loading));
    final result = await getTrendingPlacesUseCase();
    if (isClosed) return;
    result.when(
      success: (response) => emit(state.copyWith(
        trendingPlacesStatus: ExploreDataStatus.success,
        trendingPlaces: response.results,
      )),
      failure: (error) => emit(state.copyWith(
        trendingPlacesStatus: ExploreDataStatus.failure,
        trendingPlacesError: error.message,
      )),
    );
  }

  Future<void> loadOtherPlaces() async {
    emit(state.copyWith(otherPlacesStatus: ExploreDataStatus.loading));
    final result = await getOtherPlacesUseCase();
    if (isClosed) return;
    result.when(
      success: (response) => emit(state.copyWith(
        otherPlacesStatus: ExploreDataStatus.success,
        otherPlaces: response.results,
      )),
      failure: (error) => emit(state.copyWith(
        otherPlacesStatus: ExploreDataStatus.failure,
        otherPlacesError: error.message,
      )),
    );
  }
}
