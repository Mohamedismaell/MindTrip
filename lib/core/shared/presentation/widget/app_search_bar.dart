import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.hintText = 'Search...',
    this.onTap,
    this.onVoiceTap,
    this.leadingIcon = Icons.search_rounded,
    this.trailingIcon = Icons.mic_rounded,
    this.showVoiceButton = true,
    this.enabled = true,
    this.heroTag,
  });

  final String hintText;
  final VoidCallback? onTap;
  final VoidCallback? onVoiceTap;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final bool showVoiceButton;
  final bool enabled;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    Widget searchBar = Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: context.colorTheme.surface,
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: context.colorTheme.outline.withValues(alpha: 0.45),
                width: 0.8,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  leadingIcon,
                  size: 20.sp,
                  color: context.colorTheme.outline,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    hintText,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                      color: context.colorTheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showVoiceButton) ...[
          12.horizontalSpace,
          GestureDetector(
            onTap: onVoiceTap,
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.blueLightGradient,
              ),
              alignment: Alignment.center,
              child: Icon(trailingIcon, color: AppColors.pureWhite),
            ),
          ),
        ],
      ],
    );

    if (heroTag != null) {
      searchBar = Hero(
        tag: heroTag!,
        child: Material(color: Colors.transparent, child: searchBar),
      );
    }

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AbsorbPointer(absorbing: true, child: searchBar),
    );
  }
}
