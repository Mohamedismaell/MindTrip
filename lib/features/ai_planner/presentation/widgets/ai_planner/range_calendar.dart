import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/trips/presentation/widgets/swipe_calender_arrrow.dart';
import 'package:table_calendar/table_calendar.dart';

class RangeCalendar extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(DateTime)? onDateSelected;
  final DateTime? initialFocusedDay;

  const RangeCalendar({
    super.key,
    this.startDate,
    this.endDate,
    this.onDateSelected,
    this.initialFocusedDay,
  });

  @override
  State<RangeCalendar> createState() => _RangeCalendarState();
}

class _RangeCalendarState extends State<RangeCalendar> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.initialFocusedDay ?? DateTime.now();
  }

  void _onPageChanged(DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
    });
  }

  void _nextMonth() {
    final next = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
    if (next.isAfter(DateTime.utc(2030, 12, 31))) return;
    setState(() {
      _focusedDay = next;
    });
  }

  void _previousMonth() {
    final prev = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
    if (prev.isBefore(DateTime.utc(2020, 1, 1))) return;
    setState(() {
      _focusedDay = prev;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onDateSelected != null) {
      return _buildCalendarContent(
        context,
        focusedDay: _focusedDay,
        startDate: widget.startDate,
        endDate: widget.endDate,
        onDateSelected: widget.onDateSelected!,
        nextMonth: _nextMonth,
        previousMonth: _previousMonth,
        onPageChanged: _onPageChanged,
      );
    }

    return BlocBuilder<AiPlannerCubit, AiPlannerState>(
      builder: (context, state) {
        final cubit = context.read<AiPlannerCubit>();
        return _buildCalendarContent(
          context,
          focusedDay: state.focusedDay,
          startDate: state.tripStart,
          endDate: state.tripEnd,
          onDateSelected: cubit.selectTripDate,
          nextMonth: cubit.nextMonth,
          previousMonth: cubit.previousMonth,
          onPageChanged: cubit.changeMonth,
        );
      },
    );
  }

  Widget _buildCalendarContent(
    BuildContext context, {
    required DateTime focusedDay,
    required DateTime? startDate,
    required DateTime? endDate,
    required Function(DateTime) onDateSelected,
    required VoidCallback nextMonth,
    required VoidCallback previousMonth,
    required Function(DateTime) onPageChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(48.r),
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.6),
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(23.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // MONTH HEADER
            Row(
              children: [
                Expanded(
                  child: Text(
                    DateFormat('MMMM yyyy').format(focusedDay),
                    style: AppTextStyles.h9Medium.copyWith(
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                ),
                SwipeCalenderArrrow(
                  onTap: previousMonth,
                  icon: Icons.chevron_left_rounded,
                ),
                SizedBox(width: 12.w),
                SwipeCalenderArrrow(
                  onTap: nextMonth,
                  icon: Icons.chevron_right_rounded,
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // CALENDAR
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: focusedDay,
              headerVisible: false,
              rangeStartDay: startDate,
              rangeEndDay: endDate,
              enabledDayPredicate: (day) {
                final today = DateTime.now();
                final todayOnly = DateTime(today.year, today.month, today.day);

                return !day.isBefore(todayOnly);
              },
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              daysOfWeekHeight: 40.h,
              rowHeight: 50.h,
              calendarStyle: CalendarStyle(
                rangeHighlightColor: Colors.transparent,
                rangeHighlightScale: 0,
                cellMargin: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 6.h,
                ),
                cellPadding: EdgeInsets.zero,
                outsideDaysVisible: true,
              ),
              onDaySelected: (selectedDay, focusedDay) {
                onDateSelected(selectedDay);
              },
              onPageChanged: onPageChanged,
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
                  return Center(
                    child: Text(
                      days[day.weekday % 7],
                      style: AppTextStyles.h9Medium.copyWith(
                        color: context.colorTheme.onSurfaceVariant,
                      ),
                    ),
                  );
                },
                defaultBuilder: (context, day, focusedDay) =>
                    _buildDayCell(context, day),
                outsideBuilder: (context, day, focusedDay) =>
                    _buildDayCell(context, day),
                todayBuilder: (context, day, focusedDay) =>
                    _buildDayCell(context, day, isToday: true),
                rangeStartBuilder: (context, day, focusedDay) => _buildDayCell(
                  context,
                  day,
                  isSelected: true,
                  isRangeStart: true,
                  hasRange: startDate != null && endDate != null,
                ),
                rangeEndBuilder: (context, day, focusedDay) => _buildDayCell(
                  context,
                  day,
                  isSelected: true,
                  isRangeEnd: true,
                  hasRange: startDate != null && endDate != null,
                ),
                withinRangeBuilder: (context, day, focusedDay) => _buildDayCell(
                  context,
                  day,
                  isWithinRange: true,
                  hasRange: startDate != null && endDate != null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    DateTime day, {
    bool isToday = false,
    bool isSelected = false,
    bool isWithinRange = false,
    bool isRangeStart = false,
    bool isRangeEnd = false,
    bool hasRange = false,
  }) {
    final bool isInRange =
        hasRange && (isWithinRange || isRangeStart || isRangeEnd);
    final bool isSpecial = isSelected || isRangeStart || isRangeEnd;

    return Container(
      width: 32.w,
      height: 32.h,
      alignment: Alignment.center,
      decoration: isSpecial
          ? const BoxDecoration(
              color: AppColors.primaryLightBlue1,
              shape: BoxShape.circle,
            )
          : (isToday
                ? BoxDecoration(
                    color: AppColors.primaryLightBlue2.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.colorTheme.primary,
                      width: 1.w,
                    ),
                  )
                : (isInRange
                      ? BoxDecoration(
                          color: AppColors.primaryLightBlue1.withValues(
                            alpha: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        )
                      : null)),
      child: Text(
        '${day.day}',
        style: AppTextStyles.h10Medium.copyWith(
          color: isSpecial ? AppColors.pureWhite : context.colorTheme.onSurface,
        ),
      ),
    );
  }
}
