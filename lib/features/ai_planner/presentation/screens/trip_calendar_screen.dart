import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/utils/trip_color_palette.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/schedule_trip_tile.dart';

List<Trip> _getTripsForDay(DateTime day, List<Trip> trips) {
  final d = DateTime(day.year, day.month, day.day);
  return trips.where((trip) {
    if (trip.tripStart == null || trip.tripEnd == null) return false;
    final s = DateTime(
      trip.tripStart!.year,
      trip.tripStart!.month,
      trip.tripStart!.day,
    );
    final e = DateTime(
      trip.tripEnd!.year,
      trip.tripEnd!.month,
      trip.tripEnd!.day,
    );
    return d.isAtSameMomentAs(s) ||
        d.isAtSameMomentAs(e) ||
        (d.isAfter(s) && d.isBefore(e));
  }).toList();
}

class TripCalendarScreen extends StatelessWidget {
  const TripCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: ListView(
            children: [
              SizedBox(height: 16.h),

              // Header
              const _CustomHeader(),
              SizedBox(height: 28.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(48.r),
                  border: Border.all(
                    color: context.colorTheme.outline.withValues(alpha: 0.6),
                    width: 1.w,
                  ),
                ),
                child: BlocBuilder<TripsCubit, TripsState>(
                  builder: (context, state) {
                    final focusedDay = state.focusedDay;
                    final selectedDay = state.selectedDay;
                    final cubit = context.read<TripsCubit>();
                    return Padding(
                      padding: EdgeInsets.all(23.r),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              BlocSelector<TripsCubit, TripsState, DateTime>(
                                selector: (state) {
                                  return state.focusedDay;
                                },
                                builder: (context, focusedDay) {
                                  return Expanded(
                                    child: Text(
                                      DateFormat(
                                        'MMMM yyyy',
                                      ).format(focusedDay),
                                      style: AppTextStyles.h9Medium.copyWith(
                                        color: context.colorTheme.onSurface,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              _ArrrowIcon(
                                onTap: () {
                                  context.read<TripsCubit>().previouseMonth(
                                    focusedDay,
                                  );
                                },
                                icon: Icons.chevron_left_rounded,
                              ),
                              SizedBox(width: 12.w),
                              _ArrrowIcon(
                                onTap: () {
                                  cubit.nextMonth(focusedDay);
                                },
                                icon: Icons.chevron_right_rounded,
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          TableCalendar<Trip>(
                            firstDay: DateTime.utc(2020, 1, 1),
                            lastDay: DateTime.utc(2030, 12, 31),
                            focusedDay: focusedDay,
                            headerVisible: false,
                            daysOfWeekHeight: 40.h,
                            rowHeight: 50.h,

                            calendarStyle: const CalendarStyle(
                              cellMargin: EdgeInsets.zero,
                              cellPadding: EdgeInsets.zero,
                            ),

                            eventLoader: (day) =>
                                _getTripsForDay(day, state.trips),

                            selectedDayPredicate: (day) {
                              return isSameDay(selectedDay, day);
                            },

                            onPageChanged: (focusedDay) {
                              cubit.changeMonth(
                                DateTime(focusedDay.year, focusedDay.month, 1),
                              );
                            },

                            calendarBuilders: CalendarBuilders<Trip>(
                              dowBuilder: (context, day) {
                                final days = [
                                  'S',
                                  'M',
                                  'T',
                                  'W',
                                  'T',
                                  'F',
                                  'S',
                                ];

                                return Center(
                                  child: Text(
                                    days[day.weekday % 7],
                                    style: AppTextStyles.h9Medium.copyWith(
                                      color:
                                          context.colorTheme.onSurfaceVariant,
                                    ),
                                  ),
                                );
                              },
                              // Normal day
                              defaultBuilder: (context, day, focusedDay) {
                                return _buildDayCell(context, day, state.trips);
                              },
                              outsideBuilder: (context, day, focusedDay) {
                                return _buildDayCell(
                                  context,
                                  day,
                                  state.trips,
                                  isOutside: true,
                                );
                              },
                              // Today
                              todayBuilder: (context, day, focusedDay) {
                                return _buildDayCell(
                                  context,
                                  day,
                                  state.trips,
                                  isToday: true,
                                );
                              },
                              // Selected day
                              selectedBuilder: (context, day, focusedDay) {
                                return _buildDayCell(
                                  context,
                                  day,
                                  state.trips,
                                  isSelected: true,
                                );
                              },
                              markerBuilder: (context, day, events) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 28.h),
              // My Schedule Title
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'My Schedule',
                  style: AppTextStyles.h7Bold.copyWith(
                    color: context.colorTheme.onSurface,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              // Schedule List
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  final focusedMonth = state.focusedDay;
                  final currentMonthTrips = state.trips.where((t) {
                    if (t.tripStart == null) return false;
                    final start = t.tripStart!;
                    final end = t.tripEnd ?? start;
                    final startOfMonth = DateTime(
                      focusedMonth.year,
                      focusedMonth.month,
                      1,
                    );
                    final endOfMonth = DateTime(
                      focusedMonth.year,
                      focusedMonth.month + 1,
                      0,
                    );
                    return start.isBefore(
                          endOfMonth.add(const Duration(days: 1)),
                        ) &&
                        end.isAfter(
                          startOfMonth.subtract(const Duration(days: 1)),
                        );
                  }).toList();

                  if (currentMonthTrips.isEmpty) {
                    return Center(
                      child: Text(
                        'No trips scheduled for this month.',
                        style: AppTextStyles.h10Regular.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: currentMonthTrips.map((trip) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: ScheduleTripTile(trip: trip),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    DateTime day,
    List<Trip> trips, {
    bool isToday = false,
    bool isSelected = false,
    bool isOutside = false,
  }) {
    final events = _getTripsForDay(day, trips);

    // Day text
    Widget dayText = Center(
      child: Container(
        width: isToday ? 42.w : 30.w,
        height: isToday ? 42.w : 30.w,

        decoration: BoxDecoration(
          color: isSelected
              ? context.colorTheme.primary
              : (isToday ? AppColors.primaryLightBlue2 : Colors.transparent),

          shape: BoxShape.circle,

          border: isToday
              ? Border.all(color: context.colorTheme.primary, width: 2.w)
              : null,
        ),

        child: Center(
          child: Text(
            '${day.day}',
            style: AppTextStyles.h9Medium.copyWith(
              color: isSelected
                  ? context.colorTheme.onPrimary
                  : (isToday
                        ? AppColors.pureWhite
                        : (isOutside
                              ? context.colorTheme.outline.withValues(
                                  alpha: 0.5,
                                )
                              : context.colorTheme.onSurface)),
            ),
          ),
        ),
      ),
    );
    if (events.isEmpty) {
      return dayText;
    }

    events.sort((a, b) => b.tripStart!.compareTo(a.tripStart!));

    final trip = events.first;

    final colors = TripColorPalette.getColorsForId(trip.id);

    return Stack(
      alignment: Alignment.center,

      children: [
        Center(
          child: Container(
            width: 36.w,
            height: 36.w,

            decoration: BoxDecoration(
              color: colors.edge,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // DAY NUMBER
        dayText,
      ],
    );
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 30.sp,
                  color: context.colorTheme.onSurfaceVariant,
                ),
              ),
            ),

            CustomHeadLine(
              firstTitle: 'My ',
              secondTitle: 'Trips',
              firstStyle: AppTextStyles.h5Bold.copyWith(
                color: context.colorTheme.onSurface,
              ),
              secondStyle: AppTextStyles.h5Bold.copyWith(
                color: context.colorTheme.primary,
              ),
            ),
          ],
        ),

        SizedBox(height: 17.h),

        Text(
          'All your travel dates in one place',
          style: AppTextStyles.h7Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ArrrowIcon extends StatelessWidget {
  const _ArrrowIcon({required this.onTap, required this.icon});
  final VoidCallback onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryLightGray,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24.sp,
          color: context.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
