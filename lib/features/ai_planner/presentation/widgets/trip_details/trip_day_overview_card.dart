import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_day.dart';

class TripDayOverviewCard extends StatefulWidget {
  const TripDayOverviewCard({
    super.key,
    required this.day,
    required this.tripCoverAsset,
    required this.isExpanded,
    required this.onToggle,
    required this.onRefine,
  });

  final TripDay day;
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
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: context.colorTheme.outline, width: 1.2),
        ),
        child: widget.isExpanded
            ? _buildExpanded(context)
            : _buildCollapsed(context),
      ),
    );
  }

  Widget _buildCollapsed(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: SizedBox(
            width: 106.w,
            height: 200.h,
            // height: double.infinity,
            child: AppCachedImage(imagePath: _cardImageUrl),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Day ${widget.day.dayNumber}', style: AppTextStyles.h8Bold),
              SizedBox(height: 12.h),
              Text(
                widget.day.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h9Bold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              _DayMetaRow(day: widget.day),
              SizedBox(height: 12.h),
              //Todo: the tags should be the catgory of the places
              _TagWrap(tags: widget.day.tags.take(3).toList()),
              SizedBox(height: 12.h),
              CustomOtlinedButton(
                key: Key('trip-day-${widget.day.dayNumber}-view-button'),
                text: 'View',
                actionIcon: Icons.chevron_right,
                onPressed: widget.onToggle,
                color: context.colorTheme.primary,
                textStyle: AppTextStyles.h8Bold.copyWith(
                  color: context.colorTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExpanded(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: SizedBox(
              width: double.infinity,
              height: 202.h,

              child: AppCachedImage(imagePath: _cardImageUrl),
            ),
          ),

          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w, right: 10.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      'Day ${widget.day.dayNumber}',
                      style: AppTextStyles.h6Bold,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        SvgPicture.asset(
                          ProfileAssets.editIcon,
                          width: 24.sp,
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Edit with AI',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.h7Bold.copyWith(
                            color: context.colorTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18.h),
                _DayTimeline(day: widget.day),
                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: CustomOtlinedButton(
                    key: Key(
                      'trip-day-${widget.day.dayNumber}-view-less-button',
                    ),
                    text: 'View less',
                    onPressed: widget.onToggle,
                    color: context.colorTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? get _cardImageUrl {
    if (widget.day.coverImageUrl.isNotEmpty) return widget.day.coverImageUrl;
    for (final slot in widget.day.timeSlots) {
      for (final place in slot.places) {
        final url = place.imageUrls?.firstOrNull;
        if (url != null && url.isNotEmpty) return url;
      }
    }
    return null;
  }
}

class _DayMetaRow extends StatelessWidget {
  const _DayMetaRow({required this.day});

  final TripDay day;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _IconText(
          icon: Icons.location_on_outlined,
          text: '${day.stopCount} stops',
        ),
        const _IconText(icon: Icons.schedule_outlined, text: 'Full day'),
        _CostChip(cost: day.estimatedCost),
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
        Icon(icon, size: 14.sp, color: context.colorTheme.outline),
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

  final List<String> tags;

  static const _colors = [
    (Color(0xFFF1EAFD), Color(0xFF9A89D0)),
    (Color(0xFFC4E0F9), Color(0xFF5596FE)),
    (Color(0xFFFCE8D1), Color(0xFFD8906A)),
    (Color(0xFFD7F1F3), Color(0xFF4F919E)),
    (Color(0xFFEEF7E9), Color(0xFF57925F)),
  ];

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        for (var i = 0; i < tags.length; i++)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: _colors[i % _colors.length].$1,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              tags[i],
              style: AppTextStyles.h10Regular.copyWith(
                color: _colors[i % _colors.length].$2,
              ),
            ),
          ),
      ],
    );
  }
}

class _DayTimeline extends StatelessWidget {
  const _DayTimeline({required this.day});

  final TripDay day;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < day.timeSlots.length; i++)
          _TimelineSlot(
            slot: day.timeSlots[i],
            isFirst: i == 0,
            isLast: i == day.timeSlots.length - 1,
          ),
      ],
    );
  }
}

class _TimelineSlot extends StatelessWidget {
  const _TimelineSlot({
    required this.slot,
    required this.isFirst,
    required this.isLast,
  });

  final TimeSlot slot;
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
                  '${_periodLabel(slot.period)} - ${slot.title}',
                  style: AppTextStyles.h9Bold,
                ),
                SizedBox(height: 12.h),
                ...List.generate(slot.places.length, (index) {
                  final place = slot.places[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6.h, left: 10.w),
                    child: Text(
                      '- ${place.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.h9Regular.copyWith(
                        color: context.colorTheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }),
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

  String _periodLabel(DayPeriod period) {
    switch (period) {
      case DayPeriod.morning:
        return 'Morning';
      case DayPeriod.afternoon:
        return 'Afternoon';
      case DayPeriod.evening:
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
