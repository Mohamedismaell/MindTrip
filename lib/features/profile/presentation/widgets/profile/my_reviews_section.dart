import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/review_entity.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_state.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/review_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/section_heading.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyReviewsSection extends StatelessWidget {
  const MyReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileReviewsCubit, ProfileReviewsState>(
      builder: (context, state) {
        if (state.errorMessage != null && state.reviews.isEmpty) {
          return AppErrorWidget(
            message: state.errorMessage!,
            onPressed: () => context.read<ProfileReviewsCubit>().getReviews(),
          );
        }

        final displayReviews =
            state.isLoading && state.reviews.isEmpty
                ? List.generate(
                  2,
                  (_) => TripReviewEntity(
                    tripReviewId: 'id',
                    tripId: 'tripId',
                    destination: 'Loading destination...',
                    rating: 5,
                    comment: 'Loading review comment content...',
                    createdAt: DateTime.now(),
                  ),
                )
                : state.reviews;

        if (displayReviews.isEmpty && !state.isLoading) {
          return const SizedBox.shrink();
        }

        return Skeletonizer(
          enabled: state.isLoading,
          child: Column(
            children: [
              const SectionHeading(title: 'My Reviews', actionText: 'See all'),
              SizedBox(height: 24.h),
              ...displayReviews.map((review) {
                // Map TripReviewEntity to ReviewEntity for the existing ReviewCard
                final data = ReviewEntity(
                  id: review.tripReviewId,
                  userId: '',
                  placeId: review.tripId,
                  location: review.destination,
                  rating: review.rating,
                  title: 'Trip to ${review.destination}',
                  body: review.comment,
                  createdAt: review.createdAt,
                );
                return Padding(
                  padding: EdgeInsets.only(bottom: 18.h),
                  child: ReviewCard(data: data),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
