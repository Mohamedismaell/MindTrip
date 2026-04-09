import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/bottom_nav.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_ai_planner_section.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_category_list.dart';
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
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      bottomNavigationBar: BottomNav(currentIndex: 0, onTap: (_) {}),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          children: [
            //Todo replace with real user info
            HomeHeader(profileImageUrl: HomeMockData.profileImageUrl),
            SizedBox(height: 40.h),
            //! Not working right now
            const HomeSearchBar(),
            SizedBox(height: 20.h),
            //! there is no functionallity for this right now + need ui edits still
            HomeCategoryList(categories: HomeMockData.categories),
            SizedBox(height: 22.h),
            //! there is no functionallity for this right now
            HomeBannerCarousel(banners: HomeMockData.banners),
            SizedBox(height: 28.h),
            const HomeSectionHeader(title: 'Popular Destinations'),
            SizedBox(height: 16.h),
            //! there is no functionallity for this right now
            HomePopularDestinations(
              destinations: HomeMockData.popularDestinations,
            ),
            SizedBox(height: 28.h),
            const HomeSectionHeader(
              title: 'Recommended',
              subtitle: 'Based on your interests',
            ),
            SizedBox(height: 16.h),
            HomeRecommendedGrid(
              destinations: HomeMockData.recommendedDestinations,
            ),
            SizedBox(height: 28.h),
            const HomeSectionHeader(title: 'Tour Packages'),
            SizedBox(height: 16.h),
            HomeTourPackages(packages: HomeMockData.tourPackages),
            SizedBox(height: 28.h),
            const HomeSectionHeader(title: 'AI Planner', actionLabel: 'Try'),
            SizedBox(height: 16.h),
            HomeAiPlannerSection(plans: HomeMockData.plannerPreviews),
          ],
        ),
      ),
    );
  }
}
