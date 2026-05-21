import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/ai_refinement_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_day_overview_card.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_details_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_map_preview_card.dart';

class TripDetailsScreen extends StatelessWidget {
  final String tripId;

  const TripDetailsScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<TripDetailsCubit, TripDetailsState>(
          builder: (context, state) {
            return _buildBody(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, TripDetailsState state) {
    if (state.status == TripDetailsStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == TripDetailsStatus.error) {
      return _MessageState(message: state.errorMessage ?? 'Error loading trip');
    }

    final trip = state.trip;
    final itinerary = state.itinerary;
    if (trip == null || itinerary == null || itinerary.days.isEmpty) {
      return const _MessageState(message: 'Trip not found');
    }

    final allPlaces = _allPlaces(itinerary);
    final expandedDay = state.activeDay;

    return CustomScrollView(
      slivers: [
        TripDetailsTopBar(
          onBack: () => context.go(AppRoutes.myTrips),
          onRefine: () =>
              AiRefinementSheet.show(context, trip.id, trip.chatMessages),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 52.h)),
        SliverPadding(
          padding: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 55.h),
          sliver: SliverList.separated(
            itemCount: itinerary.days.length + 3,
            separatorBuilder: (_, index) {
              return SizedBox(height: 42.h);
            },
            itemBuilder: (context, index) {
              if (index < itinerary.days.length) {
                final day = itinerary.days[index];
                return TripDayOverviewCard(
                  day: day,
                  tripCoverAsset: trip.coverAsset,
                  isExpanded: day.dayNumber == expandedDay,
                  onToggle: () {
                    context.read<TripDetailsCubit>().toggleActiveDay(
                      day.dayNumber,
                    );
                  },
                  onRefine: () => AiRefinementSheet.show(
                    context,
                    trip.id,
                    trip.chatMessages,
                  ),
                );
              }

              if (index == itinerary.days.length) {
                return TripMapPreviewCard(
                  days: itinerary.days,
                  onViewMap: allPlaces.isEmpty
                      ? null
                      : () => context.push(AppRoutes.map, extra: allPlaces),
                );
              }

              if (index == itinerary.days.length + 1) {
                return _EstimateNote(
                  estimatedTotalCost: itinerary.estimatedTotalCost,
                );
              }

              return trip.status == TripStatus.completed
                  ? const SizedBox.shrink()
                  : _SaveTripButton(
                      trip: trip,
                      onSave: () {
                        _saveTrip(context, trip);
                      },
                    );
            },
          ),
        ),
      ],
    );
  }

  List<PlaceModel> _allPlaces(TripItinerary itinerary) {
    return itinerary.days
        .expand((day) => day.timeSlots)
        .expand((slot) => slot.places)
        .toList();
  }

  Future<void> _saveTrip(BuildContext context, Trip trip) async {
    AppDialog.show(
      context: context,
      title: 'Save Trip',
      description: 'You can access this itinerary anytime from My Trips.',
      primaryText: 'Save',
      secondaryText: 'Cancel',
      icon: Icons.check_circle,
      onPrimary: () async {
        await context.read<TripsCubit>().completeTrip(trip.id);
        if (!context.mounted) return;
        AppSnackBar.showSuccess(
          context: context,
          message: 'Trip saved successfully',
        );
        context.go(AppRoutes.myTrips);
      },
    );
  }
}

class _EstimateNote extends StatelessWidget {
  const _EstimateNote({required this.estimatedTotalCost});

  final double estimatedTotalCost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CustomHeadLine(
        key: const Key('trip-estimate-note'),
        textAlign: TextAlign.left,
        firstTitle: 'Note: ',
        firstStyle: AppTextStyles.h9Medium.copyWith(
          color: context.colorTheme.onSurface,
        ),
        secondStyle: AppTextStyles.h9Medium.copyWith(color: Colors.black),
        secondTitle:
            'This is an approximate estimate and may vary depending on your food choices, activity upgrades, seasonal prices, and any custom changes to your itinerary',
      ),
    );
  }
}

class _SaveTripButton extends StatelessWidget {
  const _SaveTripButton({required this.trip, required this.onSave});

  final Trip trip;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final isAlreadySaved = trip.status == TripStatus.inProgress;
    final canSave = !isAlreadySaved && trip.placePreviews.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomGradientButton(
        onTap: canSave ? onSave : null,
        text: isAlreadySaved ? 'Trip Saved ' : 'Save Trip',
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.h9Medium,
        ),
      ),
    );
  }
}
