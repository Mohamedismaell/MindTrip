import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';

class PlaceDetailsImageCover extends StatelessWidget {
  final List<String>? imageUrls;

  const PlaceDetailsImageCover({super.key, this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 320.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppCachedImage(
            imagePath:
                imageUrls?.first ?? 'assets/images/onboarding/Pyramids.webp',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          // Positioned.fill(
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           AppColors.pureBlack.withValues(alpha: 0.18),
          //           Colors.transparent,
          //           AppColors.pureBlack.withValues(alpha: 0.12),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: topPadding + 18.h,
            left: 20.w,
            child: _HeroIconButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => context.pop(),
            ),
          ),
          Positioned(
            top: topPadding + 18.h,
            right: 20.w,
            child: _HeroIconButton(
              icon: Icons.favorite_border_rounded,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeroIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.pureWhite,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: AppColors.pureBlack.withValues(alpha: 0.12),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42.r,
          height: 42.r,
          child: Icon(icon, size: 24.r, color: AppColors.darkGray1),
        ),
      ),
    );
  }
}
