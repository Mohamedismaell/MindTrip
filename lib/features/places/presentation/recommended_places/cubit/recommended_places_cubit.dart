import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/features/places/data/models/recommendation_request_model.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_recommended_places_use_case.dart';

part 'recommended_places_state.dart';
part 'recommended_places_cubit.freezed.dart';

class RecommendedPlacesCubit extends Cubit<RecommendedPlacesState> {
  final GetRecommendedPlacesUseCase getRecommendedPlacesUseCase;

  RecommendedPlacesCubit({required this.getRecommendedPlacesUseCase})
    : super(RecommendedPlacesState.initial());

  CancelToken? _firstPageToken;
  CancelToken? _loadMoreToken;
  Future<void> loadFirstPage({required List<String> selectedCategories}) async {
    _firstPageToken?.cancel();
    _firstPageToken = CancelToken();
    emit(
      state.copyWith(recommendedPlacesStatus: RecommendedPlacesStatus.loading),
    );

    final result = await getRecommendedPlacesUseCase(
      request: RecommendationRequestModel(
        selectedCategories: selectedCategories,
        page: 1,
      ),
      cancelToken: _firstPageToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            recommendedPlacesStatus: RecommendedPlacesStatus.success,
            places: response.results,
            currentPage: response.page,
            hasMore: response.page < response.totalPages,
            error: '',
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            recommendedPlacesStatus: RecommendedPlacesStatus.failure,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> loadMorePlaces({
    required List<String> selectedCategories,
  }) async {
    _loadMoreToken?.cancel();
    _loadMoreToken = CancelToken();

    if (state.isMoreLoading ||
        state.recommendedPlacesStatus == RecommendedPlacesStatus.loading ||
        !state.hasMore) {
      return;
    }

    emit(state.copyWith(isMoreLoading: true));

    final nextPage = state.currentPage + 1;
    final result = await getRecommendedPlacesUseCase(
      request: RecommendationRequestModel(
        selectedCategories: selectedCategories,
        page: nextPage,
      ),
      cancelToken: _loadMoreToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            isMoreLoading: false,
            places: [...state.places, ...response.results],
            currentPage: response.page,
            hasMore: response.page < response.totalPages,
            error: '',
          ),
        );
      },
      failure: (error) {
        emit(state.copyWith(isMoreLoading: false, error: error.message));
      },
    );
  }

  @override
  Future<void> close() {
    _firstPageToken?.cancel();
    _loadMoreToken?.cancel();
    return super.close();
  }
}
