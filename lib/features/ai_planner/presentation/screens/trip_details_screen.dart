import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_details_header.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_day_card.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';

class TripDetailsScreen extends StatefulWidget {
  final String tripId;

  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _MySliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TripDetailsCubit>().loadTripDetails(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripDetailsCubit, TripDetailsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colorTheme.surface,
          body: _buildBody(context, state),
          floatingActionButton: _buildFab(context, state),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, TripDetailsState state) {
    if (state.status == TripDetailsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == TripDetailsStatus.error) {
      return Center(child: Text(state.errorMessage ?? 'Error loading trip'));
    }

    if (state.trip == null || state.itinerary == null) {
      return const Center(child: Text('Trip not found'));
    }

    final trip = state.trip!;
    final itinerary = state.itinerary!;

    return CustomScrollView(
      slivers: [
        // Header with image and basic info
        SliverPersistentHeader(
          pinned: true,
          delegate: _MySliverPersistentHeaderDelegate(
            minHeight: 120.h,
            maxHeight: 280.h,
            child: TripDetailsHeader(trip: trip),
          ),
        ),

        // Itinerary List
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final day = itinerary.days[index];
              final isExpanded = state.expandedDays.contains(day.dayNumber);

              return TripDayCard(
                day: day,
                isExpanded: isExpanded,
                onToggle: () {
                  context.read<TripDetailsCubit>().toggleDayExpanded(
                    day.dayNumber,
                  );
                },
              );
            }, childCount: itinerary.days.length),
          ),
        ),

        // Bottom spacing for FAB or padding
        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );
  }

  Widget? _buildFab(BuildContext context, TripDetailsState state) {
    if (state.itinerary == null) return null;
    final trip = state.trip;
    final isInProgress = trip?.status == TripStatus.inProgress;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mark as Completed — only visible when the trip is inProgress
        if (isInProgress) ...[
          FloatingActionButton.extended(
            heroTag: 'complete_fab',
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Mark trip as completed?'),
                  content: const Text(
                    'This will move your trip to the completed tab.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Complete'),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                await context.read<TripsCubit>().completeTrip(trip!.id);
                if (context.mounted) context.pop();
              }
            },
            backgroundColor: Colors.green,
            label: Text(
              'Mark as Completed',
              style: AppTextStyles.h9SemiBold.copyWith(color: Colors.white),
            ),
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
          ),
          SizedBox(height: 12.h),
        ],

        // View on Map — always visible
        FloatingActionButton.extended(
          heroTag: 'map_fab',
          onPressed: () {
            final allPlaces = state.itinerary!.days
                .expand((day) => day.timeSlots.expand((slot) => slot.places))
                .toList();
            context.push(AppRoutes.map, extra: allPlaces);
          },
          backgroundColor: context.colorTheme.primary,
          label: Text(
            'View on Map',
            style: AppTextStyles.h9SemiBold.copyWith(color: Colors.white),
          ),
          icon: const Icon(Icons.map_outlined, color: Colors.white),
        ),
      ],
    );
  }
}
