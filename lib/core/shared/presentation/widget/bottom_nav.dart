import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return _CustomBottomNav(
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  const _CustomBottomNav({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItemData(icon: Icons.home_rounded, label: 'Home'),
    _NavItemData(icon: Icons.favorite_border_rounded, label: 'Saved'),
    _NavItemData(icon: Icons.explore_outlined, label: 'Explore'),
    _NavItemData(icon: Icons.auto_awesome_outlined, label: 'AI'),
    _NavItemData(icon: Icons.person_outline_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108.h,
      color: AppColors.primaryLightGray,
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 10.h, 18.w, 18.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            return _NavIcon(
              label: item.label,
              icon: item.icon,
              isActive: currentIndex == index,
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? context.colorTheme.primary
        : context.colorTheme.onSurfaceVariant;
    final normalizedLabel = label.toLowerCase();

    return GestureDetector(
      key: Key('bottom-nav-$normalizedLabel-${isActive ? 'active' : 'inactive'}'),
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                color: isActive
                    ? context.colorTheme.primary.withOpacity(0.16)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(18.r),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 23.sp,
                color: color,
              ),
            ),
            SizedBox(height: 6.h),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              opacity: isActive ? 1 : 0.55,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: isActive ? 12.sp : 11.sp,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;
}
