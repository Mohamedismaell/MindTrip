import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_place_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExplorePlacesGrid extends StatefulWidget {
  const ExplorePlacesGrid({super.key});

  @override
  State<ExplorePlacesGrid> createState() => _ExplorePlacesGridState();
}

class _ExplorePlacesGridState extends State<ExplorePlacesGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ExploreCubit>().loadMoreOtherPlaces();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll - (MediaQuery.sizeOf(context).width / 2);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      buildWhen: (previous, current) =>
          previous.filteredPlacesStatus != current.filteredPlacesStatus ||
          previous.filteredPlaces != current.filteredPlaces,
      builder: (context, state) {
        if (state.filteredPlacesStatus.isFailure) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: AppErrorWidget(
                message: state.filteredPlacesError.isNotEmpty
                    ? state.filteredPlacesError
                    : 'Failed to load places',
                imageSize: 100,
                onPressed: () =>
                    context.read<ExploreCubit>().loadFilteredPlacesFirstPage(),
              ),
            ),
          );
        }

        final isLoading =
            state.filteredPlacesStatus.isLoading ||
            state.filteredPlacesStatus.isInitial;
        final places = isLoading
            ? DummyData.exploreCardPlaces
            : state.filteredPlaces.items;

        if (!isLoading && places.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: AppErrorWidget(
                message: 'No places found matching your criteria.',
                imageSize: 100,
                onPressed: () =>
                    context.read<ExploreCubit>().loadFilteredPlacesFirstPage(),
              ),
            ),
          );
        }

        return SliverToBoxAdapter(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth;

              const crossAxisSpacing = 32.0;
              const mainAxisSpacing = 24.0;
              const rows = 2;

              final cardWidth = (availableWidth - mainAxisSpacing) / rows;

              const aspectRatio = 0.68;
              final cardHeight = cardWidth / aspectRatio;

              final containerHeight =
                  (cardHeight * rows) + (crossAxisSpacing * (rows - 1));

              return SizedBox(
                height: containerHeight,
                child: Skeletonizer(
                  enabled: isLoading,
                  child: Stack(
                    children: [
                      GridView.builder(
                        controller: _scrollController,
                        // physics: const  BouncingScrollPhysics(),
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            places.length +
                            (state.filteredPlaces.isMoreLoading ? 4 : 0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: rows,
                          mainAxisSpacing: 24.w,
                          crossAxisSpacing: 32.h,
                          mainAxisExtent: cardWidth,
                        ),
                        itemBuilder: (context, index) {
                          if (index >= places.length) {
                            return const Skeletonizer(
                              enabled: true,
                              child: ExplorePlaceCard(
                                place: DummyData.place,
                                hasBadge: true,
                              ),
                            );
                          }
                          return ExplorePlaceCard(
                            place: places[index],
                            hasBadge: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
