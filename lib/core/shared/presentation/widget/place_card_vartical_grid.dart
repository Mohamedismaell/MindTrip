import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/domain/entities/location_entity.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/presentation/widget/rating_stars.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/shared/presentation/widget/favorite_place_button.dart';

import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlaceCardVarticalGrid extends StatefulWidget {
  const PlaceCardVarticalGrid({
    super.key,
    required this.place,
    required this.hasBadge,
    this.heroPrefix = 'explore',
  });

  final PlaceEntity place;
  final bool hasBadge;
  final String heroPrefix;

  @override
  State<PlaceCardVarticalGrid> createState() => _PlaceCardVarticalGridState();
}

class _PlaceCardVarticalGridState extends State<PlaceCardVarticalGrid> {
  bool _removing = false;

  Future<void> _onFavoritePressed() async {
    final cubit = context.read<FavoriteCubit>();
    final isFavorite = cubit.isFavorite(widget.place.id);
    final isSavedScreen = widget.heroPrefix == 'saved';

    if (isSavedScreen && isFavorite) {
      setState(() => _removing = true);
      await Future.delayed(const Duration(milliseconds: 220));
    }

    if (mounted) {
      cubit.toggleFavorite(
        placeId: widget.place.id,
        isFavorite: !isFavorite,
        place: widget.place,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoriteCubit>().isFavorite(
      widget.place.id,
    );

    return AnimatedSlide(
      offset: _removing ? const Offset(0, -0.03) : Offset.zero,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
      child: AnimatedScale(
        scale: _removing ? 0.92 : 1,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOutCubic,
        child: AnimatedOpacity(
          opacity: _removing ? 0 : 1,
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOut,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(15.r),
              boxShadow: [AppShadows.tourPackagesCard],
              border: Border.all(color: context.colorTheme.outline, width: 0.5),
            ),
            child: TapScaleEffect(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              onTap: () {
                context.push(
                  '${AppRoutes.placeDetails}?placeId=${widget.place.id}&heroTag=${widget.heroPrefix}_${widget.place.id}',
                  extra: widget.place,
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image section
                    Expanded(
                      flex: 5,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(22.r),
                              topRight: Radius.circular(60.r),
                              bottomLeft: Radius.circular(12.r),
                              bottomRight: Radius.circular(12.r),
                            ),
                            child:
                                Skeletonizer.maybeOf(context)?.enabled ?? false
                                ? AppCachedImage(
                                    imagePath:
                                        widget.place.imageUrls?.first ?? '',
                                  )
                                : Hero(
                                    tag:
                                        '${widget.heroPrefix}_${widget.place.id}',
                                    child: AppCachedImage(
                                      imagePath:
                                          widget.place.imageUrls?.first ?? '',
                                    ),
                                  ),
                          ),
                          Positioned(
                            top: 0.h,
                            right: 0.w,
                            child: FavoriteButton(
                              isFavorite: isFavorite,
                              onTap: _onFavoritePressed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    _buildCardInfo(context, widget.place),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(BuildContext context, PlaceEntity place) {
    return Expanded(
      flex: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            place.name,
            style: AppTextStyles.h9SemiBold.copyWith(
              color: context.colorTheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.h),

          Expanded(
            child: switch (place.category) {
              PlaceCategory.hotels => _HotelInfo(place: place),
              PlaceCategory.food ||
              PlaceCategory.cafes => _DiningInfo(place: place),
              _ => _DiningInfo(place: place),
            },
          ),
        ],
      ),
    );
  }
}

class _HotelInfo extends StatelessWidget {
  const _HotelInfo({required this.place});
  final PlaceEntity place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LocationRow(location: place.location),
        const Spacer(),
        Row(
          children: [
            Text(
              place.price != null
                  ? '\$ ${place.price!.toStringAsFixed(0)}'
                  : '\$ --',
              style: AppTextStyles.h9Bold.copyWith(
                color: AppColors.customgreeen,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '/night',
              style: AppTextStyles.h10Regular.copyWith(
                color: context.colorTheme.onSurfaceVariant.withValues(
                  alpha: 0.6,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DiningInfo extends StatelessWidget {
  const _DiningInfo({required this.place});
  final PlaceEntity place;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LocationRow(location: place.location),
        const Spacer(),
        RatingStars(
          rating: place.rating,
          size: 16.sp,
          showText: true,
          text: (place.rating ?? 0).toString(),
          style: AppTextStyles.h9Medium.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          place.price != null
              ? 'EGP ${place.price!.toStringAsFixed(0)} AVG'
              : 'EGP --',
          style: AppTextStyles.h10Bold.copyWith(color: AppColors.customgreeen),
        ),
      ],
    );
  }
}

// class _GenericInfo extends StatelessWidget {
//   const _GenericInfo({required this.place});
//   final PlaceEntity place;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RatingStars(
//           rating: place.rating,
//           size: 16.sp,
//           showText: true,
//           style: AppTextStyles.h9Medium.copyWith(
//             color: context.colorTheme.onSurfaceVariant,
//           ),
//         ),
//         const Spacer(),
//         _LocationRow(location: place.location),
//       ],
//     );
//   }
// }

class _LocationRow extends StatelessWidget {
  const _LocationRow({required this.location});
  final LocationEntity location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 14.w,
          height: 14.h,
          child: SvgPicture.asset(
            HomeAssets.locationIcon,
            colorFilter: ColorFilter.mode(
              context.colorTheme.onSurfaceVariant,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            location.cityEn != '' ? location.cityEn : location.address,
            style: AppTextStyles.h10Medium.copyWith(
              color: context.colorTheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
