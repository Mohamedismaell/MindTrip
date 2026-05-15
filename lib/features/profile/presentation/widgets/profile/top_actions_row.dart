import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class TopActionsRow extends StatelessWidget {
  const TopActionsRow({
    super.key,
    required this.onSettingsTap,
    required this.onMenuTap,
  });

  final VoidCallback onSettingsTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CircleActionButton(icon: Icons.settings, onTap: onSettingsTap),
        _CircleActionButton(
          icon: Icons.menu_rounded,
          iconSize: 26.sp,
          onTap: onMenuTap,
        ),
      ],
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({
    required this.icon,
    required this.onTap,
    this.iconSize,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: const BoxDecoration(
          color: AppColors.primaryLightGray,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: iconSize ?? 28.sp,
          color: context.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
