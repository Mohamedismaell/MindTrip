import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class RatingStars extends StatelessWidget {
  final double? rating;
  final double? size;
  final bool? showText;
  final TextStyle? style;
  const RatingStars({
    super.key,
    this.rating,
    this.size,
    this.showText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 16.sp;
    final value = ((rating ?? 0).clamp(0, 5) * 2).round() / 2;
    return Row(
      children: [
        ...List.generate(5, (i) {
          if (i < value.floor()) {
            return Icon(
              Icons.star_rounded,
              color: AppColors.customYellow,
              size: iconSize,
            );
          } else if (i < value && (value - i) >= 0.5) {
            return Icon(
              Icons.star_half_rounded,
              color: AppColors.customYellow,
              size: iconSize,
            );
          } else {
            return Icon(
              Icons.star_border_rounded,
              color: AppColors.customYellow,
              size: iconSize,
            );
          }
        }),
        SizedBox(width: 4.w),
        showText == true
            ? Text(
                value.toStringAsFixed(1),
                style: style ?? context.textTheme.labelSmall,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
