import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/outlined_action_button.dart';

class TripMapPreviewCard extends StatelessWidget {
  const TripMapPreviewCard({
    super.key,
    required this.days,
    required this.onViewMap,
  });

  final List<TripDay> days;
  final VoidCallback? onViewMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFF9CA3AF)),
      ),
      child: Column(
        children: [
          Text('Your Trip Map', style: AppTextStyles.h7Bold),
          SizedBox(height: 18.h),
          Container(
            height: 181.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFE4B9), Color(0xFFBDE7FF)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10.w,
                  top: 10.h,
                  child: _MapLegend(days: days.take(3).toList()),
                ),
                ..._mapPins(context),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          SizedBox(
            width: 217.w,
            child: OutlinedActionButton(
              key: const Key('trip-map-button'),
              label: 'View full map',
              icon: Icons.map_outlined,
              onPressed: onViewMap,
              fontSize: 20.sp,
              height: 52.h,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _mapPins(BuildContext context) {
    const pinData = [
      (Offset(0.48, 0.28), '1', Color(0xFF5596FE)),
      (Offset(0.36, 0.52), '2', Color(0xFFA36DDB)),
      (Offset(0.22, 0.78), '3', Color(0xFFEB9242)),
    ];

    return pinData
        .map(
          (pin) => Positioned(
            left: 260.w * pin.$1.dx,
            top: 150.h * pin.$1.dy,
            child: Container(
              width: 24.w,
              height: 24.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: pin.$3,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Text(
                pin.$2,
                style: AppTextStyles.h10Bold.copyWith(color: Colors.white),
              ),
            ),
          ),
        )
        .toList();
  }
}

class _MapLegend extends StatelessWidget {
  const _MapLegend({required this.days});

  final List<TripDay> days;

  @override
  Widget build(BuildContext context) {
    const colors = [Color(0xFF5596FE), Color(0xFFA36DDB), Color(0xFFEB9242)];

    return Container(
      width: 58.w,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        children: [
          for (var i = 0; i < days.length; i++) ...[
            Text(
              'Day ${days[i].dayNumber}',
              style: AppTextStyles.h10Bold.copyWith(color: colors[i]),
            ),
            if (i != days.length - 1) SizedBox(height: 8.h),
          ],
        ],
      ),
    );
  }
}
