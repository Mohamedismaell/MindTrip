import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttproj/features/splash/presentation/cubit/splash_cubit.dart';

import '../../../../../core/routes/navigation_helper.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widget/app_button.dart';
import '../../../../../utility.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() =>
      _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                left: 26.5,
                right: 26.5,
                top: 151.5,
                bottom: 92.5,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What are your interests?',
                        style: AppTextStyles.headLine5Medium
                            .copyWith(
                              color: AppColors.darkGray1,
                            ),
                      ),
                      addVertical(8),
                      Text(
                        'You can select multiple choices',
                        style: AppTextStyles
                            .headLine8Regular
                            .copyWith(
                              color:
                                  AppColors.mediumLightGray,
                            ),
                      ),
                      addVertical(34),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 19,
                        runSpacing: 14,
                        children: state.categories.map((
                          category,
                        ) {
                          final bool isSelected =
                              state.selectedCategories
                                  ?.contains(
                                    category.name,
                                  ) ??
                              false;
                          return OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 14,
                                  ),
                              side: BorderSide(
                                color: AppColors
                                    .mediumLightGray,
                                width: 1.5,
                              ),
                              backgroundColor: isSelected
                                  ? AppColors.primaryBlue
                                        .withOpacity(0.9)
                                  : AppColors.pureWhite,
                            ),
                            onPressed: () {
                              context
                                  .read<SplashCubit>()
                                  .editSelectedCategory(
                                    category.name,
                                  );
                            },
                            child: Text(
                              category.name,
                              style: AppTextStyles
                                  .headLine8Regular
                                  .copyWith(
                                    color: isSelected
                                        ? AppColors
                                              .pureWhite
                                        : AppColors
                                              .primaryBlue,
                                  ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  addVertical(34),
                  AppButton(
                    button: TextButton(
                      onPressed: () {
                        NavigationHelper.goToAuth(context);
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
