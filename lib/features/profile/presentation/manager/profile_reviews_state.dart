import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';

part 'profile_reviews_state.freezed.dart';

@freezed
abstract class ProfileReviewsState with _$ProfileReviewsState {
  const factory ProfileReviewsState({
    @Default([]) List<TripReviewEntity> reviews,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _ProfileReviewsState;
}
