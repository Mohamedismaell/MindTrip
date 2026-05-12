import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class SavedCategoryFilterBar extends StatelessWidget {
  const SavedCategoryFilterBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<PlaceCategory> categories;
  final PlaceCategory selectedCategory;
  final ValueChanged<PlaceCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 24.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          final selectedTextStyle = AppTextStyles.h8Bold.copyWith(
            color: context.colorTheme.primary,
          );
          final unSeletectedTextStyle = AppTextStyles.h8Regular.copyWith(
            color: context.colorTheme.outline,
          );
          return GestureDetector(
            onTap: () => onCategorySelected(category),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Label
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: isSelected
                        ? selectedTextStyle
                        : unSeletectedTextStyle,
                    child: Text(category.displayName),
                  ),

                  SizedBox(height: 6.h),

                  AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: isSelected ? 1.0 : 0.0,
                    child: Container(
                      height: 2.5.h,
                      decoration: BoxDecoration(
                        color: context.colorTheme.primary,
                        borderRadius: BorderRadius.circular(2.r),
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
