import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceDetailsImageCover extends StatelessWidget {
  final List<String>? imageUrls;
  final String placeId;
  const PlaceDetailsImageCover({
    super.key,
    this.imageUrls,
    required this.placeId,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 306.h,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.r),
              topRight: Radius.circular(28.r),
            ),
            child: Skeleton.ignore(
              child: Hero(
                tag: placeId,
                child: AppCachedImage(
                  imagePath:
                      imageUrls?.first ??
                      'assets/images/onboarding/Pyramids.webp',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Positioned(
            top: topPadding + 24.h,
            left: 22.w,
            child: _HeroIconButton(
              icon: Icons.arrow_back_rounded,
              onTap: () => context.pop(),
            ),
          ),
          Positioned(
            top: topPadding + 24.h,
            right: 22.w,
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final isFavorite = context.read<FavoriteCubit>().isFavorite(
                  placeId,
                );
                return GestureDetector(
                  onTap: () {
                    context.read<FavoriteCubit>().toggleFavorite(
                      placeId: placeId,
                      isFavorite: !isFavorite,
                    );
                  },
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.pureWhite,
                      boxShadow: [AppShadows.favoritePlaceButtonShadow],
                    ),
                    alignment: Alignment.center,
                    child: Padding(
                      //Todo check apdding again
                      padding: const EdgeInsets.all(0),
                      child: TweenAnimationBuilder<Color?>(
                        tween: ColorTween(
                          begin: context.colorTheme.onSurface,
                          end: isFavorite
                              ? context.colorTheme.error
                              : context.colorTheme.outline,
                        ),
                        duration: const Duration(milliseconds: 250),
                        builder: (context, color, _) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 1, end: isFavorite ? 1.2 : 0.8),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutBack,
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: color,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
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
    return TapScaleEffect(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          shape: BoxShape.circle,
        ),
        width: 38.r,
        height: 38.r,
        child: Icon(
          icon,
          size: 24.r,
          color: context.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
