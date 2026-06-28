import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
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
            final tripsCount = tripsState.trips.length;
            final reviewsCount = reviewsState.reviews.length;

            final isTripsLoading =
                tripsState.tripsStatus == TripsStatus.loading;
            final isReviewsLoading = reviewsState.isLoading;

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
                  const ProfileStatData(label: 'Saved', value: '10'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
