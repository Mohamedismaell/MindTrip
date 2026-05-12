import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_ai_planner_section.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_header.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_popular_destinations.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_recommended_grid.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_search_bar.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_section_header.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_tour_packages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: CustomScrollView(
        slivers: [
          HomeHeader(),
          SliverToBoxAdapter(child: SizedBox(height: 40.h)),
          // //! Not working right now
          const HomeSearchBar(),
          SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          // //! there is no functionallity for this right now
          HomeBannerCarousel(banners: HomeMockData.banners),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
          const HomeSectionHeader(title: 'Popular Destinations'),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          // //! there is no functionallity for this right now
          HomePopularDestinations(
            destinations: HomeMockData.popularDestinations,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
          const HomeSectionHeader(
            title: 'Recommended',
            subtitle: 'Based on your interests',
          ),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          HomeRecommendedGrid(
            destinations: HomeMockData.recommendedDestinations,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
          const HomeSectionHeader(title: 'Tour Packages'),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          HomeTourPackages(packages: HomeMockData.tourPackages),
          SliverToBoxAdapter(child: SizedBox(height: 28.h)),
          const HomeSectionHeader(title: 'AI Planner', actionLabel: 'Try'),
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),
          HomeAiPlannerSection(plans: HomeMockData.plannerPreviews),
          SliverToBoxAdapter(child: SizedBox(height: 50.h)),
        ],
      ),
    );
  }
}
