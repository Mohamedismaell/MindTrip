import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/ai_refinement_sheet.dart';

class TripDetailsHeader extends StatelessWidget {
  final Trip trip;

  const TripDetailsHeader({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final coverAsset = trip.coverAsset;
    final isLocal = !coverAsset.startsWith('http');

    return LayoutBuilder(
      builder: (context, constraints) {
        final double percentage = (constraints.maxHeight - 120.h) / (280.h - 120.h);
        final bool isCollapsed = percentage < 0.2;

        return Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            if (isLocal)
              Image.asset(coverAsset, fit: BoxFit.cover)
            else
              Image.network(coverAsset, fit: BoxFit.cover),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.4),
                    Colors.transparent,
                    Colors.black.withValues(alpha: isCollapsed ? 0.8 : 0.6),
                  ],
                ),
              ),
            ),

            // Content
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => context.pop(),
                          ),
                        ),
                        // Actions (Edit, Share etc)
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              child: IconButton(
                                icon: const Icon(Icons.auto_awesome, color: Colors.white),
                                onPressed: () => AiRefinementSheet.show(
                                  context,
                                  trip.id,
                                  trip.chatMessages,
                                ),
                                tooltip: 'Edit with AI',
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CircleAvatar(
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              child: IconButton(
                                icon: const Icon(Icons.share_outlined, color: Colors.white),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 8.w),
                            CircleAvatar(
                              backgroundColor: Colors.white.withValues(alpha: 0.2),
                              child: IconButton(
                                icon: const Icon(Icons.more_vert, color: Colors.white),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Bottom Info
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: percentage.clamp(0.0, 1.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: context.colorTheme.primary,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'AI GENERATED',
                              style: AppTextStyles.h10Bold.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          trip.title,
                          style: AppTextStyles.h5Bold.copyWith(
                            color: Colors.white,
                            fontSize: (20.sp + (8.sp * percentage)).sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (percentage > 0.5) ...[
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white70, size: 14.sp),
                              SizedBox(width: 6.w),
                              Text(
                                _formatDates(trip),
                                style: AppTextStyles.h9Regular.copyWith(color: Colors.white70),
                              ),
                              SizedBox(width: 16.w),
                              Icon(Icons.people_outline, color: Colors.white70, size: 16.sp),
                              SizedBox(width: 6.w),
                              Text(
                                '${trip.adults + trip.children} travelers',
                                style: AppTextStyles.h9Regular.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDates(Trip trip) {
    if (trip.tripStart == null || trip.tripEnd == null) return 'Dates TBD';
    final start = DateFormat('MMM d').format(trip.tripStart!);
    final end = DateFormat('MMM d, yyyy').format(trip.tripEnd!);
    return '$start - $end';
  }
}
