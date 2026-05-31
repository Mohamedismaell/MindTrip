import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsOverview extends StatelessWidget {
  final PlaceModel place;
  const PlaceDetailsOverview({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    if (place.description == null || place.description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          place.description!,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorTheme.outline,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
