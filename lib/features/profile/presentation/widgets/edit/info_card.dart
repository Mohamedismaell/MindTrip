import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key, required this.rows});

  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryLightGray,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: List.generate(rows.length, (index) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
                child: rows[index],
              ),
              if (index != rows.length - 1)
                Container(
                  height: 0.5,
                  color: context.colorTheme.outline.withValues(alpha: 0.35),
                ),
            ],
          );
        }),
      ),
    );
  }
}
