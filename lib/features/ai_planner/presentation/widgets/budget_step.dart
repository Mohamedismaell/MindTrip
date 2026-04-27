import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/budget_tier.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/budget_tile.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/flow_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/tsep_heading.dart';

class BudgetStep extends StatelessWidget {
  const BudgetStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.budgets,
    required this.selectedBudget,
    required this.customBudgetController,
    required this.onBudgetTap,
    required this.onCustomBudgetChanged,
    required this.canContinue,
    required this.onContinue,
    required this.aiHint,
  });

  final String title;
  final String subtitle;
  final List<BudgetTierModel> budgets;
  final BudgetTierModel? selectedBudget;
  final TextEditingController customBudgetController;
  final ValueChanged<BudgetTierModel> onBudgetTap;
  final ValueChanged<String> onCustomBudgetChanged;
  final bool canContinue;
  final VoidCallback onContinue;
  final String aiHint;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 6.h, bottom: 24.h),
      children: [
        StepHeading(title: title, subtitle: subtitle, icon: Icons.paid_rounded),
        SizedBox(height: 24.h),
        ...budgets.map(
          (budget) => Padding(
            padding: EdgeInsets.only(bottom: 18.h),
            child: _BudgetTile(
              budget: budget,
              selected: selectedBudget == budget,
              onTap: () => onBudgetTap(budget),
            ),
          ),
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
          onChanged: onCustomBudgetChanged,
          style: AppTextStyles.h8Regular.copyWith(
            color: context.colorTheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your custom amount',
            hintStyle: AppTextStyles.h8Regular.copyWith(
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
        FlowButton(enabled: canContinue, text: 'Continue', onTap: onContinue),
        SizedBox(height: 24.h),
        AiHint(message: aiHint, centerText: true),
      ],
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: selected
                  ? context.colorTheme.primary
                  : context.colorTheme.outline.withOpacity(0.7),
              width: selected ? 1.5.w : 0.8.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    budget.icon,
                    size: 18.sp,
                    color: selected
                        ? context.colorTheme.primary
                        : context.colorTheme.onSurface,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    budget.title,
                    style: AppTextStyles.h8Medium.copyWith(
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                '\$${budget.amount}',
                style: AppTextStyles.h8Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
