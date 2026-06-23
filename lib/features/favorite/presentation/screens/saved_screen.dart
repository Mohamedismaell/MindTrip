import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';
import 'package:mindtrip/features/favorite/presentation/widgets/saved_pleces_grid.dart';
import 'package:mindtrip/features/favorite/presentation/widgets/saved_empty_view.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/features/favorite/presentation/widgets/saved_category_filter_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FavoritesView();
  }
}

final _savedCategories = PlaceCategory.values;

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 33.h),
              child: Column(
                children: [
                  // Header
                  Column(
                    children: [
                      // Title
                      CustomHeadLine(
                        firstTitle: 'Saved ',
                        secondTitle: 'Places',
                        firstStyle: AppTextStyles.h5Bold.copyWith(
                          color: context.colorTheme.primary,
                        ),
                        secondStyle: AppTextStyles.h5Bold.copyWith(
                          color: context.colorTheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // Subtitle
                      Text(
                        'All the places you saved in one spot\norganized and easy to access',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h7Regular.copyWith(
                          color: context.colorTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 46.h),

                  //  Category Filter Bar
                  SavedCategoryFilterBar(
                    categories: _savedCategories,
                    selectedCategory: state.selectedCategory,
                    onCategorySelected: (category) {
                      context.read<FavoriteCubit>().selectCategory(category);
                    },
                  ),

                  SizedBox(height: 8.h),

                  //  Body
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: switch (state.status) {
                        FavoritesStatus.initial || FavoritesStatus.loading =>
                          const SavedPlacesGrid(loading: true, places: []),
                        FavoritesStatus.empty => const SavedEmptyView(
                          key: ValueKey('empty_view'),
                        ),
                        FavoritesStatus.error => AppErrorWidget(
                          key: const ValueKey('error_view'),
                          message:
                              state.errorMessage ??
                              'Something went wrong while loading your favorites',
                          onPressed: () =>
                              context.read<FavoriteCubit>().loadFavorites(),
                        ),
                        FavoritesStatus.syncing || FavoritesStatus.loaded =>
                          state.filteredPlaces.isEmpty
                              ? _EmptyCategoryView(
                                  key: ValueKey(
                                    'empty_category_${state.selectedCategory}',
                                  ),
                                  categoryName:
                                      state.selectedCategory.displayName,
                                )
                              : SavedPlacesGrid(
                                  key: ValueKey(
                                    'places_grid_${state.selectedCategory}',
                                  ),
                                  places: state.filteredPlaces,
                                ),
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _EmptyCategoryView extends StatelessWidget {
  const _EmptyCategoryView({super.key, required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list_rounded,
              size: 64.sp,
              color: context.colorTheme.onSurface.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16.h),
            Text(
              'No saved $categoryName',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
            SizedBox(height: 8.h),
            Text(
              'Try saving some places in this category\nor select a different filter.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
