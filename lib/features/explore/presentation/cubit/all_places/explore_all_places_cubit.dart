import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/explore/presentation/cubit/all_places/explore_all_places_state.dart';
import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_popular_places_use_case.dart';

class ExploreAllPlacesCubit extends Cubit<ExploreAllPlacesState> {
  final GetPopularPlacesUseCase getPopularPlacesUseCase;

  ExploreAllPlacesCubit({required this.getPopularPlacesUseCase})
      : super(const ExploreAllPlacesState());

  CancelToken? _loadFirstPageToken;
  CancelToken? _loadMoreToken;
  Timer? _searchDebounce;

  Future<void> loadFirstPage({String? query, List<String>? categories}) async {
    _loadFirstPageToken?.cancel();
    _loadFirstPageToken = CancelToken();

    final currentQuery = query ?? state.searchQuery;
    final currentCategories = categories ?? state.selectedCategories;

    emit(state.copyWith(
      status: ExploreAllPlacesStatus.loading,
      searchQuery: currentQuery,
      selectedCategories: currentCategories,
    ));

    final filters = <String, dynamic>{};
    if (currentQuery.isNotEmpty) {
      filters['search'] = currentQuery;
    }
    if (currentCategories.isNotEmpty) {
      filters['category'] = currentCategories;
    }

    final result = await getPopularPlacesUseCase(
      request: PopularPlacesRequestModel(
        filters: filters.isNotEmpty ? filters : null,
        page: 1,
        limit: 10,
      ),
      cancelToken: _loadFirstPageToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) => emit(state.copyWith(
        status: ExploreAllPlacesStatus.success,
        places: state.places.copyWith(
          items: response.results,
          currentPage: response.page,
          hasMore: response.page < response.totalPages,
          isMoreLoading: false,
        ),
        error: '',
      )),
      failure: (error) => emit(state.copyWith(
        status: ExploreAllPlacesStatus.failure,
        error: error.message,
      )),
    );
  }

  Future<void> loadMore() async {
    if (state.places.isMoreLoading ||
        state.status.isLoading ||
        !state.places.hasMore) {
      return;
    }

    _loadMoreToken?.cancel();
    _loadMoreToken = CancelToken();

    emit(state.copyWith(
      places: state.places.copyWith(isMoreLoading: true),
    ));

    final filters = <String, dynamic>{};
    if (state.searchQuery.isNotEmpty) {
      filters['search'] = state.searchQuery;
    }
    if (state.selectedCategories.isNotEmpty) {
      filters['category'] = state.selectedCategories;
    }

    final nextPage = state.places.currentPage + 1;
    final result = await getPopularPlacesUseCase(
      request: PopularPlacesRequestModel(
        filters: filters.isNotEmpty ? filters : null,
        page: nextPage,
        limit: 10,
      ),
      cancelToken: _loadMoreToken,
    );

    if (isClosed) return;

    result.when(
      success: (response) => emit(state.copyWith(
        places: state.places.copyWith(
          items: [...state.places.items, ...response.results],
          currentPage: response.page,
          hasMore: response.page < response.totalPages,
          isMoreLoading: false,
        ),
        error: '',
      )),
      failure: (error) => emit(state.copyWith(
        places: state.places.copyWith(isMoreLoading: false),
        error: error.message,
      )),
    );
  }

  void onSearchChanged(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      loadFirstPage(query: query);
    });
  }

  void onCategoryChanged(String category) {
    final updatedCategories = List<String>.from(state.selectedCategories);
    if (updatedCategories.contains(category)) {
      updatedCategories.remove(category);
    } else {
      updatedCategories.add(category);
    }
    loadFirstPage(categories: updatedCategories);
  }

  @override
  Future<void> close() {
    _loadFirstPageToken?.cancel();
    _loadMoreToken?.cancel();
    _searchDebounce?.cancel();
    return super.close();
  }
}
