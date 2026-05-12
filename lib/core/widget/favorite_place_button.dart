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
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                // size: 22.sp,
                color: isFavorite ? Colors.red : context.colorTheme.onSurface,
              ),
            ),
          ),
        );
      },
    );
  }
}
