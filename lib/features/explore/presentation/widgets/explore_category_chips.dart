import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';

class ExploreCategoryChips extends StatelessWidget {
  const ExploreCategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      buildWhen: (previous, current) =>
          previous.selectedCategory != current.selectedCategory,
      builder: (context, state) {
        final categories = PlaceCategory.values;
        return SliverToBoxAdapter(
          child: SizedBox(
            height: 42.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: PlaceCategory.values.length,
              separatorBuilder: (_, _) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = state.selectedCategory == category;

                return TapScaleEffect(
                  onTap: () {
                    context.read<ExploreCubit>().onCategoryToggled(category);
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(category.emoji, style: TextStyle(fontSize: 16.sp)),
                        SizedBox(width: 6.w),
                        Text(
                          category.displayName,
                          style: isSelected
                              ? context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.pureWhite,
                                )
                              : AppTextStyles.h9SemiBold.copyWith(
                                  color: context.colorTheme.outline,
                                ),
                        ),
                      ],
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
