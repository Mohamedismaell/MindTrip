import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/day_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart'; // For PlaceDayPeriod

class TripDayOverviewCard extends StatefulWidget {
  const TripDayOverviewCard({
    super.key,
    required this.dayEntity,
    required this.dayNumber,
    required this.tripCoverAsset,
    required this.isExpanded,
    required this.onToggle,
    required this.onRefine,
  });

  final DayPlanEntity dayEntity;
  final int dayNumber;
  final String tripCoverAsset;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onRefine;

  @override
  State<TripDayOverviewCard> createState() => _TripDayOverviewCardState();
}

class _TripDayOverviewCardState extends State<TripDayOverviewCard> {
  @override
  void didUpdateWidget(TripDayOverviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isExpanded && widget.isExpanded) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            alignment: 0.1,
          );
        }
      });
    }
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
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),

        SizedBox(height: 24.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),

              SizedBox(height: 14.h),

              _DayMetaRow(
                dayNumber: widget.dayNumber,
                placesCount: widget.dayEntity.allPlaces.length,
                totalDayCost: widget.dayEntity.totalCost,
              ),

              SizedBox(height: 10.h),

              _TagWrap(
                tags: widget.dayEntity.allPlaces
                    .map((e) => e.category)
                    .toSet()
                    .toList(),
              ),

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
                        child: _DayTimeline(dayEntity: widget.dayEntity),
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
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: SizedBox(
        width: double.infinity,
        height: 202.h,
        child: AppCachedImage(imagePath: _cardImageUrl),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Text('Day ${widget.dayNumber}', style: AppTextStyles.h6Bold),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: widget.onRefine,
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

  String? get _cardImageUrl {
    final allPlaces = widget.dayEntity.allPlaces;
    for (final place in allPlaces) {
      final url = place.imageUrls.firstOrNull;
      if (url != null && url.isNotEmpty) return url;
    }
    return null;
  }
}

class _DayMetaRow extends StatelessWidget {
  const _DayMetaRow({
    required this.dayNumber,
    required this.placesCount,
    required this.totalDayCost,
  });

  final int dayNumber;
  final int placesCount;
  final double totalDayCost;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 10.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _IconText(
          icon: Icons.location_on_outlined,
          text: '$placesCount places',
        ),
        // const _IconText(icon: Icons.schedule_outlined, text: 'Full day'),
        SizedBox(width: 10.w),
        _CostChip(cost: totalDayCost),
      ],
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20.sp, color: context.colorTheme.outline),
        SizedBox(width: 4.w),
        Text(
          text,
          style: AppTextStyles.h10Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _CostChip extends StatelessWidget {
  const _CostChip({required this.cost});

  final double cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.successGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        '~${cost.round()} EGP',
        style: AppTextStyles.h10Regular.copyWith(
          color: AppColors.customgreeen2,
        ),
      ),
    );
  }
}

class _TagWrap extends StatelessWidget {
  const _TagWrap({required this.tags});

  final List<PlaceCategory> tags;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

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

class _DayTimeline extends StatelessWidget {
  const _DayTimeline({required this.dayEntity});

  final DayPlanEntity dayEntity;

  @override
  Widget build(BuildContext context) {
    final slots = [
      if (dayEntity.morning.isNotEmpty)
        (PlaceDayPeriod.morning, 'Morning', dayEntity.morning),
      if (dayEntity.afternoon.isNotEmpty)
        (PlaceDayPeriod.afternoon, 'Afternoon', dayEntity.afternoon),
      if (dayEntity.evening.isNotEmpty)
        (PlaceDayPeriod.evening, 'Evening', dayEntity.evening),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < slots.length; i++)
          _TimelineSlot(
            period: slots[i].$1,
            title: slots[i].$2,
            places: slots[i].$3,
            isFirst: i == 0,
            isLast: i == slots.length - 1,
          ),
      ],
    );
  }
}

class _TimelineSlot extends StatelessWidget {
  const _TimelineSlot({
    required this.period,
    required this.title,
    required this.places,
    required this.isFirst,
    required this.isLast,
  });

  final PlaceDayPeriod period;
  final String title;
  final List<PlanPlaceEntity> places;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final lineColor = context.colorTheme.outline;
    final dotColor = isFirst ? context.colorTheme.primary : lineColor;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomPaint(
          painter: _TimelinePainter(
            color: lineColor,
            isLast: isLast,
            dotSize: 16.w,
            strokeWidth: 2.5.w,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 28.w, bottom: isLast ? 0 : 18.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_periodLabel(period)} - $title',
                  style: AppTextStyles.h9Bold,
                ),
                SizedBox(height: 12.h),
                BlocBuilder<TripDetailsCubit, TripDetailsState>(
                  builder: (context, state) {
                    final isInProgress =
                        state.trip?.status == TripStatus.inProgress;
                    return Column(
                      children: places.map((place) {
                        final isChecked = state.checkedPlaces.contains(
                          place.name,
                        );
                        return Padding(
                          padding: EdgeInsets.only(bottom: 6.h, left: 0),
                          child: InkWell(
                            onTap: isInProgress
                                ? () => context
                                      .read<TripDetailsCubit>()
                                      .togglePlaceChecked(place.name)
                                : null,
                            child: Row(
                              children: [
                                if (isInProgress)
                                  SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (val) => context
                                          .read<TripDetailsCubit>()
                                          .togglePlaceChecked(place.name),
                                      activeColor: context.colorTheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: Text(
                                      '•',
                                      style: AppTextStyles.h9Regular,
                                    ),
                                  ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    place.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.h9Regular.copyWith(
                                      color: isChecked
                                          ? context.colorTheme.outline
                                          : context.colorTheme.onSurfaceVariant,
                                      decoration: isChecked
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 1.w,
          top: 0,
          child: Container(
            width: 16.w,
            height: 16.w,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }

  String _periodLabel(PlaceDayPeriod period) {
    switch (period) {
      case PlaceDayPeriod.morning:
        return 'Morning';
      case PlaceDayPeriod.afternoon:
        return 'Afternoon';
      case PlaceDayPeriod.evening:
        return 'Evening';
    }
  }
}

class _TimelinePainter extends CustomPainter {
  final Color color;
  final bool isLast;
  final double dotSize;
  final double strokeWidth;

  _TimelinePainter({
    required this.color,
    required this.isLast,
    required this.dotSize,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isLast) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    final centerX = (dotSize / 2);
    canvas.drawLine(
      Offset(centerX, dotSize / 2),
      Offset(centerX, size.height + (dotSize / 2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.isLast != isLast ||
      oldDelegate.dotSize != dotSize ||
      oldDelegate.strokeWidth != strokeWidth;
}
