import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';

class RangeCalendar extends StatelessWidget {
  const RangeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    final visibleMonth = context.select(
      (AiPlannerCubit cubit) => cubit.state.visibleMonth,
    );
    final monthLabel = context.select(
      (AiPlannerCubit cubit) => cubit.state.monthLabel,
    );
    final start = context.select(
      (AiPlannerCubit cubit) => cubit.state.tripStart,
    );
    final end = context.select((AiPlannerCubit cubit) => cubit.state.tripEnd);
    final cubit = context.read<AiPlannerCubit>();
    final days = _buildDays(visibleMonth);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.5),
        ),
        boxShadow: [AppShadows.aiplannerShadow],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Text(
                monthLabel,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.onSurface,
                ),
              ),
              const Spacer(),
              _CalendarArrowButton(
                icon: Icons.chevron_left_rounded,
                onTap: cubit.previousMonth,
              ),
              SizedBox(width: 8.w),
              _CalendarArrowButton(
                icon: Icons.chevron_right_rounded,
                onTap: cubit.nextMonth,
              ),
            ],
          ),

          SizedBox(height: 22.h),

          // Week Days
          Row(
            children: const [
              'S',
              'M',
              'T',
              'W',
              'T',
              'F',
              'S',
            ].map((d) => Expanded(child: Center(child: Text(d)))).toList(),
          ),

          SizedBox(height: 14.h),

          // Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6.h,
              crossAxisSpacing: 4.w,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (_, i) {
              final d = days[i];
              final isStart = _isSame(start, d.date);
              final isEnd = _isSame(end, d.date);
              final selected = isStart || isEnd;

              return InkWell(
                onTap: d.isCurrent ? () => cubit.selectTripDate(d.date) : null,
                borderRadius: BorderRadius.circular(8.r),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_inRange(d.date, start, end))
                      Positioned.fill(
                        top: 5.h,
                        bottom: 5.h,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightBlue1.withValues(
                              alpha: 0.45,
                            ),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                        ),
                      ),
                    Container(
                      width: 34.w,
                      height: 34.h,
                      alignment: Alignment.center,
                      decoration: selected
                          ? const BoxDecoration(
                              color: AppColors.primaryLightBlue1,
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Text(
                        '${d.date.day}',
                        style: AppTextStyles.h10Medium.copyWith(
                          color: d.isCurrent
                              ? context.colorTheme.onSurface
                              : AppColors.primaryShadow,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static List<_Cell> _buildDays(DateTime visibleMonth) {
    final first = DateTime(visibleMonth.year, visibleMonth.month, 1);
    final offset = first.weekday % 7;
    final startDay = first.subtract(Duration(days: offset));
    final daysInMonth = DateUtils.getDaysInMonth(
      visibleMonth.year,
      visibleMonth.month,
    );

    final total = ((((offset + daysInMonth) / 7).ceil() * 7).clamp(35, 42));

    return List.generate(total, (i) {
      final date = startDay.add(Duration(days: i));
      return _Cell(date, date.month == visibleMonth.month);
    });
  }

  static bool _isSame(DateTime? a, DateTime b) =>
      a != null && DateUtils.isSameDay(a, b);

  static bool _inRange(DateTime d, DateTime? start, DateTime? end) =>
      start != null && end != null && d.isAfter(start) && d.isBefore(end);
}

class _Cell {
  const _Cell(this.date, this.isCurrent);
  final DateTime date;
  final bool isCurrent;
}

class _CalendarArrowButton extends StatelessWidget {
  const _CalendarArrowButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11.r),
      child: Container(
        width: 22.w,
        height: 22.h,
        decoration: const BoxDecoration(
          color: Color(0xFFF7F8FC),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 15.sp, color: context.colorTheme.outline),
      ),
    );
  }
}
