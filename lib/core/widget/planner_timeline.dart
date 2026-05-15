import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class PlannerTimeline extends StatelessWidget {
  const PlannerTimeline({super.key, required this.stops});

  final List<PlannerStop> stops;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.5.w),
          child: Row(
            children: List.generate(stops.length * 2 - 1, (index) {
              if (index.isOdd) {
                return Expanded(
                  child: Container(
                    height: 2.h,
                    color: context.colorTheme.outline,
                  ),
                );
              }

              final stopIndex = index ~/ 2;
              final isFirst = stopIndex == 0;
              return Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: isFirst
                      ? context.colorTheme.primary
                      : context.colorTheme.outline,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 29.h),
        Row(
          children: stops.map((stop) {
            final parts = stop.time.split(' ');
            return Expanded(
              child: Text(
                parts[0],
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
        Row(
          children: stops.map((stop) {
            final parts = stop.time.split(' ');
            return Expanded(
              child: Text(
                parts.length > 1 ? parts[1] : '',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 14.h),
        Row(
          children: stops
              .map(
                (stop) => Expanded(
                  child: Text(
                    stop.label,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
