import 'package:ttproj/core/theme/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

//Todo Add real SVG
class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return _CustomBottomNav(
      currentIndex: currentIndex,
      onTap: (index) => onTap(index),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  const _CustomBottomNav({required this.currentIndex, required this.onTap});
  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: context.colorTheme.surface,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 44.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavSvgIcon(
              path: 'assets/images/Vector(1).svg',
              // icon: Icons.home,
              onTap: () => onTap(0),
              isActive: currentIndex == 0,
            ),
            _NavSvgIcon(
              path: 'assets/images/Vector(2).svg',
              onTap: () => onTap(1),
              isActive: currentIndex == 1,
            ),
            _NavSvgIcon(
              path: 'assets/images/Vector(3).svg',
              // icon: Icons.bookmark_outline_sharp,
              onTap: () => onTap(2),
              isActive: currentIndex == 2,
            ),
            _NavSvgIcon(
              path: 'assets/images/Vector(4).svg',
              onTap: () => onTap(3),
              isActive: currentIndex == 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavSvgIcon extends StatelessWidget {
  const _NavSvgIcon({
    required this.onTap,
    required this.isActive,
    // ignore: unused_element_parameter
    this.path,
    // ignore: unused_element_parameter
    this.icon,
  });
  final String? path;
  final IconData? icon;
  final VoidCallback onTap;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    Color color = isActive ? context.colorTheme.primary : Colors.grey;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 180),
        key: ValueKey(isActive),
        curve: Curves.easeOut,
        scale: isActive ? 1.2.sp : 1.0.sp,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: path == null
              ? Icon(icon, size: 24.sp, color: color)
              : SvgPicture.asset(
                  path!,
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
        ),
      ),
    );
  }
}
