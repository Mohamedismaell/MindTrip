import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_gradients.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';

class TripFilterTabs extends StatelessWidget {
  const TripFilterTabs({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final TripFilterTab selected;
  final ValueChanged<TripFilterTab> onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: TripFilterTab.values.map((tab) {
          final isSelected = tab == selected;
          return Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: GestureDetector(
              onTap: () => onSelect(tab),
              child: AnimatedContainer(
                key: ValueKey(tab),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 6.5.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : context.colorTheme.outline.withValues(alpha: 0.4),
                  ),
                  gradient: isSelected
                      ? AppGradients.mainBlueGradient
                      : LinearGradient(
                          colors: [
                            context.colorTheme.surface,
                            context.colorTheme.surface,
                          ],
                        ),
                ),
                child: Text(
                  tab.label,
                  style: isSelected
                      ? AppTextStyles.h8SemiBold.copyWith(
                          color: AppColors.pureWhite,
                        )
                      : context.textTheme.bodyLarge?.copyWith(
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
