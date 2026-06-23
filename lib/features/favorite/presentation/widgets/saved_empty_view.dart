import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

class SavedEmptyView extends StatelessWidget {
  const SavedEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 80.sp,
              color: context.colorTheme.onSurface.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16.h),
            Text('No favorites yet', style: context.textTheme.titleLarge),
            SizedBox(height: 8.h),
            Text(
              'Start exploring and tap the heart icon\nto save places you love.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
