import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/ai_flow_action_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/step_heading.dart';

class BudgetStep extends StatelessWidget {
  const BudgetStep({
    super.key,
    required this.customBudgetController,
    required this.onContinue,
  });

  final TextEditingController customBudgetController;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiPlannerCubit>();
    final selectedBudget = context.select(
      (AiPlannerCubit c) => c.state.selectedBudget,
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StepHeading(
                title: 'What is your budget?',
                subtitle: 'this is the total budget for the entire group',
                icon: Icons.payments_rounded,
              ),
              SizedBox(height: 24.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AiPlannerMockData.budgetTiers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.8,
                ),
                itemBuilder: (context, index) {
                  final budget = AiPlannerMockData.budgetTiers[index];

                  return _BudgetTile(
                    budget: budget,
                    selected: selectedBudget == budget,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      customBudgetController.clear();
                      cubit.selectBudget(budget);
                    },
                  );
                },
              ),
              SizedBox(height: 6.h),
              Text(
                'OR',
                style: AppTextStyles.h7Bold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: customBudgetController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: cubit.updateCustomBudget,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your custom amount',
                  hintStyle: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorTheme.outline,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: context.colorTheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(color: context.colorTheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: BorderSide(
                      color: context.colorTheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              AiFlowActionButton(text: 'Continue', onTap: onContinue),
              SizedBox(height: 24.h),
              Center(
                child: AiHint(
                  message: 'Need help estimating your budget?',
                  actionMessage: ' Ask AI',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BudgetTile extends StatelessWidget {
  const _BudgetTile({
    required this.budget,
    required this.selected,
    required this.onTap,
  });

  final BudgetTierModel budget;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? context.colorTheme.primary
        : context.colorTheme.outline.withValues(alpha: 0.7);
    return TapScaleEffect(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.5.h),
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: color, width: selected ? 1.5.w : 0.8.w),
          boxShadow: [AppShadows.budgetCardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              budget.title,
              style: AppTextStyles.h8Medium.copyWith(
                color: context.colorTheme.onSurface,
              ),
              maxLines: 1,
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: Text(
                'EGP ${budget.amount}',
                style: AppTextStyles.h8Medium.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
