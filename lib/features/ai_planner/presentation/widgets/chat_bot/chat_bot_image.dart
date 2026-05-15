import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

class ChatBotImage extends StatelessWidget {
  const ChatBotImage({
    super.key,
    required this.width,
    required this.height,
    required this.isButton,
  });
  final double width;
  final double height;
  final bool isButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isButton
          ? EdgeInsets.only(bottom: 20.h, right: 10.w)
          : EdgeInsets.zero,
      width: width.w,
      height: height.h,
      padding: isButton ? EdgeInsets.all(10.r) : EdgeInsets.all(6.r),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        shape: BoxShape.circle,
        border: Border.all(color: context.colorTheme.primary, width: 1.3.w),
        boxShadow: [AppShadows.aiplannerShadow],
      ),
      child: SvgPicture.asset(AiPlannerAssets.chatFaceIcon, fit: BoxFit.fill),
    );
  }
}
