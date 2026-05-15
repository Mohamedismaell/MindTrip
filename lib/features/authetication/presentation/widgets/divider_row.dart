import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Widget
///
/// [DividerRow] renders the "──── or with ────" visual separator used between
/// the main auth form and social login options.
/// ──────────────────────────────────────────────────────────────────────────────
class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(thickness: 1.sp, color: context.colorTheme.outline),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.0.w),
          child: Text(
            "or with",
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorTheme.outline,
            ),
          ),
        ),
        Expanded(
          child: Divider(thickness: 1.sp, color: context.colorTheme.outline),
        ),
      ],
    );
  }
}
