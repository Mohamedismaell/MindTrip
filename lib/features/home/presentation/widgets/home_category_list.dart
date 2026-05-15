import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/enums/place_category.dart';

class HomeCategoryList extends StatefulWidget {
  const HomeCategoryList({super.key, required this.categories});

  final List<PlaceCategory> categories;

  @override
  State<HomeCategoryList> createState() => _HomeCategoryListState();
}

class _HomeCategoryListState extends State<HomeCategoryList> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories.length,
          separatorBuilder: (_, _) => SizedBox(width: 14.w),
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 8.w : 10.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: context.colorTheme.surface,
                  borderRadius: BorderRadius.circular(80.r),
                  border: Border.all(
                    color: context.colorTheme.outline.withValues(alpha: 0.5),
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
                        category.displayName,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
