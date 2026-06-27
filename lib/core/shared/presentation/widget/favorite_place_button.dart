import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
    this.backgroundColor,
    this.showShadow = true,
  });

  final bool isFavorite;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    final inactiveColor = context.colorTheme.outline;
    final activeColor = context.colorTheme.error;

    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.pureWhite,
        boxShadow: showShadow ? [AppShadows.favoritePlaceButtonShadow] : null,
      ),
      child: TapScaleEffect(
        shape: const CircleBorder(),
        onTap: () {
          if (!isFavorite) HapticFeedback.lightImpact();
          onTap();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isFavorite)
              Container(
                    width: 15.r,
                    height: 15.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: activeColor.withValues(alpha: 0.4),
                    ),
                  )
                  .animate()
                  .scale(
                    duration: 400.ms,
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(2.2, 2.2),
                    curve: Curves.easeOutExpo,
                  )
                  .fadeOut(duration: 400.ms),
            Icon(
                  Icons.favorite_rounded,
                  size: 22.sp,
                  color: isFavorite ? activeColor : inactiveColor,
                )
                .animate(target: isFavorite ? 1 : 0)
                .scale(
                  duration: 350.ms,
                  begin: const Offset(1, 1),
                  end: const Offset(1.3, 1.3),
                  curve: Curves.elasticOut,
                )
                .tint(color: activeColor, duration: 250.ms),
          ],
        ),
      ),
    );
  }
}
