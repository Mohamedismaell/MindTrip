import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';

class FlowButton extends StatelessWidget {
  const FlowButton({super.key, required this.text, this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final canContinue = context.select(
      (AiPlannerCubit cubit) => cubit.state.canContinue,
    );
    final cubit = context.read<AiPlannerCubit>();
    final decoration = canContinue
        ? BoxDecoration(
            gradient: AppColors.blueLightGradient,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            boxShadow: [AppShadows.mainElevationButton],
          )
        : BoxDecoration(
            color: context.colorTheme.outline.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(50.r),
          );

    return Center(
      child: SizedBox(
        width: 283.w,
        child: InkWell(
          onTap: canContinue ? (onTap ?? cubit.nextPage) : null,
          borderRadius: BorderRadius.circular(50.r),
          child: Container(
            height: 52.h,
            decoration: decoration,
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.h7Bold.copyWith(
                  color: canContinue
                      ? context.colorTheme.onPrimary
                      : context.colorTheme.outline,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
