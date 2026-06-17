import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_error_widget.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:mindtrip/features/home/presentation/cubit/home/home_state.dart';
import 'package:mindtrip/features/places/presentation/widgets/recommended_grid.dart';
import 'package:mindtrip/core/utils/dummy_data.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';

class HomeRecommendedSection extends StatelessWidget {
  const HomeRecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) => previous.interests != current.interests,
      listener: (context, userState) {
        context.read<HomeCubit>().loadRecommendedPlaces(
              selectedCategories: userState.interests,
            );
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.recommendedPlacesStatus != current.recommendedPlacesStatus ||
            previous.recommendedPlaces != current.recommendedPlaces,
        builder: (context, state) {
          if (state.recommendedPlacesStatus.isFailure) {
            return SliverToBoxAdapter(
              child: AppErrorWidget(
                message: state.recommendedPlacesError,
                imageSize: 80,
                onPressed: () {
                  final interests = context.read<UserCubit>().state.interests;
                  context.read<HomeCubit>().loadRecommendedPlaces(
                        selectedCategories: interests,
                      );
                },
              ),
            );
          }

          final isLoading = state.recommendedPlacesStatus.isLoading ||
              state.recommendedPlacesStatus.isInitial;
          final destinations =
              isLoading ? DummyData.recommendedPlaces : state.recommendedPlaces;

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
