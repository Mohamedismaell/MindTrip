import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_state.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/profile_reviews_state.dart';
import 'package:mindtrip/features/profile/presentation/widgets/profile/stats_card.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';

class ProfileStatsSection extends StatelessWidget {
  const ProfileStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsCubit, TripsState>(
      buildWhen: (previous, current) =>
          previous.trips != current.trips ||
          previous.tripsStatus != current.tripsStatus,
      builder: (context, tripsState) {
        return BlocBuilder<ProfileReviewsCubit, ProfileReviewsState>(
          buildWhen: (previous, current) =>
              previous.reviews != current.reviews ||
              previous.isLoading != current.isLoading,
          builder: (context, reviewsState) {
            return BlocBuilder<FavoriteCubit, FavoriteState>(
              buildWhen: (previous, current) =>
                  previous.favoritePlaces != current.favoritePlaces ||
                  previous.status != current.status,
              builder: (context, favoriteState) {
                final tripsCount = tripsState.trips.length;
                final reviewsCount = reviewsState.reviews.length;
                final savedCount = favoriteState.favoritePlaces.length;

                final isTripsLoading =
                    tripsState.tripsStatus == TripsStatus.loading;
                final isReviewsLoading = reviewsState.isLoading;
                final isSavedLoading =
                    favoriteState.status == FavoritesStatus.loading ||
                    favoriteState.status == FavoritesStatus.initial;

                return Center(
                  child: StatsCard(
                    stats: [
                      ProfileStatData(
                        label: 'Trips',
                        value: isTripsLoading ? '...' : '$tripsCount',
                      ),
                      ProfileStatData(
                        label: 'Reviews',
                        value: isReviewsLoading ? '...' : '$reviewsCount',
                      ),
                      ProfileStatData(
                        label: 'Saved',
                        value: isSavedLoading ? '...' : '$savedCount',
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

