import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/explore/presentation/models/explore_models.dart';

class ExploreTabBar extends StatefulWidget {
  const ExploreTabBar({super.key, required this.tabs});

  final List<ExploreTab> tabs;

  @override
  State<ExploreTabBar> createState() => _ExploreTabBarState();
}

class _ExploreTabBarState extends State<ExploreTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.tabs.indexWhere((t) => t.isSelected);
    if (_selectedIndex == -1) _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: List.generate(widget.tabs.length, (index) {
          final tab = widget.tabs[index];
          final isActive = index == _selectedIndex;

          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = index),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(right: 28.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: context.textTheme.bodyLarge!.copyWith(
                      fontSize: 15.sp,
                      fontWeight:
                          isActive ? FontWeight.w700 : FontWeight.w400,
                      color: isActive
                          ? context.colorTheme.onSurface
                          : context.colorTheme.outline,
                    ),
                    child: Text(tab.label),
                  ),
                  SizedBox(height: 6.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2.5.h,
                    width: isActive ? 24.w : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
