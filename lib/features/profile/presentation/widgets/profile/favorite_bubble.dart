import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';

class FavoriteBubble extends StatelessWidget {
  const FavoriteBubble({super.key, required this.placeId, this.small = false});

  final String placeId;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final size = small ? 24.w : 31.w;

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
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.35),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: small ? 16.sp : 18.sp,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
