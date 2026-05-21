import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';
import 'package:mindtrip/features/map/domain/utils/mapbox_static_url_builder.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 181.h,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(imageUrl: _buildMapUrl(), fit: BoxFit.cover),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: _MapLegend(days: days.take(3).toList()),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: CustomOtlinedButton(
              key: const Key('trip-map-button'),
              text: 'View full map',
              actionIcon: Icons.map_outlined,
              onPressed: onViewMap,
              color: context.colorTheme.primary,
              textStyle: AppTextStyles.h7Bold,
            ),
          ),
        ],
      ),
    );
  }

  String _buildMapUrl() {
    final colors = ['5596FE', 'A36DDB', 'EB9242'];
    final markers = <PlaceMarker>[];

    for (var i = 0; i < days.length; i++) {
      final day = days[i];
      final hex = colors[i % colors.length];
      int count = 1;
      for (final slot in day.timeSlots) {
        for (final place in slot.places) {
          markers.add(
            PlaceMarker(
              lat: place.location.latitude,
              lng: place.location.longitude,
              colorHex: hex,
              label: '$count',
            ),
          );
          count++;
        }
      }
    }
    return MapboxStaticUrlBuilder.buildStaticMapUrl(
      markers: markers,
      width: 800,
      height: 400,
    );
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
