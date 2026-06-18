import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/home/domain/use_cases/get_ai_planner_previews_use_case.dart';
import 'package:mindtrip/features/explore/domain/use_cases/get_tour_packages_use_case.dart';
import 'package:mindtrip/features/home/domain/use_cases/get_banners_use_case.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
// import 'package:mindtrip/features/places/data/models/popular_places_request_model.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';
// import 'package:mindtrip/features/places/domain/use_cases/get_popular_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_recommended_places_use_case.dart';
import 'package:mindtrip/features/places/domain/use_cases/get_trending_places_use_case.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBannersUseCase getBannersUseCase;
  // final GetPopularPlacesUseCase getPopularPlacesUseCase;
  final GetRecommendedPlacesUseCase getRecommendedPlacesUseCase;
  final GetTourPackagesUseCase getTourPackagesUseCase;
  final GetAIPlannerPreviewsUseCase getAIPlannerPreviewsUseCase;
  final GetPlacesUseCase getPlacesUseCase;
  HomeCubit({
    required this.getBannersUseCase,
    // required this.getPopularPlacesUseCase,
    required this.getRecommendedPlacesUseCase,
    required this.getTourPackagesUseCase,
    required this.getAIPlannerPreviewsUseCase,
    required this.getPlacesUseCase,
  }) : super(const HomeState());

  Future<void> loadAllData() async {
    loadBanners();
    // loadFirstPagePopularPlaces();
    loadTourPackages();
    loadPlannerPreviews();
    loadFirstPageCategoryPlaces(state.selectedCategory);
  }

  // CancelToken? _bannersToken;
  CancelToken? _popularPlacesFirstToken;
  CancelToken? _popularPlacesMoreToken;
  CancelToken? _categoryPlacesFirstToken;
  CancelToken? _categoryPlacesMoreToken;

  void onCategoryChanged(String category) {
    if (state.selectedCategory == category) return;
    emit(state.copyWith(selectedCategory: category));
    loadFirstPageCategoryPlaces(category);
  }

  // CancelToken? _tourPackagesToken;
  // CancelToken? _plannerPreviewsToken;
  Future<void> loadBanners() async {
    emit(state.copyWith(bannersStatus: HomeDataStatus.loading));
    final result = await getBannersUseCase();
    if (isClosed) return;
    result.when(
      success: (banners) => emit(
        state.copyWith(bannersStatus: HomeDataStatus.success, banners: banners),
      ),
      failure: (error) => emit(
        state.copyWith(
          bannersStatus: HomeDataStatus.failure,
          bannersError: error.message,
        ),
      ),
    );
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

  Future<void> loadFirstPageCategoryPlaces(String? category) async {
    _categoryPlacesFirstToken?.cancel();
    _categoryPlacesFirstToken = CancelToken();
    emit(state.copyWith(categoryPlacesStatus: HomeDataStatus.loading));
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
        category: category != null ? [category] : [state.selectedCategory],
        page: 1,
        limit: 10,
      ),
      cancelToken: _categoryPlacesFirstToken,
    );
    if (isClosed) return;
    result.when(
      success: (paginatedResponse) => emit(
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
      failure: (error) => emit(
        state.copyWith(
          categoryPlacesStatus: HomeDataStatus.failure,
          categoryPlacesError: error.message,
        ),
      ),
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
    emit(
      state.copyWith(
        categoryPlaces: state.categoryPlaces.copyWith(isMoreLoading: true),
      ),
    );
    final nextPage = state.categoryPlaces.currentPage + 1;
    final result = await getPlacesUseCase(
      request: GetPlacesRequestModel(
        category: [state.selectedCategory],
        page: nextPage,
        limit: 10,
      ),
      cancelToken: _categoryPlacesMoreToken,
    );
    if (isClosed) return;
    result.when(
      success: (paginatedResponse) => emit(
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
      failure: (error) => emit(
        state.copyWith(
          categoryPlaces: state.categoryPlaces.copyWith(isMoreLoading: false),
          categoryPlacesError: error.message,
        ),
      ),
    );
  }

  //! not active
  Future<void> loadTourPackages() async {
    emit(state.copyWith(tourPackagesStatus: HomeDataStatus.loading));
    final result = await getTourPackagesUseCase();
    if (isClosed) return;
    result.when(
      success: (packages) => emit(
        state.copyWith(
          tourPackagesStatus: HomeDataStatus.success,
          tourPackages: packages,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          tourPackagesStatus: HomeDataStatus.failure,
          tourPackagesError: error.message,
        ),
      ),
    );
  }

  Future<void> loadPlannerPreviews() async {
    emit(state.copyWith(plannerPreviewsStatus: HomeDataStatus.loading));
    final result = await getAIPlannerPreviewsUseCase();
    if (isClosed) return;
    result.when(
      success: (previews) => emit(
        state.copyWith(
          plannerPreviewsStatus: HomeDataStatus.success,
          plannerPreviews: previews,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          plannerPreviewsStatus: HomeDataStatus.failure,
          plannerPreviewsError: error.message,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _popularPlacesFirstToken?.cancel();
    _popularPlacesMoreToken?.cancel();
    _categoryPlacesMoreToken?.cancel();
    _categoryPlacesFirstToken?.cancel();
    return super.close();
  }
}
