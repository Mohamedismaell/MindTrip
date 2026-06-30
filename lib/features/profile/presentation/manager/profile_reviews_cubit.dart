import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';
import 'package:mindtrip/features/profile/domain/use_cases/get_my_reviews_use_case.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_state.dart';
import 'package:mindtrip/features/trips/domain/use_cases/update_review_use_case.dart';
import 'package:mindtrip/features/trips/domain/use_cases/delete_review_use_case.dart';

class ProfileReviewsCubit extends SafeCubit<ProfileReviewsState> {
  final GetMyReviewsUseCase _getMyReviewsUseCase;
  final UpdateReviewUseCase _updateReviewUseCase;
  final DeleteReviewUseCase _deleteReviewUseCase;
  CancelToken? _cancelToken;

  ProfileReviewsCubit({
    required GetMyReviewsUseCase getMyReviewsUseCase,
    required UpdateReviewUseCase updateReviewUseCase,
    required DeleteReviewUseCase deleteReviewUseCase,
  })  : _getMyReviewsUseCase = getMyReviewsUseCase,
        _updateReviewUseCase = updateReviewUseCase,
        _deleteReviewUseCase = deleteReviewUseCase,
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

  Future<bool> editReview(String tripId, double rating, String comment) async {
    final result = await _updateReviewUseCase.call(tripId, rating.toInt(), comment);
    return result.when(
      success: (_) {
        final updatedReviews = state.reviews.map((r) {
          if (r.tripId == tripId) {
            return TripReviewEntity(
              tripReviewId: r.tripReviewId,
              tripId: r.tripId,
              destination: r.destination,
              rating: rating,
              comment: comment,
              createdAt: DateTime.now(),
            );
          }
          return r;
        }).toList();
        emitSafe(state.copyWith(reviews: updatedReviews));
        return true;
      },
      failure: (_) => false,
      cancelled: () => false,
    );
  }

  Future<bool> deleteReview(String tripId) async {
    final result = await _deleteReviewUseCase.call(tripId);
    return result.when(
      success: (_) {
        final updatedReviews =
            state.reviews.where((r) => r.tripId != tripId).toList();
        emitSafe(state.copyWith(reviews: updatedReviews));
        return true;
      },
      failure: (_) => false,
      cancelled: () => false,
    );
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    return super.close();
  }
}
