import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';

class StartPlanningButton extends StatelessWidget {
  const StartPlanningButton({super.key});
  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: () {
        context.read<AiPlannerCubit>().reset();
        context.read<ChatCubit>().clearChat();
        context.push(AppRoutes.aiPlannerFlow);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h, right: 10.w),
        width: 65.w,
        height: 65.h,
        padding: EdgeInsets.all(21.r),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          border: Border.all(color: context.colorTheme.primary),
          shape: BoxShape.circle,
          boxShadow: [AppShadows.mainElevationButton],
        ),
        child: Icon(
          Icons.add,
          fontWeight: FontWeight.bold,
          size: 24.sp,
          color: context.colorTheme.primary,
        ),
      ),
    );
  }
}
