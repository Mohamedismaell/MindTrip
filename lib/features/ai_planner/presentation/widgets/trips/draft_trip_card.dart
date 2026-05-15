import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/rename_trip_dialog.dart';

class DraftTripCard extends StatelessWidget {
  const DraftTripCard({
    super.key,
    required this.trip,
    required this.onContinue,
  });

  final Trip trip;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 453.h,
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
          Expanded(
            flex: 2,
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
                    child: _DraftCoverImage(coverAsset: trip.coverAsset),
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
          Expanded(
            flex: 4,
            child: Padding(
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
                          _DraftMenuButton(trip: trip),
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
                      SizedBox(height: 4.h),
                      Text(
                        'Last edited: ${_formatTimeAgo(trip.updatedAt)}',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                    ],
                  ),

                  // Steps
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Just ${trip.remainingStep} steps left to create your magic trip!',
                        style: AppTextStyles.h8Medium.copyWith(
                          color: context.colorTheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Text(
                            'Planning Progress',
                            style: AppTextStyles.h8Medium.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${(trip.planningProgress * 100).toInt()}%',
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
                          value: trip.planningProgress,
                          backgroundColor: AppColors.primaryLightGray,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.colorTheme.primary,
                          ),
                          minHeight: 9.h,
                        ),
                      ),
                    ],
                  ),
                  // Button
                  CustomGradientButton(
                    text: 'Continue Planning',
                    onTap: onContinue,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DraftCoverImage extends StatelessWidget {
  const _DraftCoverImage({required this.coverAsset});
  final String coverAsset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      coverAsset,
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

class _DraftMenuButton extends StatelessWidget {
  const _DraftMenuButton({required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_rounded,
        size: 20.sp,
        color: context.colorTheme.onSurface,
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (value) {
        if (value == 'rename') {
          showRenameTripDialog(
            context,
            tripId: trip.id,
            currentTitle: trip.title,
          );
        } else if (value == 'delete') {
          context.read<TripsCubit>().deleteTrip(trip.id);
        }
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'rename',
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 22.sp),
              SizedBox(width: 10.w),
              Text('Rename', style: context.textTheme.bodyLarge),
            ],
          ),
        ),

        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 22.sp,
                color: Colors.red,
              ),
              SizedBox(width: 10.w),
              Text(
                'Delete Draft',
                style: context.textTheme.bodyLarge?.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _formatTimeAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s ago';
  }

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  }

  if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  }

  if (difference.inDays < 30) {
    return '${difference.inDays}d ago';
  }

  if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '${months}mo ago';
  }

  final years = (difference.inDays / 365).floor();
  return '${years}y ago';
}
