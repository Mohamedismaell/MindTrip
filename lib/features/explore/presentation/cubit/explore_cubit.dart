import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';
import 'package:mindtrip/features/places/data/models/trending_places_request.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final GetTrendingPlacesUseCase getTrendingPlacesUseCase;

  ExploreCubit({required this.getTrendingPlacesUseCase})
    : super(const ExploreState());

  Future<void> loadAllData() async {
    await loadTrendingPlacesFirstPage();
  }

  CancelToken? _trendingPlacesFirstPageToken;
  CancelToken? _loadMoreTrendingToken;

  // CancelToken? _otherPlacesToken;
  Future<void> loadTrendingPlacesFirstPage() async {
    _trendingPlacesFirstPageToken?.cancel();
    _trendingPlacesFirstPageToken = CancelToken();
    emit(state.copyWith(trendingPlacesStatus: ExploreDataStatus.loading));
    final result = await getTrendingPlacesUseCase(
      request: TrendingPlacesRequest(
        sortBy: "rating",
        order: "desc",
        page: 1,
        limit: 10,
      ),
      cancelToken: _trendingPlacesFirstPageToken,
    );
    if (isClosed) return;
    result.when(
      success: (response) => emit(
        state.copyWith(
          trendingPlacesStatus: ExploreDataStatus.success,
          trendingPlaces: state.trendingPlaces.copyWith(
            items: response.results,
            currentPage: response.page,
            hasMore: response.page < response.totalPages,
            isMoreLoading: false,
          ),
          trendingPlacesError: '',
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          trendingPlacesStatus: ExploreDataStatus.failure,
          trendingPlacesError: error.message,
        ),
      ),
    );
  }

  Future<void> loadMoreTrendingPlaces() async {
    if (state.trendingPlaces.isMoreLoading ||
        state.trendingPlacesStatus.isLoading ||
        !state.trendingPlaces.hasMore) {
      return;
    }

    _loadMoreTrendingToken?.cancel();
    _loadMoreTrendingToken = CancelToken();

    emit(
      state.copyWith(
        trendingPlaces: state.trendingPlaces.copyWith(isMoreLoading: true),
      ),
    );

    final nextPage = state.trendingPlaces.currentPage + 1;
    final result = await getTrendingPlacesUseCase(
      request: TrendingPlacesRequest(
        sortBy: "rating",
        order: "desc",
        page: nextPage,
        limit: 10,
      ),
      cancelToken: _loadMoreTrendingToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            trendingPlaces: state.trendingPlaces.copyWith(
              items: [...state.trendingPlaces.items, ...response.results],
              currentPage: response.page,
              hasMore: response.page < response.totalPages,
              isMoreLoading: false,
            ),
            trendingPlacesError: '',
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            trendingPlaces: state.trendingPlaces.copyWith(isMoreLoading: false),
            trendingPlacesError: error.message,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _trendingPlacesFirstPageToken?.cancel();
    _loadMoreTrendingToken?.cancel();
    return super.close();
  }
}
