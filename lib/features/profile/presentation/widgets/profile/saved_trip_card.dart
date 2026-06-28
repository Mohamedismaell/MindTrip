import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/domain/entities/trip_entity.dart';
import 'package:mindtrip/core/shared/domain/entities/favorite_trip_entity.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/favorite_trip_card.dart';

class SavedTripCard extends StatelessWidget {
  const SavedTripCard({super.key, required this.data});

  final TripEntity data;

  FavoriteTripEntity get _favoriteTrip => FavoriteTripEntity(
    favoriteTripId: data.id,
    tripId: data.id,
    destination: data.title,
    startDate: data.startDate ?? DateTime.now(),
    endDate: data.endDate ?? data.startDate ?? DateTime.now(),
    durationDays: _durationDays,
    status: 'Draft',
    createdAt: DateTime.now(),
  );

  int get _durationDays {
    final start = data.startDate;
    final end = data.endDate;
    if (start == null || end == null) return 0;
    return end.difference(start).inDays + 1;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: SizedBox(
        width: 144.w,
        height: 101.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AppCachedImage(imagePath: data.imageUrl, fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15.r),
                ),
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        height: 36.h,
                        width: double.infinity,
                        color: Colors.transparent,
                      ),
                    ),

                    Container(
                      height: 36.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerLeft,
                      color: Colors.black.withValues(alpha: 0.3),
                      child: Text(
                        data.title,
                        style: context.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 6.w,
              top: 4.h,
              child: TripFavoriteBubble(trip: _favoriteTrip, small: true),
            ),
          ],
        ),
      ),
    );
  }
}
