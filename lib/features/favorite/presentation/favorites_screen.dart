import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_place_card.dart';
import 'package:mindtrip/features/favorite/cubit/favorites_screen_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoritesScreenCubit>()..loadFavoritePlaces(),
      child: const _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites', style: context.textTheme.titleLarge),
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesScreenCubit, FavoritesScreenState>(
        builder: (context, state) {
          return switch (state.placesStatus) {
            FavoritesTabStatus.initial ||
            FavoritesTabStatus.loading => const _LoadingView(),
            FavoritesTabStatus.empty => const _EmptyView(),
            FavoritesTabStatus.error => _ErrorView(
              message: state.errorMessage,
              onRetry: () =>
                  context.read<FavoritesScreenCubit>().loadFavoritePlaces(),
            ),
            FavoritesTabStatus.loaded => _PlacesGrid(places: state.places),
          };
        },
      ),
    );
  }
}

class _PlacesGrid extends StatelessWidget {
  const _PlacesGrid({required this.places});

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 0.65,
      ),
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];
        return ExplorePlaceCard(place: place);
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
            Text('No favorites yet', style: context.textTheme.titleMedium),
            SizedBox(height: 8.h),
            Text(
              'Start exploring and tap the heart icon\nto save places you love.',
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorTheme.onSurface.withValues(alpha: 0.6),
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
