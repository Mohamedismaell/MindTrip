import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/explore/presentation/widgets/explore_place_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_state.dart';

import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ExplorePlacesGrid extends StatelessWidget {
  const ExplorePlacesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      buildWhen: (previous, current) =>
          previous.otherPlacesStatus != current.otherPlacesStatus ||
          previous.otherPlaces != current.otherPlaces,
      builder: (context, state) {
        if (state.otherPlacesStatus == ExploreDataStatus.failure) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
              message: state.otherPlacesError,
              imageSize: 80,
              onPressed: () =>
                  context.read<ExploreCubit>().loadMoreTrendingPlaces(),
            ),
          );
        }

        final isLoading =
            state.otherPlacesStatus == ExploreDataStatus.loading ||
            state.otherPlacesStatus == ExploreDataStatus.initial;
        final places = isLoading
            ? DummyData.recommendedPlaces
            : state.otherPlaces.items;

        if (!isLoading && places.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverGrid.builder(
          itemCount: places.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 32.h,
            crossAxisSpacing: 24.w,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            return Skeletonizer(
              enabled: isLoading,
              child: ExplorePlaceCard(place: places[index], hasBadge: true),
            );
          },
        );
      },
    );
  }
}
