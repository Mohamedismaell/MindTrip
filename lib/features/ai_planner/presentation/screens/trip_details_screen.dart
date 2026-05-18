import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/ai_refinement_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/time_period_section.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';

class TripDetailsScreen extends StatefulWidget {
  final String tripId;

  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
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
    final activeDayModel = itinerary.days.firstWhere(
      (d) => d.dayNumber == state.activeDay,
      orElse: () => itinerary.days.first,
    );

    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          expandedHeight: 340.h,
          pinned: true,
          backgroundColor: context.colorTheme.surface,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.go(AppRoutes.myTrips),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.auto_awesome, color: Colors.black),
                  onPressed: () => AiRefinementSheet.show(
                    context,
                    trip.id,
                    trip.chatMessages,
                  ),
                ),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                trip.coverAsset.startsWith('http')
                    ? Image.network(trip.coverAsset, fit: BoxFit.cover)
                    : Image.asset(trip.coverAsset, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.3),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50.h,
                  left: 20.w,
                  right: 20.w,
                  child: Text(
                    trip.title,
                    style: AppTextStyles.h4Bold.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(24.h),
            child: Container(
              height: 24.h,
              decoration: BoxDecoration(
                color: context.colorTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
            ),
          ),
        ),

        // Info and Days Tabs
        SliverToBoxAdapter(
          child: Container(
            color: context.colorTheme.surface,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info badges
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7E6),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        '👑 ${trip.budgetTier ?? 'Flexible'}',
                        style: AppTextStyles.h10Bold.copyWith(color: const Color(0xFFFF9800)),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: context.colorTheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12.sp, color: context.colorTheme.onSurfaceVariant),
                          SizedBox(width: 4.w),
                          Text(
                            '${trip.durationDays} Days',
                            style: AppTextStyles.h10SemiBold.copyWith(color: context.colorTheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                
                // Horizontal Days List
                SizedBox(
                  height: 38.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: itinerary.days.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, index) {
                      final day = itinerary.days[index];
                      final isActive = day.dayNumber == state.activeDay;

                      return GestureDetector(
                        onTap: () {
                          context.read<TripDetailsCubit>().setActiveDay(day.dayNumber);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: isActive ? context.colorTheme.primary : context.colorTheme.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(20.r),
                            border: isActive ? null : Border.all(color: context.colorTheme.outline.withValues(alpha: 0.1)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Day ${day.dayNumber}',
                            style: AppTextStyles.h9SemiBold.copyWith(
                              color: isActive ? Colors.white : context.colorTheme.onSurface,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),

        // Timeline for the selected day
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Vertical Timeline Line
                    Container(
                      width: 24.w,
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: 2.w,
                        color: context.colorTheme.outline.withValues(alpha: 0.15),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    // The time slot
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: TimePeriodSection(slot: activeDayModel.timeSlots[index]),
                      ),
                    ),
                  ],
                ),
              );
            }, childCount: activeDayModel.timeSlots.length),
          ),
        ),

        // Bottom spacing
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
        if (isInProgress) ...[
          FloatingActionButton.extended(
            heroTag: 'complete_fab',
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Mark trip as completed?'),
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
        FloatingActionButton.extended(
          heroTag: 'map_fab',
          onPressed: () {
            final activeDayModel = state.itinerary!.days.firstWhere(
              (d) => d.dayNumber == state.activeDay,
              orElse: () => state.itinerary!.days.first,
            );
            final activeDayPlaces = activeDayModel.timeSlots
                .expand((slot) => slot.places)
                .toList();
            context.push(AppRoutes.map, extra: activeDayPlaces);
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
