import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/core/shared/models/interest_categories.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/features/places/presentation/recommended_places/cubit/recommended_places_cubit.dart';
import 'package:mindtrip/features/places/presentation/widgets/recommended_grid.dart';

class HomeRecommendedSection extends StatelessWidget {
  const HomeRecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) {
        // Trigger on initial profile load or when interests are explicitly saved
        final initialLoad =
            previous.userStatus != current.userStatus &&
            current.userStatus == UserStatus.loaded;
        final savedInterests =
            previous.interestStatus != current.interestStatus &&
            current.interestStatus == InterestStatus.saved;
        return initialLoad || savedInterests;
      },
      listener: (context, userState) {
        final strippedInterests = userState.interests
            .map((interest) => InterestCategories.stripEmoji(interest))
            .toList();
        context.read<RecommendedPlacesCubit>().loadFirstPage(
          selectedCategories: strippedInterests,
        );
      },
      child: BlocBuilder<RecommendedPlacesCubit, RecommendedPlacesState>(
        buildWhen: (previous, current) =>
            previous.recommendedPlacesStatus !=
                current.recommendedPlacesStatus ||
            previous.places != current.places,
        builder: (context, state) {
          if (state.recommendedPlacesStatus.isFailure) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                message: state.error,
                imageSize: 80,
                onPressed: () {
                  final interests = context.read<UserCubit>().state.interests;
                  final strippedInterests = interests
                      .map(
                        (interest) => InterestCategories.stripEmoji(interest),
                      )
                      .toList();
                  context.read<RecommendedPlacesCubit>().loadFirstPage(
                    selectedCategories: strippedInterests,
                  );
                },
              ),
            );
          }

          final isLoading =
              state.recommendedPlacesStatus.isLoading ||
              state.recommendedPlacesStatus.isInitial;
          final destinations = isLoading
              ? DummyData.recommendedPlaces
              : state.places;

          if (!isLoading && destinations.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          return RecommendedplacesGrid(
            destinations: destinations,
            isLoading: isLoading,
          );
        },
      ),
    );
  }
}
