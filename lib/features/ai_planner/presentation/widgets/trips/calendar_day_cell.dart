import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

enum DayCellState { normal, start, middle, end, today }

class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({super.key, required this.date, required this.state});

  final DateTime date;
  final DayCellState state;

  @override
  Widget build(BuildContext context) {
    final theme = context.colorTheme;

    // For padding inside grid
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Stack(
        children: [
          // Background highlight for ranges (start, middle, end)
          if (state == DayCellState.start ||
              state == DayCellState.middle ||
              state == DayCellState.end)
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: state == DayCellState.start
                          ? Colors.transparent
                          : theme.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: state == DayCellState.end
                          ? Colors.transparent
                          : theme.primary.withValues(alpha: 0.15),
                    ),
                  ),
                ],
              ),
            ),

          // The actual day circle
          Center(
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getCircleColor(theme),
                border:
                    state == DayCellState.today &&
                        _getCircleColor(theme) == Colors.transparent
                    ? Border.all(color: theme.primary, width: 1.5)
                    : null,
              ),
              child: Center(
                child: Text(
                  '${date.day}',
                  style: AppTextStyles.h10Medium.copyWith(
                    color: _getTextColor(theme),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCircleColor(ColorScheme theme) {
    switch (state) {
      case DayCellState.start:
      case DayCellState.end:
        return theme.primary;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor(ColorScheme theme) {
    switch (state) {
      case DayCellState.start:
      case DayCellState.end:
        return Colors.white;
      case DayCellState.today:
        return theme.primary;
      case DayCellState.middle:
        return theme.primary;
      case DayCellState.normal:
        return theme.onSurface;
    }
  }
}
