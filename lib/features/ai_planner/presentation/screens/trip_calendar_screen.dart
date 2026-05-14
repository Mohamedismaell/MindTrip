import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/calendar_day_cell.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/schedule_trip_tile.dart';
import 'package:intl/intl.dart';

class TripCalendarScreen extends StatefulWidget {
  const TripCalendarScreen({super.key});

  @override
  State<TripCalendarScreen> createState() => _TripCalendarScreenState();
}

class _TripCalendarScreenState extends State<TripCalendarScreen> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  List<Trip> _getTripsInMonth(List<Trip> allTrips, DateTime month) {
    return allTrips.where((trip) {
      if (trip.tripStart == null || trip.tripEnd == null) return false;
      // If trip overlaps with the current month
      final monthStart = DateTime(month.year, month.month, 1);
      final monthEnd = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
      
      return trip.tripStart!.isBefore(monthEnd) && trip.tripEnd!.isAfter(monthStart);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 26.sp,
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Trip ',
                            style: AppTextStyles.h5Bold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: 'Calendar',
                            style: AppTextStyles.h5Bold.copyWith(
                              color: context.colorTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 4.h),
            Padding(
              padding: EdgeInsets.only(left: 58.w, right: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'All your travel dates in one place',
                  style: AppTextStyles.h10Regular.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 32.h),
            
            Expanded(
              child: BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  final tripsInMonth = _getTripsInMonth(state.trips, _currentMonth);
                  
                  return CustomScrollView(
                    slivers: [
                      // Month Navigation
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.chevron_left_rounded, color: context.colorTheme.onSurface),
                                onPressed: _previousMonth,
                              ),
                              Text(
                                DateFormat('MMMM yyyy').format(_currentMonth),
                                style: AppTextStyles.h7Bold.copyWith(
                                  color: context.colorTheme.onSurface,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.chevron_right_rounded, color: context.colorTheme.onSurface),
                                onPressed: _nextMonth,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                      
                      // Days of week header
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
                              return SizedBox(
                                width: 32.w,
                                child: Center(
                                  child: Text(
                                    day,
                                    style: AppTextStyles.h10Medium.copyWith(
                                      color: context.colorTheme.outline,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      
                      SliverToBoxAdapter(child: SizedBox(height: 8.h)),
                      
                      // Calendar Grid
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: _CalendarGrid(
                            currentMonth: _currentMonth,
                            trips: state.trips,
                          ),
                        ),
                      ),
                      
                      SliverToBoxAdapter(child: SizedBox(height: 32.h)),
                      
                      // My Schedule Title
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text(
                            'My Schedule',
                            style: AppTextStyles.h7Bold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      
                      SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                      
                      // Schedule List
                      if (tripsInMonth.isEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
                            child: Center(
                              child: Text(
                                'No trips scheduled for this month.',
                                style: AppTextStyles.h10Regular.copyWith(
                                  color: context.colorTheme.outline,
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => ScheduleTripTile(trip: tripsInMonth[index]),
                              childCount: tripsInMonth.length,
                            ),
                          ),
                        ),
                        
                      SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({required this.currentMonth, required this.trips});
  
  final DateTime currentMonth;
  final List<Trip> trips;

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstDayWeekday = DateTime(currentMonth.year, currentMonth.month, 1).weekday;
    // Dart weekday: 1=Mon, 7=Sun. We want 0=Sun.
    final emptyPrefixCells = firstDayWeekday == 7 ? 0 : firstDayWeekday;
    
    final totalCells = emptyPrefixCells + daysInMonth;
    final rowCount = (totalCells / 7).ceil();
    
    final now = DateTime.now();

    return Column(
      children: List.generate(rowCount, (rowIndex) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (colIndex) {
            final cellIndex = rowIndex * 7 + colIndex;
            final day = cellIndex - emptyPrefixCells + 1;
            
            if (day < 1 || day > daysInMonth) {
              return SizedBox(width: 32.w, height: 40.h);
            }
            
            final date = DateTime(currentMonth.year, currentMonth.month, day);
            final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
            
            final state = _getDayState(date, isToday);
            
            return SizedBox(
              width: 32.w,
              height: 40.h,
              child: CalendarDayCell(date: date, state: state),
            );
          }),
        );
      }),
    );
  }
  
  DayCellState _getDayState(DateTime date, bool isToday) {
    for (final trip in trips) {
      if (trip.tripStart == null || trip.tripEnd == null) continue;
      
      final s = DateTime(trip.tripStart!.year, trip.tripStart!.month, trip.tripStart!.day);
      final e = DateTime(trip.tripEnd!.year, trip.tripEnd!.month, trip.tripEnd!.day);
      final d = DateTime(date.year, date.month, date.day);
      
      if (d == s && d == e) return DayCellState.start; // Single day trip
      if (d == s) return DayCellState.start;
      if (d == e) return DayCellState.end;
      if (d.isAfter(s) && d.isBefore(e)) return DayCellState.middle;
    }
    
    if (isToday) return DayCellState.today;
    return DayCellState.normal;
  }
}
