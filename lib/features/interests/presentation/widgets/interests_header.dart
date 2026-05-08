import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class InterestsHeader extends StatelessWidget {
  const InterestsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.arrow_back, size: 24.sp),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What are your interests?',
              style: context.textTheme.headlineMedium,
            ),
            SizedBox(height: 8.h),
            Text(
              'You can select multiple choices',
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 34.h),
          ],
        ),
      ],
    );
  }
}
