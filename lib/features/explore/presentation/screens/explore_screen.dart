import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/explore/presentation/data/explore_mock_data.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_category_chips.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_filter_sheet.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_header.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_places_grid.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_results_bar.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_search_bar.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_section_header.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_tab_bar.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_trending_list.dart';
import 'package:mindtrip/features/explore/presentation/widgets/float_map_button.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatMapButton(),
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomScrollView(
            slivers: [
              //  Header
              const ExploreHeader(),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              //Todo: is there 2 search bars in the app home and explore screens ?
              //! Dummy search
              //  Search Bar
              const ExploreSearchBar(),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              //  Trending Now
              const ExploreSectionHeader(title: 'What Trending now'),
              SliverToBoxAdapter(child: SizedBox(height: 12.h)),
              const ExploreTrendingList(),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              //Todo: edit Ui later
              //!No funcaitonality right now
              //  Category Chips
              ExploreCategoryChips(categories: ExploreMockData.categories),
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
              ExploreSectionHeader(
                title: 'Other Places',
                isActionButton: true,
                onFilterTap: () => ExploreFilterSheet.show(context),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 12.h)),
              const ExplorePlacesGrid(),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),

              //  Show More + Map
              // const ExploreShowMoreButton(),
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        ),
      ),
    );
  }
}
