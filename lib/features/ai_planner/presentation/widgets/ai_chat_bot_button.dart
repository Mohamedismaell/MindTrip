import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_assets.dart';

//! no functionallity yet
class AiChatBotButton extends StatelessWidget {
  const AiChatBotButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h, right: 10.w),
      width: 62.w,
      height: 62.h,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        shape: BoxShape.circle,
        border: Border.all(color: context.colorTheme.primary),
        boxShadow: [AppShadows.aiplannerShadow],
      ),
      child: SvgPicture.asset(
        AiPlannerAssets.chatFaceIcon,
        fit: BoxFit.contain,
      ),
    );
  }
}
