import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    final labels = ['Home', 'Favorites', 'Explore', 'Planner', 'Profile'];
    final inActiveIcons = [
      BottomNavAssets.homeOutlined,
      HomeAssets.whiteHeartIcon,
      BottomNavAssets.exploreOutlined,
      BottomNavAssets.aiStarOutlined,
      BottomNavAssets.personOutlined,
    ];
    final activeIcons = [
      BottomNavAssets.homefilled,
      //Todo: Edit heart icon later
      HomeAssets.blackHeartIcon,
      BottomNavAssets.exploreFilled,
      BottomNavAssets.aiStarFilled,
      BottomNavAssets.personFilled,
    ];
    return CurvedNavigationBar(
      height: 100.h,
      animationCurve: Curves.easeInOut,
      iconPadding: 17,
      index: currentIndex,
      buttonBackgroundColor: Colors.blueAccent,
      color: AppColors.primaryLightGray,
      backgroundColor: Colors.transparent,
      animationDuration: const Duration(milliseconds: 400),
      items: List.generate(5, (i) {
        return CurvedNavigationBarItem(
          child: SvgPicture.asset(
            i == currentIndex ? activeIcons[i] : inActiveIcons[i],
          ),
          label: i == currentIndex ? labels[i] : '',

          labelStyle: AppTextStyles.h8Medium.copyWith(
            color: context.colorTheme.primary,
          ),
        );
      }),
      onTap: (index) {
        onTap(index);
      },
    );
  }
}
