import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/utils/trip_color_palette.dart';

class ScheduleTripTile extends StatelessWidget {
  const ScheduleTripTile({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final isLocal = !(trip.coverImageUrl?.startsWith('http') ?? false);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          // margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.only(
            left: 12.w,
            right: 38.w,
            top: 17.h,
            bottom: 17.h,
          ),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [AppShadows.tourPackagesCard],
            border: Border.all(
              color: context.colorTheme.outline.withValues(alpha: 0.6),
            ),
          ),
          child: Row(
            children: [
              // Cover Thumbnail
              _CoverImage(
                isLocal: isLocal,
                imageCover: trip.coverImageUrl ?? '',
              ),
              SizedBox(width: 13.w),

              // Trip info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: AppColors.pureBlack,
                      ),
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [

                    //     //   Container(
                    //     //     padding: EdgeInsets.symmetric(
                    //     //       horizontal: 6.w,
                    //     //       vertical: 2.h,
                    //     //     ),
                    //     //     decoration: BoxDecoration(
                    //     //       color: AppColors.warning.withValues(alpha: 0.1),
                    //     //       borderRadius: BorderRadius.circular(6.r),
                    //     //     ),
                    //     //     child: Text(
                    //     //       'Draft',
                    //     //       style: AppTextStyles.h10Medium.copyWith(
                    //     //         color: AppColors.warning,
                    //     //       ),
                    //     //     ),
                    //     //   ),
                    //   ],
                    // ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 15.w,
                          height: 15.h,
                          child: SvgPicture.asset(
                            HomeAssets.locationIcon,
                            colorFilter: ColorFilter.mode(
                              context.colorTheme.onSurfaceVariant,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        SizedBox(width: 7.5.w),
                        Expanded(
                          child: Text(
                            '${trip.destinationGovernorate} / Egypt',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                            // maxLines: 1,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: context.colorTheme.onSurfaceVariant,
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${DateFormat('dd MMMM').format(trip.tripStart)} - ${DateFormat('dd MMMM').format(trip.tripStart)} ',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -4.h,
          right: 24.w,
          child: Icon(
            Icons.bookmark,
            size: 32.sp,
            color: TripColorPalette.getColorForId(
              trip.tripId,
            ).withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

// class _FallbackCover extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: context.colorTheme.primary.withValues(alpha: 0.15),
//       child: Center(
//         child: Icon(
//           Icons.travel_explore_rounded,
//           size: 24.sp,
//           color: context.colorTheme.primary.withValues(alpha: 0.5),
//         ),
//       ),
//     );
//   }
// }

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.isLocal, required this.imageCover});
  final bool isLocal;
  final String imageCover;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: SizedBox(
        width: 122.w,
        height: 106,
        child: isLocal
            ? Image.asset(
                imageCover,
                fit: BoxFit.cover,
                // errorBuilder: (_, _, _) => _FallbackCover(),
              )
            : AppCachedImage(imagePath: imageCover, fit: BoxFit.cover),
      ),
    );
  }
}
