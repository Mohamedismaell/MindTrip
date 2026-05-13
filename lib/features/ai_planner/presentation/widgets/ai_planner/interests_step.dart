import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/flow_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/step_heading.dart';
import 'package:mindtrip/core/shared/models/interest_categories.dart';

class InterestsStep extends StatelessWidget {
  final ScrollController _scrollController;

  const InterestsStep({super.key, required ScrollController scrollController})
    : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StepHeading(
          title: 'What are you into?',
          subtitle: 'Select what you’d love to do on this trip.',
          icon: Icons.interests_rounded,
        ),
        SizedBox(height: 24.h),
        Interestes(scrollController: _scrollController),
        // Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 32.h, bottom: 24),
          child: FlowButton(text: 'Generate your plan'),
        ),
      ],
    );
  }
}

class Interestes extends StatelessWidget {
  final ScrollController _scrollController;

  const Interestes({super.key, required ScrollController scrollController})
    : _scrollController = scrollController;
  @override
  Widget build(BuildContext context) {
    final selectedCategories = context.select(
      (AiPlannerCubit cubit) => cubit.state.selectedInterests,
    );
    final List<String> categories = InterestCategories.categories;

    return Expanded(
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 2.w,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(right: 10.w, bottom: 30.h),
          controller: _scrollController,
          child: Wrap(
            spacing: 19.w,
            runSpacing: 14.h,
            children: categories.map((category) {
              final bool isSelected = selectedCategories.contains(category);
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 10.h,
                  ),
                  side: BorderSide(color: context.colorTheme.outline, width: 1),
                  backgroundColor: isSelected
                      ? context.colorTheme.primary
                      : AppColors.pureWhite,
                ),
                onPressed: () {
                  context.read<AiPlannerCubit>().toggleInterest(category);
                },
                child: Text(
                  category,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: isSelected
                        ? AppColors.pureWhite
                        : context.colorTheme.onSurfaceVariant,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
