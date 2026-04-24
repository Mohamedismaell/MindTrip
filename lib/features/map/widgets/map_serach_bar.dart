import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class MapSerachBar extends StatelessWidget {
  const MapSerachBar({super.key});

  @override
  Widget build(BuildContext context) {
    //Todo enable search on place
    return Row(
      children: [
        Container(
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
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 24.sp,
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 24.sp,
                      color: context.colorTheme.onSurface,
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
            ],
          ),
        ),
      ],
    );
  }
}
