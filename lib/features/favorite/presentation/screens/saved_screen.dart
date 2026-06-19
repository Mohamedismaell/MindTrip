import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/features/places/domain/entity/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_place_card.dart';
import 'package:mindtrip/features/favorite/cubit/saved_places_cubit.dart';
import 'package:mindtrip/features/favorite/presentation/widgets/saved_category_filter_bar.dart';

//Todo handle skelton effect while loading and the fail widget (All listner need check )
class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SavedPlacesCubit>()..loadFavoritePlaces(),
      child: const _FavoritesView(),
    );
  }
}

const _savedCategories = [
  //  PlaceCategory.hotel,
  // PlaceCategory.trip,
  // PlaceCategory.activity,
  // PlaceCategory.restaurant,
  // PlaceCategory.beach,
  // PlaceCategory.diving,
  // PlaceCategory.heritage,
  PlaceCategory.all,
  PlaceCategory.food,
  PlaceCategory.cafes,
  PlaceCategory.historicalSites,
  PlaceCategory.beaches,
  PlaceCategory.nature,
  PlaceCategory.entertainment,
  PlaceCategory.shopping,
  PlaceCategory.artsCulture,
];

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SavedPlacesCubit, FavoritesScreenState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 33.h),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
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
                      context.read<SavedPlacesCubit>().selectCategory(category);
                    },
                  ),

                  SizedBox(height: 8.h),

                  //  Body
                  Expanded(
                    child: switch (state.placesStatus) {
                      FavoritesTabStatus.initial ||
                      FavoritesTabStatus.loading => const _LoadingView(),
                      FavoritesTabStatus.empty => const _EmptyView(),
                      FavoritesTabStatus.error => _ErrorView(
                        message: state.errorMessage,
                        onRetry: () => context
                            .read<SavedPlacesCubit>()
                            .loadFavoritePlaces(),
                      ),
                      FavoritesTabStatus.loaded =>
                        state.filteredPlaces.isEmpty
                            ? _EmptyCategoryView(
                                categoryName:
                                    state.selectedCategory.displayName,
                              )
                            : _PlacesGrid(places: state.filteredPlaces),
                    },
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

class _PlacesGrid extends StatelessWidget {
  const _PlacesGrid({required this.places});

  final List<PlaceEntity> places;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 30.h,
        crossAxisSpacing: 21.w,
        childAspectRatio: 0.65,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return ExplorePlaceCard(
          place: place,
          hasBadge: false,
          heroPrefix: 'saved',
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              size: 80.sp,
              color: context.colorTheme.onSurface.withValues(alpha: 0.3),
            ),
            SizedBox(height: 16.h),
            Text('No favorites yet', style: context.textTheme.titleLarge),
            SizedBox(height: 8.h),
            Text(
              'Start exploring and tap the heart icon\nto save places you love.',
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

class _EmptyCategoryView extends StatelessWidget {
  const _EmptyCategoryView({required this.categoryName});

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
            Text('No saved $categoryName', style: context.textTheme.titleLarge),
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

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({this.message, required this.onRetry});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64.sp,
              color: Colors.red.withValues(alpha: 0.7),
            ),
            SizedBox(height: 16.h),
            Text(
              message ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
