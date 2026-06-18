import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final GetPlacesUseCase getPlacesUseCase;

  ExploreCubit({required this.getPlacesUseCase}) : super(const ExploreState());

  Future<void> loadAllData() async {
    loadTrendingPlacesFirstPage();
    loadFilteredPlacesFirstPage();
  }

  CancelToken? _trendingPlacesFirstPageToken;
  CancelToken? _loadMoreTrendingToken;
  CancelToken? _otherPlacesFirstToken;
  CancelToken? _otherPlacesMoreToken;
  Timer? _searchDebounce;

  Future<void> loadTrendingPlacesFirstPage() async {
    _trendingPlacesFirstPageToken?.cancel();
    _trendingPlacesFirstPageToken = CancelToken();
    emit(state.copyWith(trendingPlacesStatus: ExploreDataStatus.loading));
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
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
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
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

  Future<void> loadFilteredPlacesFirstPage() async {
    _otherPlacesFirstToken?.cancel();
    _otherPlacesFirstToken = CancelToken();

    emit(state.copyWith(filteredPlacesStatus: ExploreDataStatus.loading));

    final result = await getPlacesUseCase(
      request: _buildFilteredRequest(page: 1),
      cancelToken: _otherPlacesFirstToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) => emit(
        state.copyWith(
          filteredPlacesStatus: ExploreDataStatus.success,
          filteredPlaces: state.filteredPlaces.copyWith(
            items: response.results,
            currentPage: response.page,
            hasMore: response.page < response.totalPages,
            isMoreLoading: false,
          ),
          filteredPlacesError: '',
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          filteredPlacesStatus: ExploreDataStatus.failure,
          filteredPlacesError: error.message,
        ),
      ),
    );
  }

  Future<void> loadMoreOtherPlaces() async {
    if (state.filteredPlaces.isMoreLoading ||
        state.filteredPlacesStatus.isLoading ||
        !state.filteredPlaces.hasMore) {
      return;
    }

    _otherPlacesMoreToken?.cancel();
    _otherPlacesMoreToken = CancelToken();

    emit(
      state.copyWith(
        filteredPlaces: state.filteredPlaces.copyWith(isMoreLoading: true),
      ),
    );

    final nextPage = state.filteredPlaces.currentPage + 1;
    final result = await getPlacesUseCase(
      request: _buildFilteredRequest(page: nextPage),
      cancelToken: _otherPlacesMoreToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) {
        emit(
          state.copyWith(
            filteredPlaces: state.filteredPlaces.copyWith(
              items: [...state.filteredPlaces.items, ...response.results],
              currentPage: response.page,
              hasMore: response.page < response.totalPages,
              isMoreLoading: false,
            ),
            filteredPlacesError: '',
          ),
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            filteredPlaces: state.filteredPlaces.copyWith(isMoreLoading: false),
            filteredPlacesError: error.message,
          ),
        );
      },
    );
  }

  GetPlacesRequestModel _buildFilteredRequest({required int page}) {
    final base = state.advancedFilters ?? const GetPlacesRequestModel();

    // Combine the category from the chip bar with any categories from the filter sheet
    final List<String> categories = [];
    if (state.selectedCategory != PlaceCategory.all) {
      categories.add(state.selectedCategory.category);
    }
    if (base.category != null) {
      categories.addAll(base.category!);
    }

    return GetPlacesRequestModel(
      category: categories.isEmpty ? null : categories.toSet().toList(),
      city: base.city,
      interests: base.interests,
      minRating: base.minRating,
      maxRating: base.maxRating,
      minPrice: base.minPrice,
      maxPrice: base.maxPrice,
      hiddenGem: base.hiddenGem,
      sortBy: base.sortBy,
      order: base.order,
      page: page,
      limit: 12,
    );
  }

  void applyAdvancedFilters(GetPlacesRequestModel filters) {
    emit(state.copyWith(advancedFilters: filters));
    loadFilteredPlacesFirstPage();
  }

  void resetAdvancedFilters() {
    emit(state.copyWith(advancedFilters: null));
    loadFilteredPlacesFirstPage();
  }

  void onCategoryToggled(PlaceCategory category) {
    if (state.selectedCategory == category) return;
    emit(state.copyWith(selectedCategory: category));
    loadFilteredPlacesFirstPage();
  }

  @override
  Future<void> close() {
    _trendingPlacesFirstPageToken?.cancel();
    _loadMoreTrendingToken?.cancel();
    _otherPlacesFirstToken?.cancel();
    _otherPlacesMoreToken?.cancel();
    _searchDebounce?.cancel();
    return super.close();
  }
}
