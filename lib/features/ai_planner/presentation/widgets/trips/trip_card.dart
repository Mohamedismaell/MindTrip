import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/rename_trip_dialog.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip, this.onTap});

  final Trip trip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final coverAsset = trip.coverAsset;
    final isLocal = !coverAsset.startsWith('http');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: context.colorTheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image
              SizedBox(
                height: 160.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _CoverImage(coverAsset: coverAsset, isLocal: isLocal),
                    // Status badge
                    Positioned(
                      top: 12.h,
                      left: 12.w,
                      child: _StatusBadge(status: trip.status),
                    ),
                    // 3-dot menu
                    Positioned(
                      top: 8.h,
                      right: 4.w,
                      child: _TripMenu(trip: trip),
                    ),
                  ],
                ),
              ),
              // Info
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trip.title,
                      style: AppTextStyles.h8Bold.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 14.sp,
                          color: context.colorTheme.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          trip.destination,
                          style: AppTextStyles.h10Regular.copyWith(
                            color: context.colorTheme.onSurfaceVariant,
                          ),
                        ),
                        if (trip.durationDays > 0) ...[
                          SizedBox(width: 12.w),
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 13.sp,
                            color: context.colorTheme.outline,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '${trip.durationDays}d',
                            style: AppTextStyles.h10Regular.copyWith(
                              color: context.colorTheme.outline,
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Updated ${_formatDate(trip.updatedAt)}',
                      style: AppTextStyles.h10Regular.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.coverAsset, required this.isLocal});
  final String coverAsset;
  final bool isLocal;

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (isLocal) {
      image = Image.asset(
        coverAsset,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _FallbackCover(),
      );
    } else {
      image = Image.network(
        coverAsset,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _FallbackCover(),
      );
    }

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.black.withValues(alpha: 0.25),
        BlendMode.darken,
      ),
      child: image,
    );
  }
}

class _FallbackCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorTheme.primary.withValues(alpha: 0.15),
      child: Center(
        child: Icon(
          Icons.travel_explore_rounded,
          size: 48.sp,
          color: context.colorTheme.primary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final TripStatus status;

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    String text;

    switch (status) {
      case TripStatus.completed:
        bgColor = AppColors.success;
        text = 'Completed';
        break;
      case TripStatus.inProgress:
        bgColor = Theme.of(context).colorScheme.primary;
        text = 'In Progress';
        break;
      case TripStatus.draft:
        bgColor = AppColors.warning;
        text = 'Draft';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.h10Medium.copyWith(color: Colors.white),
      ),
    );
  }
}

class _TripMenu extends StatelessWidget {
  const _TripMenu({required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, color: Colors.white, size: 22.sp),
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
                'Delete',
                style: AppTextStyles.h9Regular.copyWith(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
