import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/explore/presentation/models/explore_models.dart';

class ExploreCategoryChips extends StatefulWidget {
  const ExploreCategoryChips({super.key, required this.categories});

  final List<ExploreCategory> categories;

  @override
  State<ExploreCategoryChips> createState() => _ExploreCategoryChipsState();
}

class _ExploreCategoryChipsState extends State<ExploreCategoryChips> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.categories.indexWhere((c) => c.isSelected);
    if (_selectedIndex == -1) _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 42.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 10.w),
          itemBuilder: (context, index) {
            final category = widget.categories[index];
            final isSelected = index == _selectedIndex;

            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : context.colorTheme.surface,
                  borderRadius: BorderRadius.circular(24.r),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: context.colorTheme.outline.withOpacity(0.4),
                          width: 0.8,
                        ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isSelected) ...[
                      Text(
                        category.emoji,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      SizedBox(width: 6.w),
                    ],
                    Text(
                      category.label,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.pureWhite
                            : context.colorTheme.onSurface,
                      ),
                    ),
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
