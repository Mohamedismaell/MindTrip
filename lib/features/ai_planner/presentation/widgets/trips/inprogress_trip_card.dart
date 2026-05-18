import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/trip_menu_button.dart';

class InprogressTripCard extends StatelessWidget {
  const InprogressTripCard({
    super.key,
    required this.trip,
    required this.onContinue,
  });

  final Trip trip;
  final VoidCallback onContinue;

  String get _coverImage => trip.itineraryCoverUrl ?? trip.coverAsset;

  @override
  Widget build(BuildContext context) {
    final places = trip.placePreviews;
    //Todo : we may change into card rather than container
    return Container(
      // height: 500.h,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.colorTheme.outline, width: 1),
        boxShadow: [AppShadows.tourPackagesCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(19.r),
                topRight: Radius.circular(19.r),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: _InProgressCoverImage(coverUrl: _coverImage),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 17.h,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLightGray,
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Text('Draft', style: context.textTheme.bodyMedium),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Last Update
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            trip.title,
                            style: AppTextStyles.h6Bold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        TripMenuButton(trip: trip),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 18.w,
                              height: 18.h,
                              child: SvgPicture.asset(
                                HomeAssets.locationIcon,
                                colorFilter: ColorFilter.mode(
                                  context.colorTheme.onSurfaceVariant,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),

                            SizedBox(width: 8.w),

                            Text(
                              '${trip.destination} / Egypt',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorTheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                        SizedBox(width: 9.w),
                        if (trip.tripStart != null)
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: context.colorTheme.onSurfaceVariant,
                                size: 16.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '${trip.durationDays} Days',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colorTheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 11.h),
                    Row(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 18.sp,
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Places to visit',
                          style: AppTextStyles.h9SemiBold.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    if (places.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...places.take(2).map((place) {
                            final name = place['name'] ?? '';
                            // final imgUrl = place['imageUrl'] ?? '';
                            return Padding(
                              padding: EdgeInsets.only(bottom: 4.h),
                              child: Row(
                                children: [
                                  Text(
                                    "• $name",
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            );
                          }),
                          if (places.length > 2)
                            Text(
                              '+${places.length - 2} more places',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Trip Progress',
                          style: AppTextStyles.h8Medium.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${trip.daysRemaining} Days',
                          style: AppTextStyles.h8Medium.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: LinearProgressIndicator(
                        value: trip.tripProgress,
                        backgroundColor: AppColors.primaryLightGray,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          context.colorTheme.primary,
                        ),
                        minHeight: 9.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.h),

                // Button
                CustomGradientButton(
                  text: 'View Trip',
                  onTap: onContinue,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InProgressCoverImage extends StatelessWidget {
  const _InProgressCoverImage({required this.coverUrl});
  final String coverUrl;
  @override
  Widget build(BuildContext context) {
    final isNetwork = coverUrl.startsWith('http');
    return isNetwork
        ? AppCachedImage(imageUrl: coverUrl, fit: BoxFit.cover)
        : Image.asset(
            coverUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: context.colorTheme.primary.withValues(alpha: 0.12),
              child: Icon(
                Icons.travel_explore_rounded,
                color: context.colorTheme.primary.withValues(alpha: 0.5),
                size: 28.sp,
              ),
            ),
          );
  }
}
