import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/models/interest_categories.dart';
import '../../../../core/theme/app_colors.dart';

class InterestesButton extends StatelessWidget {
  const InterestesButton({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> categories = InterestCategories.categories;
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Wrap(
            spacing: 19.w,
            runSpacing: 14.h,
            children: categories.map((category) {
              final bool isSelected =
                  state.selectedCategories?.contains(category) ?? false;
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
                  context.read<OnboardingCubit>().editSelectedCategory(
                    category,
                  );
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
        );
      },
    );
  }
}
