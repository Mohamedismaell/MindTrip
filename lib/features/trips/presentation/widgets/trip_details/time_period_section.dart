import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart'; // For PlaceDayPeriod

class TimePeriodSection extends StatelessWidget {
  final PlaceDayPeriod period;
  final List<PlanPlaceEntity> places;

  const TimePeriodSection({
    super.key,
    required this.period,
    required this.places,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Period Header (Morning/Afternoon/Evening)
        Row(
          children: [
            Icon(
              _getTimeIcon(period),
              size: 20.sp,
              color: _getTimeColor(context, period),
            ),
            SizedBox(width: 8.w),
            Text(
              period.name.toUpperCase(),
              style: AppTextStyles.h9Bold.copyWith(
                color: _getTimeColor(context, period),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // List of Places in this slot
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            children: places
                .map((place) => _PlaceActivityTile(place: place))
                .toList(),
          ),
        ),
      ],
    );
  }

  IconData _getTimeIcon(PlaceDayPeriod period) {
    switch (period) {
      case PlaceDayPeriod.morning:
        return Icons.wb_sunny_outlined;
      case PlaceDayPeriod.afternoon:
        return Icons.light_mode_outlined;
      case PlaceDayPeriod.evening:
        return Icons.dark_mode_outlined;
    }
  }

  Color _getTimeColor(BuildContext context, PlaceDayPeriod period) {
    switch (period) {
      case PlaceDayPeriod.morning:
        return Colors.orange;
      case PlaceDayPeriod.afternoon:
        return context.colorTheme.primary;
      case PlaceDayPeriod.evening:
        return Colors.indigo;
    }
  }
}

class _PlaceActivityTile extends StatefulWidget {
  final PlanPlaceEntity place;

  const _PlaceActivityTile({required this.place});

  @override
  State<_PlaceActivityTile> createState() => _PlaceActivityTileState();
}

class _PlaceActivityTileState extends State<_PlaceActivityTile> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.place.imageUrls.firstOrNull;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          // Completion Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _isCompleted = !_isCompleted;
              });
            },
            child: Container(
              width: 24.w,
              height: 24.w,
              margin: EdgeInsets.only(right: 12.w),
              decoration: BoxDecoration(
                color: _isCompleted ? Colors.green : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isCompleted
                      ? Colors.green
                      : context.colorTheme.outline.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: _isCompleted
                  ? Icon(Icons.check, size: 16.sp, color: Colors.white)
                  : null,
            ),
          ),

          // Thumbnail
          if (imageUrl != null && imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                imageUrl,
                width: 60.w,
                height: 60.h,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _PlaceholderImage(),
              ),
            )
          else
            _PlaceholderImage(),

          SizedBox(width: 12.w),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.place.name,
                  style: AppTextStyles.h9SemiBold.copyWith(
                    decoration: _isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: _isCompleted
                        ? context.colorTheme.onSurfaceVariant
                        : context.colorTheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 12.sp,
                      color: context.colorTheme.outline,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        widget.place.address,
                        style: AppTextStyles.h10Regular.copyWith(
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action (View details?)
          Icon(
            Icons.chevron_right,
            size: 20.sp,
            color: context.colorTheme.outline.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.image_outlined,
        color: context.colorTheme.outline,
        size: 20.sp,
      ),
    );
  }
}
