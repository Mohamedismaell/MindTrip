import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';

class ExploreCubit extends SafeCubit<ExploreState> {
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
    emitSafe(state.copyWith(trendingPlacesStatus: ExploreDataStatus.loading));
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
        sortBy: "rating",
        order: "desc",
        page: 1,
        limit: 10,
      ),
      cancelToken: _trendingPlacesFirstPageToken,
    );
    
    result.when(
      success: (response) => emitSafe(
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
      failure: (error) => emitSafe(
        state.copyWith(
          trendingPlacesStatus: ExploreDataStatus.failure,
          trendingPlacesError: error.message,
        ),
      ),
      cancelled: () {},
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

    emitSafe(
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

    result.when(
      success: (response) {
        emitSafe(
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
        emitSafe(
          state.copyWith(
            trendingPlaces: state.trendingPlaces.copyWith(isMoreLoading: false),
            trendingPlacesError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  Future<void> loadFilteredPlacesFirstPage() async {
    _otherPlacesFirstToken?.cancel();
    _otherPlacesFirstToken = CancelToken();

    emitSafe(state.copyWith(filteredPlacesStatus: ExploreDataStatus.loading));

    final result = await getPlacesUseCase(
      request: _buildFilteredRequest(page: 1),
      cancelToken: _otherPlacesFirstToken,
    );

    result.when(
      success: (response) => emitSafe(
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
      failure: (error) => emitSafe(
        state.copyWith(
          filteredPlacesStatus: ExploreDataStatus.failure,
          filteredPlacesError: error.message,
        ),
      ),
      cancelled: () {},
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

    emitSafe(
      state.copyWith(
        filteredPlaces: state.filteredPlaces.copyWith(isMoreLoading: true),
      ),
    );

    final nextPage = state.filteredPlaces.currentPage + 1;
    final result = await getPlacesUseCase(
      request: _buildFilteredRequest(page: nextPage),
      cancelToken: _otherPlacesMoreToken,
    );

    result.when(
      success: (response) {
        emitSafe(
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
        emitSafe(
          state.copyWith(
            filteredPlaces: state.filteredPlaces.copyWith(isMoreLoading: false),
            filteredPlacesError: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  GetPlacesRequestModel _buildFilteredRequest({required int page}) {
    // If we have advanced filters ===> ignore the category chip
    if (state.advancedFilters != null) {
      final base = state.advancedFilters!;
      return GetPlacesRequestModel(
        category: base.category,
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

    //  only the category chip
    return GetPlacesRequestModel(
      category: state.selectedCategories.contains(PlaceCategory.all)
          ? null
          : state.selectedCategories.map((e) => e.category).toList(),
      page: page,
      limit: 12,
    );
  }

  void applyAdvancedFilters(GetPlacesRequestModel filters) {
    // Sync chip categories from advanced filters
    Set<PlaceCategory> chipCategories = {};
    if (filters.category != null && filters.category!.isNotEmpty) {
      for (final String selectedCategorySlug in filters.category!) {
        try {
          final category = PlaceCategory.values.firstWhere(
            (c) => c.category == selectedCategorySlug,
          );
          chipCategories.add(category);
        } catch (_) {}
      }
    }

    if (chipCategories.isEmpty) {
      chipCategories = {PlaceCategory.all};
    }

    emitSafe(
      state.copyWith(
        advancedFilters: filters,
        selectedCategories: chipCategories,
      ),
    );
    loadFilteredPlacesFirstPage();
  }

  void resetAdvancedFilters() {
    emitSafe(state.copyWith(advancedFilters: null));
    loadFilteredPlacesFirstPage();
  }

  void onCategoryToggled(PlaceCategory category) {
    Set<PlaceCategory> newCategories = Set.from(state.selectedCategories);

    if (category == PlaceCategory.all) {
      newCategories = {PlaceCategory.all};
    } else {
      newCategories.remove(PlaceCategory.all);
      if (newCategories.contains(category)) {
        newCategories.remove(category);
      } else {
        newCategories.add(category);
      }

      if (newCategories.isEmpty) {
        newCategories = {PlaceCategory.all};
      }
    }

    emitSafe(
      state.copyWith(
        selectedCategories: newCategories,
        advancedFilters: null, // Reset filters when using chips
      ),
    );
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
