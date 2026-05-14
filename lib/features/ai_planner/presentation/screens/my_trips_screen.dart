import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/draft_trip_card.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/trip_card.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/trip_filter_tabs.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  TripFilterTab _selectedTab = TripFilterTab.all;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().loadTrips();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Trip> _filteredTrips(TripsState state) {
    List<Trip> list;
    switch (_selectedTab) {
      case TripFilterTab.all:
        list = state.trips;
        break;
      case TripFilterTab.completed:
        list = state.completed;
        break;
      case TripFilterTab.recentlyEdited:
        list = state.recentlyEdited;
        break;
      case TripFilterTab.drafts:
        list = state.drafts;
        break;
    }

    if (_searchQuery.isEmpty) return list;
    return list
        .where(
          (t) =>
              t.title.toLowerCase().contains(_searchQuery) ||
              t.destination.toLowerCase().contains(_searchQuery),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),

              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 26.sp,
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'My ',
                            style: AppTextStyles.h5Bold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: 'Trips',
                            style: AppTextStyles.h5Bold.copyWith(
                              color: context.colorTheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.tripCalendar),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: context.colorTheme.surface,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.colorTheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        size: 22.sp,
                        color: context.colorTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.only(left: 38.w),
                child: Text(
                  'Your saved travel plans',
                  style: AppTextStyles.h10Regular.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Search bar
              _SearchBar(controller: _searchController),

              SizedBox(height: 16.h),

              // Filter tabs
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  return TripFilterTabs(
                    selected: _selectedTab,
                    onSelect: (tab) => setState(() => _selectedTab = tab),
                  );
                },
              ),

              SizedBox(height: 20.h),

              // Trip list
              Expanded(
                child: BlocBuilder<TripsCubit, TripsState>(
                  builder: (context, state) {
                    if (state.status == TripsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final trips = _filteredTrips(state);

                    if (trips.isEmpty) {
                      return _EmptyState(tab: _selectedTab);
                    }

                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 24.h),
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        if (trip.status == TripStatus.draft) {
                          return DraftTripCard(
                            trip: trip,
                            onContinue: () => _resumeTrip(context, trip),
                          );
                        }
                        return TripCard(
                          trip: trip,
                          onTap: () => _resumeTrip(context, trip),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resumeTrip(BuildContext context, Trip trip) {
    context.push(
      '${AppRoutes.aiPlannerFlow}?tripId=${trip.id}',
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: context.colorTheme.outline.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search_rounded,
            size: 20.sp,
            color: context.colorTheme.outline,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              style: AppTextStyles.h10Regular.copyWith(
                color: context.colorTheme.onSurface,
              ),
              decoration: InputDecoration(
                hintText: 'Search trips...',
                hintStyle: AppTextStyles.h10Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
                border: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.tab});
  final TripFilterTab tab;

  @override
  Widget build(BuildContext context) {
    String message;
    IconData icon;

    switch (tab) {
      case TripFilterTab.drafts:
        message = 'No drafts yet.\nStart planning a trip!';
        icon = Icons.edit_note_rounded;
        break;
      case TripFilterTab.completed:
        message = 'No completed trips yet.';
        icon = Icons.check_circle_outline_rounded;
        break;
      default:
        message = 'No trips yet.\nTap "Start Planning" to begin!';
        icon = Icons.travel_explore_rounded;
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 60.sp, color: context.colorTheme.outline.withValues(alpha: 0.4)),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.h9Regular.copyWith(
              color: context.colorTheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
