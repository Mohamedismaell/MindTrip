import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';

class CounterRow extends StatelessWidget {
  const CounterRow({
    super.key,
    required this.label,
    required this.value,
    required this.onDecrease,
    required this.onIncrease,
    this.showDivider = false,
  });

  final String label;
  final int value;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 22.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: AppTextStyles.h7Medium.copyWith(
                  color: context.colorTheme.onSurface,
                ),
              ),
              const Spacer(),
              Container(
                width: 126.w,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  border: Border.all(
                    color: context.colorTheme.outline,
                    width: 1.w,
                  ),
                ),
                child: Row(
                  children: [
                    _CounterAction(label: '-', onTap: onDecrease),
                    Expanded(
                      child: Center(
                        child: Text(
                          '$value',
                          style: AppTextStyles.h8Medium.copyWith(
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                    _CounterAction(label: '+', onTap: onIncrease),
                  ],
                ),
              ),
            ],
          ),
          if (showDivider) ...[
            SizedBox(height: 22.h),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: context.colorTheme.outline.withValues(alpha: 0.45),
            ),
          ],
        ],
      ),
    );
  }
}

class _CounterAction extends StatelessWidget {
  const _CounterAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: SizedBox(
        width: 34.w,
        height: 45.h,
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.h8Medium.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
