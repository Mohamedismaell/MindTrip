import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/core/widget/custom_search_bar.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/start_planning_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/trip_card.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trips/trip_filter_tabs.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({super.key});

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().loadTrips();
    _searchController.addListener(() {
      context.read<TripsCubit>().updateSearchQuary(
        _searchController.text.trim().toLowerCase(),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      floatingActionButton: StartPlanningButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              // Header
              _CustomHeader(),

              SizedBox(height: 20.h),

              // Search bar
              CustomSearchBar(controller: _searchController, handleSend: () {}),

              SizedBox(height: 33.h),

              // Filter tabs
              BlocBuilder<TripsCubit, TripsState>(
                builder: (context, state) {
                  return TripFilterTabs(
                    selected: state.selectedTab,
                    onSelect: (tab) {
                      context.read<TripsCubit>().updateSelectedTab(tab);
                    },
                  );
                },
              ),

              SizedBox(height: 28.h),

              // Trip list
              Expanded(
                child: BlocBuilder<TripsCubit, TripsState>(
                  buildWhen: (previous, current) =>
                      previous.trips != current.trips ||
                      previous.searchQuery != current.searchQuery ||
                      previous.tripsStatus != current.tripsStatus ||
                      previous.selectedTab != current.selectedTab,
                  builder: (context, state) {
                    if (state.tripsStatus == TripsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final trips = state.filterTrips;

                    if (trips.isEmpty) {
                      return _EmptyState(tab: state.selectedTab);
                    }

                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: 80.h),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 31.h),
                      itemCount: trips.length,
                      itemBuilder: (context, index) {
                        final trip = trips[index];
                        return TripCard(
                          trip: trip,
                          tripStatus: trip.status,
                          onContinue: () => _resumeTrip(context, trip),
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
    if (trip.status == TripStatus.inProgress) {
      context.push('${AppRoutes.tripDetails}?tripId=${trip.id}');
    } else {
      context.push('${AppRoutes.aiPlannerFlow}?tripId=${trip.id}');
    }
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.profile);
                }
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: 30.sp,
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomHeadLine(
                firstTitle: 'My ',
                secondTitle: 'Trips',
                firstStyle: AppTextStyles.h5Bold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                secondStyle: AppTextStyles.h5Bold.copyWith(
                  color: context.colorTheme.primary,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.tripCalendar),
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.calendar_month_rounded,
                  size: 28.sp,
                  color: context.colorTheme.primary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 17.h),
        Text(
          'Your saved travel plans',
          style: AppTextStyles.h7Regular.copyWith(
            color: context.colorTheme.onSurfaceVariant,
          ),
        ),
      ],
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
          Icon(
            icon,
            size: 60.sp,
            color: context.colorTheme.outline.withValues(alpha: 0.4),
          ),
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
