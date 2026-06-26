import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/utils/trip_color_palette.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';

class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    super.key,
    required this.day,
    required this.trips,
    this.isToday = false,
    this.isSelected = false,
    this.isOutside = false,
  });

  final DateTime day;
  final List<Trip> trips;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;

  @override
  Widget build(BuildContext context) {
    final events = context.read<TripsCubit>().getTripsForDay(day, trips);

    final dayText = Center(
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

    events.sort((a, b) => b.tripStart.compareTo(a.tripStart));

    final trip = events.first;
    final colors = TripColorPalette.getColorsForId(trip.tripId);

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
        dayText,
      ],
    );
  }
}
