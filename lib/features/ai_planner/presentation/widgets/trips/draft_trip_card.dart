import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/rename_trip_dialog.dart';
import 'package:intl/intl.dart';

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
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: context.colorTheme.surface,
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              // Cover thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: 64.w,
                  height: 64.w,
                  child: _DraftCoverImage(coverAsset: trip.coverAsset),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.warning.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Draft',
                            style: AppTextStyles.h10Medium.copyWith(
                              color: AppColors.warning,
                            ),
                          ),
                        ),
                        const Spacer(),
                        _DraftMenu(trip: trip),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      trip.title,
                      style: AppTextStyles.h9Bold.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Last edited ${_formatDate(trip.updatedAt)}',
                      style: AppTextStyles.h10Regular.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Planning progress',
                    style: AppTextStyles.h10Regular.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${(trip.planningProgress * 100).toInt()}%',
                    style: AppTextStyles.h10Medium.copyWith(
                      color: context.colorTheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: LinearProgressIndicator(
                  value: trip.planningProgress,
                  backgroundColor: context.colorTheme.primary.withValues(
                    alpha: 0.1,
                  ),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.colorTheme.primary,
                  ),
                  minHeight: 6,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Continue button
          CustomGradientButton(
            text: 'Continue Planning',
            onTap: onContinue,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d').format(date);
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
      errorBuilder: (_, __, ___) => Container(
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

class _DraftMenu extends StatelessWidget {
  const _DraftMenu({required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.more_vert_rounded,
        size: 20.sp,
        color: context.colorTheme.onSurfaceVariant,
      ),
      color: context.colorTheme.surface,
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
              Icon(Icons.edit_outlined, size: 18.sp),
              SizedBox(width: 10.w),
              Text('Rename', style: AppTextStyles.h9Regular),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: 18.sp,
                color: Colors.red,
              ),
              SizedBox(width: 10.w),
              Text(
                'Delete Draft',
                style: AppTextStyles.h9Regular.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
