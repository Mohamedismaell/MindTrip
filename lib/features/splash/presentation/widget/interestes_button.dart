import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/splash_cubit.dart';

class InterestesButton extends StatelessWidget {
  const InterestesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Wrap(
            spacing: 19,
            runSpacing: 14,
            children: state.categories.map((category) {
              final bool isSelected =
                  state.selectedCategories?.contains(
                    category.name,
                  ) ??
                  false;
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  side: BorderSide(
                    color: AppColors.mediumLightGray,
                    width: 1.5,
                  ),
                  backgroundColor: isSelected
                      ? AppColors.primaryBlue
                        // ignore: deprecated_member_use
                        .withOpacity(0.9)
                      : AppColors.pureWhite,
                ),
                onPressed: () {
                  context
                      .read<SplashCubit>()
                      .editSelectedCategory(category.name);
                },
                child: Text(
                  category.name,
                  style: AppTextStyles.headLine8Regular
                      .copyWith(
                        color: isSelected
                            ? AppColors.pureWhite
                            : AppColors.primaryBlue,
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
