import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.placeId,
    this.backgroundColor,
    this.showShadow = true,
  });

  final String placeId;
  final Color? backgroundColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final isFavorite = context.read<FavoriteCubit>().isFavorite(placeId);
        return TapScaleEffect(
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
              color: backgroundColor ?? AppColors.pureWhite,
              boxShadow: showShadow
                  ? [AppShadows.favoritePlaceButtonShadow]
                  : [],
            ),
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
                      child: Center(
                        child: Icon(Icons.favorite_rounded, color: color),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
