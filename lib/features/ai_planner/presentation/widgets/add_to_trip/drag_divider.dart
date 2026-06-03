import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

class DragDivider extends StatelessWidget {
  const DragDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 6.h,
      decoration: BoxDecoration(
        color: context.colorTheme.outline,
        borderRadius: BorderRadius.circular(20.r),
      ),
    );
  }
}
