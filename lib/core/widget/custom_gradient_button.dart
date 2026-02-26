import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ttproj/core/theme/app_gradients.dart';
import 'package:ttproj/core/theme/app_shadows.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 73.w),
      decoration: BoxDecoration(
        // color: Colors.amberAccent,
        gradient: AppGradients.mainBlueGradient,
        boxShadow: [AppShadows.mainElevationButton],
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: child,
    );
  }
}
