import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/models/pagination_state.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/features/places/data/models/recommendation_places_request_model.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_recommended_places_use_case.dart';

part 'recommended_places_state.dart';
part 'recommended_places_cubit.freezed.dart';

class RecommendedPlacesCubit extends SafeCubit<RecommendedPlacesState> {
  final GetRecommendedPlacesUseCase getRecommendedPlacesUseCase;

  RecommendedPlacesCubit({required this.getRecommendedPlacesUseCase})
    : super(RecommendedPlacesState.initial());

  CancelToken? _firstPageToken;
  CancelToken? _loadMoreToken;
  Future<void> loadFirstPage({
    required List<String> selectedCategories,
    int? limit,
  }) async {
    _firstPageToken?.cancel();
    _firstPageToken = CancelToken();
    emitSafe(
      state.copyWith(recommendedPlacesStatus: RecommendedPlacesStatus.loading),
    );

    final result = await getRecommendedPlacesUseCase(
      request: RecommendationPlacesRequestModel(
        selectedCategories: selectedCategories,
        page: 1,
        limit: limit ?? 4,
      ),
      cancelToken: _firstPageToken,
    );

    result.when(
      success: (response) {
        emitSafe(
          state.copyWith(
            recommendedPlacesStatus: RecommendedPlacesStatus.success,
            recommendedPlaces: PaginationState(
              items: response.results,
              currentPage: response.page,
              hasMore: response.page < response.totalPages,
            ),
            recommededPlacesError: '',
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            recommendedPlacesStatus: RecommendedPlacesStatus.failure,
            recommededPlacesError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> loadMorePlaces({
    required List<String> selectedCategories,
  }) async {
    if (state.recommendedPlaces.isMoreLoading ||
        state.recommendedPlacesStatus == RecommendedPlacesStatus.loading ||
        !state.recommendedPlaces.hasMore) {
      return;
    }
    _loadMoreToken?.cancel();
    _loadMoreToken = CancelToken();

    emitSafe(
      state.copyWith(
        recommendedPlaces: state.recommendedPlaces.copyWith(
          isMoreLoading: true,
        ),
      ),
    );

    final nextPage = state.recommendedPlaces.currentPage + 1;
    final result = await getRecommendedPlacesUseCase(
      request: RecommendationPlacesRequestModel(
        selectedCategories: selectedCategories,
        page: nextPage,
      ),
      cancelToken: _loadMoreToken,
    );

    result.when(
      success: (response) {
        emitSafe(
          state.copyWith(
            recommendedPlaces: state.recommendedPlaces.copyWith(
              items: [...state.recommendedPlaces.items, ...response.results],
              currentPage: response.page,
              hasMore: response.page < response.totalPages,
              isMoreLoading: false,
            ),
            recommededPlacesError: '',
          ),
        );
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            recommendedPlaces: state.recommendedPlaces.copyWith(
              isMoreLoading: false,
            ),
            recommededPlacesError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  @override
  Future<void> close() {
    _firstPageToken?.cancel();
    _loadMoreToken?.cancel();
    return super.close();
  }
}
