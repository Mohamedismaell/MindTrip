import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/time_period_section.dart';

class TripDayCard extends StatelessWidget {
  final TripDay day;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onViewMap;

  const TripDayCard({
    super.key,
    required this.day,
    required this.isExpanded,
    required this.onToggle,
    this.onViewMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Day Header
        InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
            child: Row(
              children: [
                // Timeline Dot
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: isExpanded
                        ? context.colorTheme.primary
                        : context.colorTheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${day.dayNumber}',
                      style: AppTextStyles.h7Bold.copyWith(
                        color: isExpanded
                            ? Colors.white
                            : context.colorTheme.onSurface,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day.title, style: AppTextStyles.h7Bold),
                      Text(
                        '${day.stopCount} Activities',
                        style: AppTextStyles.h10Regular.copyWith(
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isExpanded && onViewMap != null)
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      color: context.colorTheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.map_outlined,
                        color: context.colorTheme.primary,
                      ),
                      onPressed: onViewMap,
                    ),
                  )
                else
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Icon(
                      Icons.expand_more,
                      color: context.colorTheme.outline,
                    ),
                  ),
              ],
            ),
          ),
        ),

        // Expanded Slots
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The vertical timeline line
                Container(
                  width: 44.w,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(left: 8.w),
                  child: Container(
                    width: 2.w,
                    color: context.colorTheme.outline.withValues(alpha: 0.15),
                  ),
                ),
                SizedBox(width: 16.w),
                // The activities
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 32.h,
                      top: 12.h,
                      right: 8.w,
                    ),
                    child: Column(
                      children: day.timeSlots.map((slot) {
                        return TimePeriodSection(slot: slot);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}
