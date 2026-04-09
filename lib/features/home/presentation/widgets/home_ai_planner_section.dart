import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomeAiPlannerSection extends StatelessWidget {
  const HomeAiPlannerSection({
    super.key,
    required this.plans,
  });

  final List<PlannerPreview> plans;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 430.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: plans.length,
        separatorBuilder: (_, _) => SizedBox(width: 18.w),
        itemBuilder: (context, index) {
          final plan = plans[index];
          return Container(
            width: 335.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLightGray,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: SizedBox(
                      height: 216.h,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AppCachedImage(imageUrl: plan.imageUrl),
                          Positioned(
                            top: 14.h,
                            left: 12.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLightBlue1.withOpacity(
                                  0.72,
                                ),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.auto_awesome_rounded,
                                    size: 16.sp,
                                    color: AppColors.pureWhite,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    plan.badge,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColors.pureWhite,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Text(
                    plan.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: context.colorTheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 18.h),
                  _PlannerTimeline(stops: plan.stops),
                  SizedBox(height: 22.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Create your own plan',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlannerTimeline extends StatelessWidget {
  const _PlannerTimeline({required this.stops});

  final List<PlannerStop> stops;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: stops
              .map(
                (stop) => Expanded(
                  child: Text(
                    stop.time,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      color: context.colorTheme.outline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 10.h),
        Row(
          children: List.generate(stops.length * 2 - 1, (index) {
            if (index.isOdd) {
              return Expanded(
                child: Container(
                  height: 2.h,
                  color: context.colorTheme.outline.withOpacity(0.45),
                ),
              );
            }

            final stopIndex = index ~/ 2;
            final isFirst = stopIndex == 0;
            return Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: isFirst
                    ? context.colorTheme.primary
                    : context.colorTheme.outline.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        SizedBox(height: 10.h),
        Row(
          children: stops
              .map(
                (stop) => Expanded(
                  child: Text(
                    stop.label,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11.sp,
                      color: context.colorTheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
