import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.placeId});
  final String placeId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final isFavorite = context.read<FavoriteCubit>().isFavorite(placeId);
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
              padding: const EdgeInsets.all(10.0),
              child: TweenAnimationBuilder<Color?>(
                tween: ColorTween(
                  begin: context.colorTheme.onSurface,
                  end: isFavorite ? Colors.red : context.colorTheme.outline,
                ),
                duration: const Duration(milliseconds: 250),
                builder: (context, color, _) {
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 1, end: isFavorite ? 1.25 : 1),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Icon(Icons.favorite_rounded, color: color),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
