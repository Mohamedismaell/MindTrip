import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_state.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class FavoriteTripCard extends StatelessWidget {
  const FavoriteTripCard({super.key, required this.trip, this.onTap});

  final FavoriteTripEntity trip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      enableOverlay: false,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: SizedBox(
          width: 205.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: 'trip-image-${trip.tripId}',
                child: const AppCachedImage(
                  imagePath: 'assets/images/onboarding/Pyramids.webp',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10.h,
                left: 10.w,
                child: _StatusChip(status: trip.status),
              ),
              Positioned(
                top: 10.h,
                right: 10.w,
                child: TripFavoriteBubble(trip: trip, small: true),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 0, sigmaY: 4),
                    child: Container(
                      height: 86.h,
                      width: double.infinity,
                      padding: EdgeInsets.all(10.w),
                      color: Colors.black.withValues(alpha: 0.26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            trip.destination,
                            style: AppTextStyles.h8Bold.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: AppColors.primaryLightGray,
                                size: 13.sp,
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  '${trip.durationDays} Days',
                                  style: context.textTheme.bodySmall?.copyWith(
                                    color: AppColors.primaryLightGray,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _dateRange,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.78),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _dateRange {
    final start = _formatDate(trip.startDate);
    final end = _formatDate(trip.endDate);
    return '$start - $end';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class TripFavoriteBubble extends StatelessWidget {
  const TripFavoriteBubble({super.key, required this.trip, this.small = false});

  final FavoriteTripEntity trip;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 28.w : 34.w;

    return BlocBuilder<TripFavoriteCubit, TripFavoriteState>(
      builder: (context, state) {
        final isFavorite = context.read<TripFavoriteCubit>().isTripFavorite(
          trip.tripId,
        );

        return GestureDetector(
          onTap: () {
            context.read<TripFavoriteCubit>().toggleTripFavorite(
              tripId: trip.tripId,
              isFavorite: !isFavorite,
              trip: trip,
            );
          },
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.35),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: small ? 17.sp : 19.sp,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: context.colorTheme.primary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        status,
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
