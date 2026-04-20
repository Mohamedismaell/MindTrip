import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ExploreSectionHeader extends StatelessWidget {
  const ExploreSectionHeader({super.key, required this.title, this.count});

  final String title;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.h8SemiBold.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          if (count != null) ...[
            SizedBox(width: 6.w),
            Text(
              '($count)',
              style: AppTextStyles.h8SemiBold.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
