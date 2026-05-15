import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

class InterestChip extends StatelessWidget {
  const InterestChip({super.key, required this.interest});

  final String interest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: context.colorTheme.outline),
      ),
      child: Text(
        '$interest ',
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorTheme.outline,
        ),
      ),
    );
  }
}
