import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class MapSearchBar extends StatelessWidget {
  const MapSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
          tag: 'map_search_bar',
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                boxShadow: [AppShadows.mainElevationButton],
                color: context.colorTheme.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: context.colorTheme.outline.withValues(alpha: 0.45),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  TapScaleEffect(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryLightGray,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 24.sp,
                        color: context.colorTheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  TapScaleEffect(
                    onTap: () {
                      context.push(AppRoutes.mapSearch);
                    },
                    borderRadius: BorderRadius.circular(30.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 24.sp,
                            color: context.colorTheme.outline,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            'Looking for a place ...',
                            textAlign: TextAlign.left,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorTheme.outline,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
      ],
    );
  }
}
