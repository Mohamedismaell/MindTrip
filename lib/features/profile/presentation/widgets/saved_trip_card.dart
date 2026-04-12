import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/widgets/favorite_bubble.dart';

class SavedTripCard extends StatelessWidget {
  const SavedTripCard({super.key, required this.data});

  final ProfileTripData data;

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
            AppCachedImage(imageUrl: data.imageUrl, fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 36.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.centerLeft,
                child: Text(
                  data.title,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 6.w,
              top: 4.h,
              child: FavoriteBubble(isFavorite: data.isFavorite, small: true),
            ),
          ],
        ),
      ),
    );
  }
}
