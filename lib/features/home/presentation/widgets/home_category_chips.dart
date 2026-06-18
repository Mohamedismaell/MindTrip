import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';

class HomeCategoryChips extends StatelessWidget {
  const HomeCategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedCategory != current.selectedCategory ||
          previous.homeCategories != current.homeCategories,
      builder: (context, state) {
        final categories = state.homeCategories;
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 42.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, _) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = state.selectedCategory == category.category;

                return GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().onCategoryChanged(
                          category.category,
                        );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.colorTheme.primary
                          : context.colorTheme.surface,
                      borderRadius: BorderRadius.circular(25.r),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: context.colorTheme.outline.withValues(
                                alpha: 0.3,
                              ),
                              width: 1,
                            ),
                    ),
                    child: Center(
                      child: Text(
                        category.displayName,
                        style: isSelected
                            ? context.textTheme.bodyMedium?.copyWith(
                                color: AppColors.pureWhite,
                              )
                            : AppTextStyles.h9SemiBold.copyWith(
                                color: context.colorTheme.outline,
                              ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
