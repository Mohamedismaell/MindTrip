//! need to get the full heart and replace it while tapping
//* later connect iot with the real data with cubit
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class CircleIcon extends StatefulWidget {
  const CircleIcon({
    super.key,
    required this.icon,
    required this.size,
    required this.isClickable,
    this.boxColor,
  });

  final String icon;
  final double size;
  final bool isClickable;
  final Color? boxColor;
  @override
  State<CircleIcon> createState() => CircleIconState();
}

//! need to get the full heart and replace it while tapping
//* later connect iot with the real data with cubit
class CircleIconState extends State<CircleIcon> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.boxColor ?? AppColors.pureWhite.withValues(alpha: 0.3),
      ),
      padding: EdgeInsets.all(12.r),
      child: InkWell(
        onTap: () => widget.isClickable
            ? setState(() {
                isActive = !isActive;
              })
            : null,
        child: SizedBox(
          width: widget.size.w,
          height: widget.size.h,
          child: SvgPicture.asset(
            widget.icon,
            colorFilter: ColorFilter.mode(
              isActive ? Colors.red : context.colorTheme.onSurface,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
