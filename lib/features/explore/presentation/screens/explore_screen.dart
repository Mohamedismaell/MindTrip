import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_search_bar.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_refresh_indicator.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_category_chips.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_filter_sheet.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_header.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_places_grid.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_section_header.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_trending_list.dart';
import 'package:mindtrip/features/explore/presentation/widgets/float_map_button.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRefreshIndicator(
      onRefresh: () async {
        await context.read<ExploreCubit>().loadAllData();
      },
      child: Scaffold(
        floatingActionButton: FloatMapButton(),
        backgroundColor: context.colorTheme.surface,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: CustomScrollView(
              slivers: [
                //  Header
                const ExploreHeader(),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                //! Dummy search

                //  Search Bar
                SliverToBoxAdapter(
                  child: AppSearchBar(
                    hintText: 'Destinations, trips, activities...',
                    heroTag: 'explore_search_bar_hero',
                    onTap: () => context.push(
                      AppRoutes.globalSearch,
                      extra: 'explore_search_bar_hero',
                    ),
                    onVoiceTap: () {},
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                //  Category Chips
                ExploreCategoryChips(),
                SliverToBoxAdapter(child: SizedBox(height: 18.h)),

                //  Tab Bar
                // ExploreTabBar(tabs: ExploreMockData.tabs),
                // SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                //  Results Bar
                // ExploreResultsBar(
                //   resultCount: 48,
                //   onFilterTap: () => ExploreFilterSheet.show(context),
                //   onSortTap: () {},
                // ),
                // SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                //  Other Places
                //Todo change it to respnd to the category type
                BlocBuilder<ExploreCubit, ExploreState>(
                  builder: (context, state) {
                    return ExploreSectionHeader(
                      title: 'Popular',
                      filterCount: state.filterCount,
                      isActionButton: true,
                      onFilterTap: () => ExploreFilterSheet.show(context),
                    );
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                const ExplorePlacesGrid(),
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),

                //  Trending Now
                const ExploreSectionHeader(title: 'What Trending now'),
                SliverToBoxAdapter(child: SizedBox(height: 12.h)),
                const ExploreTrendingList(),
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                //  Show More + Map
                // const ExploreShowMoreButton(),
                SliverToBoxAdapter(child: SizedBox(height: 50.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
