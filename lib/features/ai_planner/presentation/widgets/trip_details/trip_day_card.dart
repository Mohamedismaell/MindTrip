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

  const TripDayCard({
    super.key,
    required this.day,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          // Day Header
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(20.r),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: context.colorTheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        '${day.dayNumber}',
                        style: AppTextStyles.h7Bold.copyWith(
                          color: context.colorTheme.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Day ${day.dayNumber}',
                          style: AppTextStyles.h8Bold,
                        ),
                        Text(
                          '${day.stopCount} Activities',
                          style: AppTextStyles.h10Regular.copyWith(
                            color: context.colorTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: context.colorTheme.outline,
                  ),
                ],
              ),
            ),
          ),

          // Expanded Slots
          if (isExpanded) ...[
            const Divider(height: 1),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.r),
              itemCount: day.timeSlots.length,
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
              itemBuilder: (context, index) {
                return TimePeriodSection(slot: day.timeSlots[index]);
              },
            ),
          ],
        ],
      ),
    );
  }
}
