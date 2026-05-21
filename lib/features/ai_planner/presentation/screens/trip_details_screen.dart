import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/data/models/place_model.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/ai_refinement_sheet.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_day_overview_card.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_details_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/trip_details/trip_map_preview_card.dart';

class TripDetailsScreen extends StatefulWidget {
  final String tripId;

  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int? _expandedDay;

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
          backgroundColor: Colors.white,
          body: SafeArea(child: _buildBody(context, state)),
        );
      },
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
    final expandedDay = _expandedDay;

    return CustomScrollView(
      slivers: [
        TripDetailsTopBar(
          onBack: () => context.go(AppRoutes.myTrips),
          onRefine: () =>
              AiRefinementSheet.show(context, trip.id, trip.chatMessages),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
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
                    setState(() {
                      _expandedDay = day.dayNumber == expandedDay
                          ? null
                          : day.dayNumber;
                    });
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

              return _SaveTripButton(
                trip: trip,
                onSave: () => _completeTrip(context, trip),
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

  Future<void> _completeTrip(BuildContext context, Trip trip) async {
    if (trip.status != TripStatus.inProgress) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Save trip?'),
        content: const Text('This will mark your trip as completed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    await context.read<TripsCubit>().completeTrip(trip.id);
    if (!context.mounted) return;
    await context.read<TripDetailsCubit>().loadTripDetails(trip.id);
  }
}

class _EstimateNote extends StatelessWidget {
  const _EstimateNote({required this.estimatedTotalCost});

  final double estimatedTotalCost;

  @override
  Widget build(BuildContext context) {
    return RichText(
      key: const Key('trip-estimate-note'),
      text: TextSpan(
        style: AppTextStyles.h9Medium.copyWith(
          color: Colors.black,
          height: 1.4,
        ),
        children: [
          const TextSpan(
            text: 'Note: ',
            style: TextStyle(color: Color(0xFF374151)),
          ),
          TextSpan(
            text:
                'This is an approximate estimate and may vary depending on your food choices, activity upgrades, seasonal prices, and any custom changes to your itinerary.',
          ),
          TextSpan(
            text: ' Estimated total: ${estimatedTotalCost.round()} EGP.',
          ),
        ],
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
    final isCompleted = trip.status == TripStatus.completed;
    final isDraft = trip.status == TripStatus.draft;

    return Center(
      child: SizedBox(
        width: 323.w,
        height: 52.h,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.r),
            gradient: isDraft
                ? null
                : const LinearGradient(
                    colors: [Color(0xFF5596FE), Color(0xFF97CEFF)],
                  ),
            color: isDraft ? const Color(0xFFE5E7EB) : null,
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton(
            key: const Key('save-trip-button'),
            onPressed: isDraft || isCompleted ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            child: Text(
              isCompleted ? 'Trip Saved' : 'Save Trip',
              style: AppTextStyles.h7Bold.copyWith(
                color: isDraft ? const Color(0xFF727272) : Colors.white,
              ),
            ),
          ),
        ),
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
