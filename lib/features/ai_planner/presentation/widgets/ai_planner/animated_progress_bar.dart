import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 14.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: AppColors.primaryShadow),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: progress),
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorTheme.primary,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
