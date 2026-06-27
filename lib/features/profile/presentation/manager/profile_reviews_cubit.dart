import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/profile/domain/use_cases/get_my_reviews_use_case.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_state.dart';

class ProfileReviewsCubit extends SafeCubit<ProfileReviewsState> {
  final GetMyReviewsUseCase _getMyReviewsUseCase;
  CancelToken? _cancelToken;

  ProfileReviewsCubit({required GetMyReviewsUseCase getMyReviewsUseCase})
    : _getMyReviewsUseCase = getMyReviewsUseCase,
      super(const ProfileReviewsState());

  Future<void> getReviews() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    emitSafe(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getMyReviewsUseCase.call(cancelToken: _cancelToken);

    result.when(
      success: (reviews) {
        emitSafe(state.copyWith(reviews: reviews, isLoading: false));
      },
      failure: (error) {
        emitSafe(
          state.copyWith(
            isLoading: false,
            errorMessage: error.message,
          ),
        );
      },
      cancelled: () {},
    );
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    return super.close();
  }
}
