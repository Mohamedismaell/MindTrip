import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_place_card.dart';

class PlaceDetailsNearbyPlaces extends StatelessWidget {
  final List<PlaceModel> places;
  final bool isLoading;

  const PlaceDetailsNearbyPlaces({
    super.key,
    required this.places,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (places.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nearby Places',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 250.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: places.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final place = places[index];
              return SizedBox(
                width: 200.w,
                child: ExplorePlaceCard(place: place, hasBadge: false),
              );
            },
          ),
        ),
      ],
    );
  }
}
