import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/widget/planner_timeline.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomeAiPlannerSection extends StatelessWidget {
  const HomeAiPlannerSection({super.key, required this.plans});

  final List<PlannerPreview> plans;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 542.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: plans.length,
          separatorBuilder: (_, _) => SizedBox(width: 28.w),
          itemBuilder: (context, index) {
            final plan = plans[index];
            return Row(
              children: [
                Container(
                  width: 349.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightGray,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 12.w,
                          right: 12.w,
                          top: 18.h,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: SizedBox(
                            height: 216.h,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppCachedImage(imagePath: plan.imageUrl),
                                Positioned(
                                  top: 15.h,
                                  left: 11.w,
                                  child: Container(
                                    padding: EdgeInsets.all(5.w),
                                    decoration: BoxDecoration(
                                      color: AppColors.customLightBlue
                                          .withValues(alpha: 0.4),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 24.w,
                                          child: SvgPicture.asset(
                                            HomeAssets.aiStars,
                                          ),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          plan.badge,
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: AppColors.pureWhite,
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
                      ),
                      Text(
                        plan.title,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      PlannerTimeline(stops: plan.stops),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 18,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              context.push(AppRoutes.aiPlannerFlow);
                            },
                            child: Text('Create your own plan'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
