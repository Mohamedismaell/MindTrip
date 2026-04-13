import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';

class InterestChip extends StatelessWidget {
  const InterestChip({super.key, required this.data});

  final ProfileInterestData data;

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
        '${data.emoji} ${data.label}',
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorTheme.outline,
        ),
      ),
    );
  }
}
