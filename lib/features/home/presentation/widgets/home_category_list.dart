import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/home/presentation/models/home_models.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({super.key, required this.categories});

  final List<HomeCategory> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.isSelected;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: EdgeInsets.symmetric(
              horizontal: isSelected ? 8.w : 10.w,
              vertical: 8.h,
            ),
            decoration: BoxDecoration(
              color: context.colorTheme.surface,
              borderRadius: BorderRadius.circular(80.r),
              border: Border.all(
                color: context.colorTheme.outline.withOpacity(0.5),
                width: 0.8,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colorTheme.primary
                        : AppColors.primaryLightGray,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category.emoji,
                    style: TextStyle(fontSize: isSelected ? 20.sp : 22.sp),
                  ),
                ),
                if (isSelected) ...[
                  SizedBox(width: 10.w),
                  Text(
                    category.label,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 4.w),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
