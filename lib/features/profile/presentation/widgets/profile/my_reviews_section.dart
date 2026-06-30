import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/review_entity.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/features/profile/domain/entities/trip_review_entity.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_state.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/review_card.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/section_heading.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_review_dialog.dart';
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
        final displayReviews = state.isLoading && state.reviews.isEmpty
            ? List.generate(
                2,
                (index) => TripReviewEntity(
                  tripReviewId: 'skeleton_$index',
                  tripId: 'skeleton_trip_$index',
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
                final isSkeleton = state.isLoading && state.reviews.isEmpty;
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
                return _ReviewItem(
                  key: ValueKey(review.tripReviewId),
                  review: review,
                  data: data,
                  isSkeleton: isSkeleton,
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _ReviewItem extends StatefulWidget {
  const _ReviewItem({
    super.key,
    required this.review,
    required this.data,
    required this.isSkeleton,
  });

  final TripReviewEntity review;
  final ReviewEntity data;
  final bool isSkeleton;

  @override
  State<_ReviewItem> createState() => _ReviewItemState();
}

class _ReviewItemState extends State<_ReviewItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _heightAnimation;
  late final Animation<double> _opacityAnimation;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _heightAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
    );
    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> runDeleteAnimation() async {
    final cubit = context.read<ProfileReviewsCubit>();
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _isDeleting = true;
    });
    await _controller.forward();

    final success = await cubit.deleteReview(widget.review.tripId);
    if (!success && mounted) {
      await _controller.reverse();
      setState(() {
        _isDeleting = false;
      });
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Failed to delete review. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cardChild = ReviewCard(
      data: widget.data,
      onEdit: widget.isSkeleton
          ? null
          : () {
              TripReviewDialog.show(
                context,
                tripTitle: widget.review.destination,
                initialRating: widget.review.rating,
                initialComment: widget.review.comment,
                onSubmitted: (newRating, newComment) async {
                  final cubit = context.read<ProfileReviewsCubit>();
                  final messenger = ScaffoldMessenger.of(context);
                  final navigator = Navigator.of(context, rootNavigator: true);
                  AppDialog.showLoading(
                    context: context,
                    title: 'Updating review',
                  );
                  final success = await cubit.editReview(
                    widget.review.tripId,
                    newRating,
                    newComment,
                  );
                  if (mounted) {
                    if (navigator.canPop()) {
                      navigator.pop();
                    }
                  }

                  if (!success && mounted) {
                    messenger.showSnackBar(
                      const SnackBar(content: Text('Failed to update review')),
                    );
                  }
                },
              );
            },
      onDelete: widget.isSkeleton
          ? null
          : () {
              AppDialog.show(
                context: context,
                title: 'Delete Review',
                description: 'Are you sure you want to delete this review?',
                primaryText: 'Cancel',
                icon: Icons.warning_amber_rounded,
                iconColor: Colors.red,
                onPrimary: () {},
                secondaryText: 'Delete',
                onSecondary: () {
                  runDeleteAnimation();
                },
              );
            },
    );

    if (!_isDeleting) {
      return Padding(
        padding: EdgeInsets.only(bottom: 18.h),
        child: cardChild,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final factor = 1.0 - _heightAnimation.value;
        final opacity = 1.0 - _opacityAnimation.value;
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: SizeTransition(
            sizeFactor: AlwaysStoppedAnimation(factor),
            axis: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(bottom: 18.h),
              child: cardChild,
            ),
          ),
        );
      },
    );
  }
}
