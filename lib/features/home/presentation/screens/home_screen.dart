import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_search_bar.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_refresh_indicator.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_category_chips.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_category_places_list.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_header.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_recommended_section.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_hidden_gems_section.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_favorite_trips_section.dart';
import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_cubit.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_section_header.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final interests = context.read<UserCubit>().state.interests;
    context.read<HomeCubit>().loadAllData();
    context.read<RecommendedPlacesCubit>().loadFirstPage(
      selectedCategories: interests,
    );

    // Global Trip state
    final tripsCubit = context.read<TripsCubit>();
    if (tripsCubit.state.tripsStatus == TripsStatus.initial) {
      tripsCubit.loadTrips(silent: true);
    }
    context.read<TripFavoriteCubit>().loadFavoriteTrips();
  }

  void _navigateToRecommended() {
    context.push(AppRoutes.recommendedPlaces);
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().loadAllData();
        context.read<TripsCubit>().loadTrips(silent: true);
        context.read<TripFavoriteCubit>().loadFavoriteTrips();
        await context.read<RecommendedPlacesCubit>().loadFirstPage(
          selectedCategories: context.read<UserCubit>().state.interests,
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: CustomScrollView(
              slivers: [
                const HomeHeader(),
                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                SliverToBoxAdapter(
                  child: AppSearchBar(
                    hintText: 'Destinations, trips, activities...',
                    heroTag: 'home_search_bar_hero',
                    onTap: () => context.push(
                      AppRoutes.globalSearch,
                      extra: 'home_search_bar_hero',
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                const HomeBannerCarousel(),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                // const HomeFavoriteTripsSection(),
                HomeSectionHeader(
                  title: 'Recommended',
                  subtitle: 'Based on your interests',
                  showSeeMore: true,
                  onSeeMore: _navigateToRecommended,
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const HomeRecommendedSection(),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),

                const HomeSectionHeader(
                  title: 'Hotels & Restaurants',
                  subtitle: 'Best places to stay and eat',
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const HomeCategoryChips(),
                const HomeCategoryPlacesList(),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                const HomeSectionHeader(
                  title: 'Hidden Gems',
                  subtitle: 'Uncover hidden places',
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const HomeHiddenGemsSection(),
                SliverToBoxAdapter(child: SizedBox(height: 50.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
