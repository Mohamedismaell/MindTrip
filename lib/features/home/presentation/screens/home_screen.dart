import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_ai_planner_section.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_banner_carousel.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_header.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_popular_destinations.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_recommended_grid.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_search_bar.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_section_header.dart';
import 'package:mindtrip/features/home/presentation/widgets/home_tour_packages.dart';

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

    context.read<HomeCubit>().loadAllData(selectedCategories: interests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const HomeSectionHeader(title: 'Popular Destinations'),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              // //! there is no functionallity for this right now
              const HomePopularDestinations(),
              SliverToBoxAdapter(child: SizedBox(height: 28.h)),
              const HomeSectionHeader(
                title: 'Recommended',
                subtitle: 'Based on your interests',
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              const HomeRecommendedGrid(),
              SliverToBoxAdapter(child: SizedBox(height: 28.h)),
              const HomeSectionHeader(title: 'Tour Packages'),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              const HomeTourPackages(),
              SliverToBoxAdapter(child: SizedBox(height: 28.h)),
              const HomeSectionHeader(title: 'AI Planner', actionLabel: 'Try'),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              const HomeAiPlannerSection(),
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        ),
      ),
    );
  }
}
