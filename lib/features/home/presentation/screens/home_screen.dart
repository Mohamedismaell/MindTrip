import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/widget/app_refresh_indicator.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_category_chips.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_category_places_list.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_header.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_recommended_section.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_search_bar.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_section_header.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';

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
  }

  void _navigateToRecommended() {
    context.push(AppRoutes.recommendedPlaces);
  }

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      onRefresh: () async {
        context.read<HomeCubit>().loadAllData();
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
                HomeHeader(),
                SliverToBoxAdapter(child: SizedBox(height: 40.h)),
                // //! Not working right now
                const HomeSearchBar(),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                // //! there is no functionallity for this right now
                const HomeBannerCarousel(),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                // const HomeSectionHeader(title: 'Popular Destinations'),
                // SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                // const HomePopularDestinations(),
                // SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                HomeSectionHeader(
                  title: 'Recommended',
                  subtitle: 'Based on your interests',
                  showSeeMore: true,
                  onSeeMore: _navigateToRecommended,
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const HomeRecommendedSection(),
                SliverToBoxAdapter(child: SizedBox(height: 28.h)),

                HomeSectionHeader(
                  title: 'Hotels & Restaurants',
                  subtitle: 'Best places to stay and eat',
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                const HomeCategoryChips(),
                const HomeCategoryPlacesList(),

                // const HomeSectionHeader(title: 'Tour Packages'),
                // SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                // const HomeTourPackages(),
                // SliverToBoxAdapter(child: SizedBox(height: 28.h)),
                // const HomeSectionHeader(
                //   title: 'AI Planner',
                //   actionLabel: 'Try',
                // ),
                // SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                // const HomeAiPlannerSection(),
                SliverToBoxAdapter(child: SizedBox(height: 50.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
