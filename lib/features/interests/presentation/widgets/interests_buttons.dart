import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';

class InterestsButtons extends StatelessWidget {
  const InterestsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = InterestCategories.categories;
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (prev, curr) => prev.interests != curr.interests,
      builder: (context, state) {
        return SingleChildScrollView(
          child: Wrap(
            spacing: 19.w,
            runSpacing: 14.h,
            children: categories.map((category) {
              final bool isSelected =
                  state.interests?.contains(category) ?? false;
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
                  context.read<UserCubit>().editSelectedCategory(category);
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
