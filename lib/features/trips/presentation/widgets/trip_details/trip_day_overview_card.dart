import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/day_plan_entity.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/day_image_carousel.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/day_meta_row.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/day_timeline.dart';

class TripDayOverviewCard extends StatefulWidget {
  const TripDayOverviewCard({
    super.key,
    required this.dayEntity,
    required this.dayNumber,
    required this.tripCoverAsset,
    required this.isExpanded,
    required this.onToggle,
    required this.onRefine,
    required this.tripStatus,
  });

  final DayPlanEntity dayEntity;
  final int dayNumber;
  final String tripCoverAsset;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onRefine;
  final TripStatus tripStatus;

  @override
  State<TripDayOverviewCard> createState() => _TripDayOverviewCardState();
}

class _TripDayOverviewCardState extends State<TripDayOverviewCard> {
  @override
  void didUpdateWidget(covariant TripDayOverviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isExpanded && widget.isExpanded) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!mounted) return;
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: 0.1,
        );
      });
    }
  }

  List<String> get _imageUrls {
    return widget.dayEntity.allPlaces
        .expand((place) => place.imageUrls)
        .where((url) => url.isNotEmpty)
        .toSet()
        .toList();
  }

  List<PlaceCategory> get _categories {
    return widget.dayEntity.allPlaces
        .map((place) => place.category)
        .toSet()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.colorTheme.outline, width: 1.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DayImageCarousel(
              imageUrls: _imageUrls,
              fallbackAsset: widget.tripCoverAsset,
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DayHeader(
                    dayNumber: widget.dayNumber,
                    tripStatus: widget.tripStatus,
                    onRefine: widget.onRefine,
                  ),
                  SizedBox(height: 14.h),
                  DayMetaRow(
                    placesCount: widget.dayEntity.allPlaces.length,
                    totalDayCost: widget.dayEntity.totalCost,
                  ),
                  SizedBox(height: 10.h),
                  _TagWrap(tags: _categories),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: child,
                        ),
                      );
                    },
                    child: widget.isExpanded
                        ? Padding(
                            key: const ValueKey('timeline'),
                            padding: EdgeInsets.only(top: 24.h),
                            child: DayTimeline(dayEntity: widget.dayEntity),
                          )
                        : const SizedBox(key: ValueKey('empty')),
                  ),
                  SizedBox(height: 24.h),
                  CustomOutlinedButton(
                    text: widget.isExpanded ? 'View less' : 'View',
                    actionIcon: widget.isExpanded
                        ? Icons.expand_less
                        : Icons.chevron_right,
                    onPressed: widget.onToggle,
                    color: context.colorTheme.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  const _DayHeader({
    required this.dayNumber,
    required this.tripStatus,
    required this.onRefine,
  });

  final int dayNumber;
  final TripStatus tripStatus;
  final VoidCallback onRefine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Day $dayNumber', style: AppTextStyles.h6Bold),
        const Spacer(),
        if (tripStatus == TripStatus.draft)
          TapScaleEffect(
            enableOverlay: false,
            borderRadius: BorderRadius.circular(8.r),
            onTap: onRefine,
            child: Row(
              children: [
                SvgPicture.asset(
                  ProfileAssets.editIcon,
                  width: 22.sp,
                  colorFilter: ColorFilter.mode(
                    context.colorTheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'Edit with AI',
                  style: AppTextStyles.h7Bold.copyWith(
                    color: context.colorTheme.primary,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _TagWrap extends StatelessWidget {
  const _TagWrap({required this.tags});

  final List<PlaceCategory> tags;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: tags.map((category) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: category.backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            category.displayName,
            style: AppTextStyles.h10Regular.copyWith(color: category.color),
          ),
        );
      }).toList(),
    );
  }
}
