import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/day_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';

typedef _TimelineSlotData = ({
  PlaceDayPeriod period,
  String title,
  List<PlanPlaceEntity> places,
});

class DayTimeline extends StatelessWidget {
  const DayTimeline({super.key, required this.dayEntity});

  final DayPlanEntity dayEntity;

  List<_TimelineSlotData> get _slots => [
    if (dayEntity.morning.isNotEmpty)
      (
        period: PlaceDayPeriod.morning,
        title: 'Morning',
        places: dayEntity.morning,
      ),
    if (dayEntity.afternoon.isNotEmpty)
      (
        period: PlaceDayPeriod.afternoon,
        title: 'Afternoon',
        places: dayEntity.afternoon,
      ),
    if (dayEntity.evening.isNotEmpty)
      (
        period: PlaceDayPeriod.evening,
        title: 'Evening',
        places: dayEntity.evening,
      ),
  ];

  @override
  Widget build(BuildContext context) {
    final slots = _slots;
    if (slots.isEmpty) return const SizedBox.shrink();

    return BlocBuilder<TripDetailsCubit, TripDetailsState>(
      buildWhen: (previous, current) =>
          previous.checkedPlaces != current.checkedPlaces ||
          previous.trip != current.trip,
      builder: (context, state) {
        final checkedPlaces = state.checkedPlaces;

        final completedStates = slots
            .map(
              (slot) =>
                  slot.places.isNotEmpty &&
                  slot.places.every(
                    (place) => checkedPlaces.contains(place.name),
                  ),
            )
            .toList();

        final activeIndex = _resolveActiveSlotIndex(completedStates);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < slots.length; i++)
              _TimelineSlot(
                period: slots[i].period,
                title: slots[i].title,
                places: slots[i].places,
                isLast: i == slots.length - 1,
                isActive: i == activeIndex,
                isCompleted: completedStates[i],
              ),
          ],
        );
      },
    );
  }

  int _resolveActiveSlotIndex(List<bool> completedStates) {
    final nextIncompleteIndex = completedStates.indexWhere((done) => !done);
    if (nextIncompleteIndex != -1) return nextIncompleteIndex;
    return completedStates.isEmpty ? 0 : completedStates.length - 1;
  }
}

class _TimelineSlot extends StatelessWidget {
  const _TimelineSlot({
    required this.period,
    required this.title,
    required this.places,
    required this.isLast,
    required this.isActive,
    required this.isCompleted,
  });

  final PlaceDayPeriod period;
  final String title;
  final List<PlanPlaceEntity> places;
  final bool isLast;
  final bool isActive;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    final lineColor = isCompleted
        ? context.colorTheme.primary
        : context.colorTheme.outline;

    final dotColor = isActive
        ? context.colorTheme.primary
        : isCompleted
        ? context.colorTheme.primary
        : lineColor.withValues(alpha: 0.55);

    final dotSize = isActive ? 16.w : 14.w;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: _TimelinePainter(
            color: lineColor,
            isLast: isLast,
            dotSize: 16.w,
            strokeWidth: 2.5.w,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 28.w, bottom: isLast ? 0 : 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_periodLabel(period)} - $title',
                  style: AppTextStyles.h9Bold.copyWith(
                    color: isActive
                        ? context.colorTheme.primary
                        : context.colorTheme.onSurface,
                  ),
                ),
                SizedBox(height: 12.h),
                _SlotPlacesList(places: places),
              ],
            ),
          ),
        ),
        Positioned(
          left: 1.w,
          top: 0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            curve: Curves.easeInOut,
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? context.colorTheme.primary : dotColor,
                width: isActive ? 1.5 : 1,
              ),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: context.colorTheme.primary.withValues(
                          alpha: 0.20,
                        ),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  String _periodLabel(PlaceDayPeriod period) {
    switch (period) {
      case PlaceDayPeriod.morning:
        return 'Morning';
      case PlaceDayPeriod.afternoon:
        return 'Afternoon';
      case PlaceDayPeriod.evening:
        return 'Evening';
    }
  }
}

class _SlotPlacesList extends StatelessWidget {
  const _SlotPlacesList({required this.places});

  final List<PlanPlaceEntity> places;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripDetailsCubit, TripDetailsState>(
      buildWhen: (previous, current) =>
          previous.checkedPlaces != current.checkedPlaces ||
          previous.trip != current.trip,
      builder: (context, state) {
        final isInProgress = state.trip?.status == TripStatus.inProgress;

        return Column(
          children: places.map((place) {
            final isChecked = state.checkedPlaces.contains(place.name);

            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: InkWell(
                onTap: isInProgress
                    ? () => context.read<TripDetailsCubit>().togglePlaceChecked(
                        place.name,
                      )
                    : null,
                child: Row(
                  children: [
                    if (isInProgress)
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: Checkbox(
                          value: isChecked,
                          onChanged: (_) => context
                              .read<TripDetailsCubit>()
                              .togglePlaceChecked(place.name),
                          activeColor: context.colorTheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text('•', style: AppTextStyles.h9Regular),
                      ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        place.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.h9Regular.copyWith(
                          color: isChecked
                              ? context.colorTheme.outline
                              : context.colorTheme.onSurfaceVariant,
                          decoration: isChecked
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _TimelinePainter extends CustomPainter {
  const _TimelinePainter({
    required this.color,
    required this.isLast,
    required this.dotSize,
    required this.strokeWidth,
  });

  final Color color;
  final bool isLast;
  final double dotSize;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (isLast) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    final centerX = dotSize / 2;
    canvas.drawLine(
      Offset(centerX, dotSize / 2),
      Offset(centerX, size.height + (dotSize / 2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.isLast != isLast ||
        oldDelegate.dotSize != dotSize ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
