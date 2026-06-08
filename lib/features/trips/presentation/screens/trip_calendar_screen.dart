import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';
import 'package:mindtrip/features/trips/presentation/widgets/calendar_day_cell.dart';
import 'package:mindtrip/features/trips/presentation/widgets/custom_calender_header.dart';
import 'package:mindtrip/features/trips/presentation/widgets/schedule_trip_tile.dart';
import 'package:mindtrip/features/trips/presentation/widgets/swipe_calender_arrrow.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class TripCalendarScreen extends StatelessWidget {
  const TripCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),

          child: CustomScrollView(
            slivers: [
              // HEADER
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    const CustomCalenderHeader(),
                    SizedBox(height: 28.h),
                  ],
                ),
              ),

              // CALENDAR
              SliverToBoxAdapter(
                child: Container(
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
                            // MONTH HEADER
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

                                SwipeCalenderArrrow(
                                  onTap: () {
                                    context.read<TripsCubit>().previouseMonth(
                                      focusedDay,
                                    );
                                  },
                                  icon: Icons.chevron_left_rounded,
                                ),
                                SizedBox(width: 12.w),
                                SwipeCalenderArrrow(
                                  onTap: () {
                                    cubit.nextMonth(focusedDay);
                                  },
                                  icon: Icons.chevron_right_rounded,
                                ),
                              ],
                            ),

                            SizedBox(height: 20.h),

                            // CALENDAR
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
                                  cubit.getTripsForDay(day, state.trips),

                              selectedDayPredicate: (day) {
                                return isSameDay(selectedDay, day);
                              },

                              onPageChanged: (focusedDay) {
                                cubit.changeMonth(
                                  DateTime(
                                    focusedDay.year,
                                    focusedDay.month,
                                    1,
                                  ),
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

                                defaultBuilder: (context, day, focusedDay) {
                                  return CalendarDayCell(
                                    day: day,
                                    trips: state.trips,
                                  );
                                },

                                outsideBuilder: (context, day, focusedDay) {
                                  return CalendarDayCell(
                                    day: day,
                                    trips: state.trips,
                                    isToday: true,
                                  );
                                },

                                todayBuilder: (context, day, focusedDay) {
                                  return CalendarDayCell(
                                    day: day,
                                    trips: state.trips,
                                    isToday: true,
                                  );
                                },

                                selectedBuilder: (context, day, focusedDay) {
                                  return CalendarDayCell(
                                    day: day,
                                    trips: state.trips,
                                    isToday: true,
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
              ),

              // TITLE
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 28.h),
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
                  ],
                ),
              ),

              // SCHEDULE LIST
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  final currentMonthTrips = context
                      .read<TripsCubit>()
                      .getTripsForMonth(state.focusedDay);

                  if (currentMonthTrips.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No trips scheduled for this month.',

                          style: AppTextStyles.h10Regular.copyWith(
                            color: context.colorTheme.outline,
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList.builder(
                    itemCount: currentMonthTrips.length,

                    itemBuilder: (context, index) {
                      final trip = currentMonthTrips[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),

                        child: TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 350 + (index * 60)),
                          tween: Tween(begin: 0, end: 1),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return Opacity(
                              opacity: value,

                              child: Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),

                                child: Transform.scale(
                                  scale: 0.98 + (0.02 * value),

                                  child: child,
                                ),
                              ),
                            );
                          },
                          child: ScheduleTripTile(
                            key: ValueKey(trip.id),
                            trip: trip,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}
