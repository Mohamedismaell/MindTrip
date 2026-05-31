import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class PlaceDetailsReviews extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailsReviews({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final rating = place.rating ?? 4.8;
    final reviewCount = place.reviewCount ?? 10;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.pureBlack,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 116.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rating.toStringAsFixed(1),
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.darkGray1,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  const _StarsRow(size: 13),
                  SizedBox(height: 7.h),
                  Text(
                    'from $reviewCount visitors',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.pureBlack,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _RatingBars(rating: rating)),
          ],
        ),
        SizedBox(height: 18.h),
        const _ReviewCard(
          name: 'Elif',
          imagePath: 'assets/images/profile/deafult_user_cover.webp',
          body:
              'One of the most unforgettable places in Egypt. The view at sunrise was incredible.',
        ),
        SizedBox(height: 22.h),
        const _ReviewCard(
          name: 'Leyla',
          imagePath: 'assets/images/profile/deafult_user_cover.webp',
          body:
              'Perfect for photography. We spent almost 3 hours exploring the site.',
        ),
        SizedBox(height: 22.h),
        const _ReviewCard(
          name: 'Kerem',
          imagePath: 'assets/images/profile/deafult_user_cover.webp',
          body:
              'Very crowded at noon, so visiting early morning is definitely better.',
        ),
      ],
    );
  }
}

class _RatingBars extends StatelessWidget {
  final double rating;

  const _RatingBars({required this.rating});

  @override
  Widget build(BuildContext context) {
    final normalized = (rating / 5).clamp(0.0, 1.0);

    return Column(
      children: [
        _RatingBar(label: '5', value: normalized),
        SizedBox(height: 11.h),
        _RatingBar(label: '4', value: normalized * 0.62),
        SizedBox(height: 11.h),
        _RatingBar(label: '3', value: normalized * 0.28),
      ],
    );
  }
}

class _RatingBar extends StatelessWidget {
  final String label;
  final double value;

  const _RatingBar({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 14.w,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.pureBlack,
              fontSize: 12.sp,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              minHeight: 7.h,
              value: value,
              color: AppColors.primaryBlue,
              backgroundColor: const Color(0xFFF0F1F4),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String body;

  const _ReviewCard({
    required this.name,
    required this.imagePath,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 18.h, 16.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.mediumLightGray.withValues(alpha: 0.65),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: AppCachedImage(
              imagePath: imagePath,
              width: 54.r,
              height: 54.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.labelLarge?.copyWith(
                    color: AppColors.pureBlack,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                const _StarsRow(size: 13),
                SizedBox(height: 2.h),
                Text(
                  body,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.pureBlack,
                    fontSize: 13.sp,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StarsRow extends StatelessWidget {
  final double size;

  const _StarsRow({required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          Icons.star_rounded,
          color: AppColors.customYellow,
          size: size.r,
        ),
      ),
    );
  }
}
