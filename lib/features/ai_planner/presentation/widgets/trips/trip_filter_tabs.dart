import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

enum TripFilterTab { all, completed, recentlyEdited, drafts }

extension TripFilterTabLabel on TripFilterTab {
  String get label {
    switch (this) {
      case TripFilterTab.all:
        return 'All';
      case TripFilterTab.completed:
        return 'Completed';
      case TripFilterTab.recentlyEdited:
        return 'Recent';
      case TripFilterTab.drafts:
        return 'Drafts';
    }
  }
}

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
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onSelect(tab),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colorTheme.primary
                      : context.colorTheme.surface,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? context.colorTheme.primary
                        : context.colorTheme.outline.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  tab.label,
                  style: AppTextStyles.h10Medium.copyWith(
                    color: isSelected
                        ? Colors.white
                        : context.colorTheme.onSurfaceVariant,
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
