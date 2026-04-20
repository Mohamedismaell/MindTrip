import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class RatingStars extends StatelessWidget {
  final double? rating;

  const RatingStars({super.key, this.rating});

  @override
  Widget build(BuildContext context) {
    final value = ((rating ?? 0).clamp(0, 5) * 2).round() / 2;
    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < value.floor()) {
            return Icon(
              Icons.star_rounded,
              color: AppColors.customYellow,
              size: 16.sp,
            );
          } else if (i < value && (value - i) >= 0.5) {
            return Icon(
              Icons.star_half_rounded,
              color: AppColors.customYellow,
              size: 16.sp,
            );
          } else {
            return Icon(
              Icons.star_border_rounded,
              color: AppColors.customYellow,
              size: 16.sp,
            );
          }
        }),
        SizedBox(width: 4.w),
        Text(value.toStringAsFixed(1), style: context.textTheme.labelSmall),
      ],
    );
  }
}
