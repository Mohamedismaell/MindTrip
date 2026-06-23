import 'package:dio/dio.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/home/domain/use_cases/get_ai_planner_previews_use_case.dart';
import 'package:mindtrip/features/home/domain/use_cases/get_banners_use_case.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_recommended_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';

class HomeCubit extends SafeCubit<HomeState> {
  final GetBannersUseCase getBannersUseCase;
  final GetRecommendedPlacesUseCase getRecommendedPlacesUseCase;
  final GetAIPlannerPreviewsUseCase getAIPlannerPreviewsUseCase;
  final GetPlacesUseCase getPlacesUseCase;
  HomeCubit({
    required this.getBannersUseCase,
    required this.getRecommendedPlacesUseCase,
    required this.getAIPlannerPreviewsUseCase,
    required this.getPlacesUseCase,
  }) : super(const HomeState());

  Future<void> loadAllData() async {
    loadBanners();
    loadPlannerPreviews();
    loadFirstPageCategoryPlaces(state.selectedCategory.category);
    loadFirstPageHiddenGems();
  }

  CancelToken? _popularPlacesFirstToken;
  CancelToken? _popularPlacesMoreToken;
  CancelToken? _categoryPlacesFirstToken;
  CancelToken? _categoryPlacesMoreToken;
  CancelToken? _hiddenGemsFirstToken;
  CancelToken? _hiddenGemsMoreToken;

  void onCategoryChanged(PlaceCategory category) {
    if (state.selectedCategory == category) return;
    emitSafe(state.copyWith(selectedCategory: category));
    loadFirstPageCategoryPlaces(category.category);
  }

  Future<void> loadBanners() async {
    emitSafe(state.copyWith(bannersStatus: HomeDataStatus.loading));
    final result = await getBannersUseCase();

    result.when(
      success: (banners) => emitSafe(
        state.copyWith(bannersStatus: HomeDataStatus.success, banners: banners),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          bannersStatus: HomeDataStatus.failure,
          bannersError: error.message,
        ),
      ),
      cancelled: () {},
    );
  }

  Future<void> loadFirstPageCategoryPlaces(String? category) async {
    _categoryPlacesFirstToken?.cancel();
    _categoryPlacesFirstToken = CancelToken();
    emitSafe(state.copyWith(categoryPlacesStatus: HomeDataStatus.loading));
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
        category: category != null
            ? [category]
            : [state.selectedCategory.category],
        page: 1,
        limit: 10,
      ),
      cancelToken: _categoryPlacesFirstToken,
    );

    result.when(
      success: (paginatedResponse) => emitSafe(
        state.copyWith(
          categoryPlacesStatus: HomeDataStatus.success,
          categoryPlaces: state.categoryPlaces.copyWith(
            items: paginatedResponse.results,
            currentPage: paginatedResponse.page,
            hasMore: paginatedResponse.page < paginatedResponse.totalPages,
          ),
          categoryPlacesError: '',
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          categoryPlacesStatus: HomeDataStatus.failure,
          categoryPlacesError: error.message,
        ),
      ),
      cancelled: () {},
    );
  }

  Future<void> loadMoreCategoryPlaces() async {
    if (state.categoryPlacesStatus.isLoading ||
        state.categoryPlaces.isMoreLoading ||
        !state.categoryPlaces.hasMore) {
      return;
    }
    _categoryPlacesMoreToken?.cancel();
    _categoryPlacesMoreToken = CancelToken();
    emitSafe(
      state.copyWith(
        categoryPlaces: state.categoryPlaces.copyWith(isMoreLoading: true),
      ),
    );
    final nextPage = state.categoryPlaces.currentPage + 1;
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
        category: [state.selectedCategory.category],
        page: nextPage,
        limit: 10,
      ),
      cancelToken: _categoryPlacesMoreToken,
    );

    result.when(
      success: (paginatedResponse) => emitSafe(
        state.copyWith(
          categoryPlaces: state.categoryPlaces.copyWith(
            items: [
              ...state.categoryPlaces.items,
              ...paginatedResponse.results,
            ],
            currentPage: paginatedResponse.page,
            hasMore: paginatedResponse.page < paginatedResponse.totalPages,
            isMoreLoading: false,
          ),
          categoryPlacesError: '',
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          categoryPlaces: state.categoryPlaces.copyWith(isMoreLoading: false),
          categoryPlacesError: error.message,
        ),
      ),
      cancelled: () {},
    );
  }

  Future<void> loadFirstPageHiddenGems() async {
    _hiddenGemsFirstToken?.cancel();
    _hiddenGemsFirstToken = CancelToken();
    emitSafe(state.copyWith(hiddenGemsStatus: HomeDataStatus.loading));
    final result = await getPlacesUseCase(
      request: const GetPlacesRequestModel(hiddenGem: true, page: 1, limit: 10),
      cancelToken: _hiddenGemsFirstToken,
    );

    result.when(
      success: (paginatedResponse) => emitSafe(
        state.copyWith(
          hiddenGemsStatus: HomeDataStatus.success,
          hiddenGems: state.hiddenGems.copyWith(
            items: paginatedResponse.results,
            currentPage: paginatedResponse.page,
            hasMore: paginatedResponse.page < paginatedResponse.totalPages,
          ),
          hiddenGemsError: '',
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          hiddenGemsStatus: HomeDataStatus.failure,
          hiddenGemsError: error.message,
        ),
      ),
      cancelled: () {},
    );
  }

  Future<void> loadMoreHiddenGems() async {
    if (state.hiddenGemsStatus.isLoading ||
        state.hiddenGems.isMoreLoading ||
        !state.hiddenGems.hasMore) {
      return;
    }
    _hiddenGemsMoreToken?.cancel();
    _hiddenGemsMoreToken = CancelToken();
    emitSafe(
      state.copyWith(
        hiddenGems: state.hiddenGems.copyWith(isMoreLoading: true),
      ),
    );
    final nextPage = state.hiddenGems.currentPage + 1;
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
        hiddenGem: true,
        page: nextPage,
        limit: 10,
      ),
      cancelToken: _hiddenGemsMoreToken,
    );

    result.when(
      success: (paginatedResponse) => emitSafe(
        state.copyWith(
          hiddenGems: state.hiddenGems.copyWith(
            items: [...state.hiddenGems.items, ...paginatedResponse.results],
            currentPage: paginatedResponse.page,
            hasMore: paginatedResponse.page < paginatedResponse.totalPages,
            isMoreLoading: false,
          ),
          hiddenGemsError: '',
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          hiddenGems: state.hiddenGems.copyWith(isMoreLoading: false),
          hiddenGemsError: error.message,
        ),
      ),
      cancelled: () {},
    );
  }

  Future<void> loadPlannerPreviews() async {
    emitSafe(state.copyWith(plannerPreviewsStatus: HomeDataStatus.loading));
    final result = await getAIPlannerPreviewsUseCase();

    result.when(
      success: (previews) => emitSafe(
        state.copyWith(
          plannerPreviewsStatus: HomeDataStatus.success,
          plannerPreviews: previews,
        ),
      ),
      failure: (error) => emitSafe(
        state.copyWith(
          plannerPreviewsStatus: HomeDataStatus.failure,
          plannerPreviewsError: error.message,
        ),
      ),
      cancelled: () {},
    );
  }

  @override
  Future<void> close() {
    _popularPlacesFirstToken?.cancel();
    _popularPlacesMoreToken?.cancel();
    _categoryPlacesMoreToken?.cancel();
    _categoryPlacesFirstToken?.cancel();
    _hiddenGemsFirstToken?.cancel();
    _hiddenGemsMoreToken?.cancel();
    return super.close();
  }
}

  // Future<void> loadFirstPagePopularPlaces() async {
  //   _popularPlacesFirstToken?.cancel();
  //   _popularPlacesFirstToken = CancelToken();
  //   emit(state.copyWith(popularPlacesStatus: HomeDataStatus.loading));
  //   final result = await getPopularPlacesUseCase(
  //     request: PopularPlacesRequestModel(
  //       filters: {'is_hidden_gem': false},
  //       page: 1,
  //       limit: 10,
  //     ),
  //     cancelToken: _popularPlacesFirstToken,
  //   );
  //   if (isClosed) return;
  //   result.when(
  //     success: (paginatedResponse) => emit(
  //       state.copyWith(
  //         popularPlacesStatus: HomeDataStatus.success,
  //         popularPlaces: state.popularPlaces.copyWith(
  //           items: paginatedResponse.results,
  //           currentPage: paginatedResponse.page,
  //           hasMore: paginatedResponse.page < paginatedResponse.totalPages,
  //         ),
  //         popularPlacesError: '',
  //       ),
  //     ),
  //     failure: (error) => emit(
  //       state.copyWith(
  //         popularPlacesStatus: HomeDataStatus.failure,
  //         popularPlacesError: error.message,
  //       ),
  //     ),
  //   );
  // }

  // Future<void> loadMorePopularPlaces() async {
  //   if (state.popularPlacesStatus.isLoading ||
  //       state.popularPlaces.isMoreLoading ||
  //       !state.popularPlaces.hasMore) {
  //     return;
  //   }
  //   _popularPlacesMoreToken?.cancel();
  //   _popularPlacesMoreToken = CancelToken();
  //   emit(
  //     state.copyWith(
  //       popularPlaces: state.popularPlaces.copyWith(isMoreLoading: true),
  //     ),
  //   );
  //   final nextPage = state.popularPlaces.currentPage + 1;
  //   final result = await getPopularPlacesUseCase(
  //     request: PopularPlacesRequestModel(
  //       filters: {'is_hidden_gem': false},
  //       page: nextPage,
  //       limit: 10,
  //     ),
  //     cancelToken: _popularPlacesMoreToken,
  //   );
  //   if (isClosed) return;
  //   result.when(
  //     success: (paginatedResponse) => emit(
  //       state.copyWith(
  //         popularPlaces: state.popularPlaces.copyWith(
  //           items: [...state.popularPlaces.items, ...paginatedResponse.results],
  //           currentPage: paginatedResponse.page,
  //           hasMore: paginatedResponse.page < paginatedResponse.totalPages,
  //           isMoreLoading: false,
  //         ),
  //         popularPlacesError: '',
  //       ),
  //     ),
  //     failure: (error) => emit(
  //       state.copyWith(
  //         popularPlaces: state.popularPlaces.copyWith(isMoreLoading: false),
  //         popularPlacesError: error.message,
  //       ),
  //     ),
  //   );
  // }