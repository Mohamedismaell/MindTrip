import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/explore/presentation/models/explore_models.dart';

class ExplorePlaceCard extends StatefulWidget {
  const ExplorePlaceCard({super.key, required this.place});

  final ExplorePlace place;

  @override
  State<ExplorePlaceCard> createState() => _ExplorePlaceCardState();
}

class _ExplorePlaceCardState extends State<ExplorePlaceCard> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.place.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [AppShadows.tourPackagesCard],
        border: Border.all(
          color: context.colorTheme.outline.withOpacity(0.15),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image section ──────────────────────────
            Expanded(
              flex: 5,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppCachedImage(imageUrl: widget.place.imageUrl),

                  // Badge
                  if (widget.place.badge != ExploreBadge.none)
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: _BadgeChip(badge: widget.place.badge),
                    ),

                  // Heart
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _isFavorite = !_isFavorite),
                      child: Container(
                        width: 30.w,
                        height: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              AppColors.pureWhite.withValues(alpha: 0.85),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          _isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 16.sp,
                          color: _isFavorite
                              ? Colors.red
                              : context.colorTheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Details section ────────────────────────
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 8.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.place.title,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colorTheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),

                    // Stars + rating
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            i < widget.place.rating.floor()
                                ? Icons.star_rounded
                                : (i < widget.place.rating
                                    ? Icons.star_half_rounded
                                    : Icons.star_border_rounded),
                            size: 14.sp,
                            color: AppColors.customYellow,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          widget.place.rating.toStringAsFixed(1),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Location + price
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: context.colorTheme.outline,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Text(
                            widget.place.location,
                            style: context.textTheme.bodySmall?.copyWith(
                              fontSize: 11.sp,
                              color: context.colorTheme.outline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          widget.place.price,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Badge Chip ──────────────────────────────────────────────
class _BadgeChip extends StatelessWidget {
  const _BadgeChip({required this.badge});

  final ExploreBadge badge;

  @override
  Widget build(BuildContext context) {
    final (String label, Color color) = switch (badge) {
      ExploreBadge.topRated => ('Top Rated', const Color(0xFF34C759)),
      ExploreBadge.popular => ('Popular', const Color(0xFFFF9500)),
      ExploreBadge.trending => ('Trending', AppColors.primaryBlue),
      ExploreBadge.none => ('', Colors.transparent),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: context.textTheme.bodySmall?.copyWith(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.pureWhite,
        ),
      ),
    );
  }
}
