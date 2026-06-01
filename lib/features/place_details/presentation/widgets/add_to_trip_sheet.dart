import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trip_details_cubit.dart';

import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_state.dart';

/// Opens the "Add to your trip" bottom sheet.
/// Requires [TripsCubit] to be in scope (it is — registered as LazySingleton).
Future<void> showAddToTripSheet(
  BuildContext context, {
  required PlaceEntity place,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: sl<TripsCubit>()..loadTrips(),
      child: _AddToTripSheet(place: place),
    ),
  );
}

class _AddToTripSheet extends StatefulWidget {
  final PlaceEntity place;
  const _AddToTripSheet({required this.place});

  @override
  State<_AddToTripSheet> createState() => _AddToTripSheetState();
}

class _AddToTripSheetState extends State<_AddToTripSheet> {
  String? _loadingTripId; // tracks which tile is pending

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          ),
          child: Column(
            children: [
              // Drag handle
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 8.h),
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: context.colorTheme.outlineVariant,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add to your trip',
                            style: AppTextStyles.h7Bold.copyWith(
                              color: context.colorTheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            widget.place.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.h9Regular.copyWith(
                              color: context.colorTheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),

              Divider(
                height: 24.h,
                thickness: 0.5,
                color: context.colorTheme.outlineVariant,
              ),

              // Trip list
              Expanded(
                child: BlocBuilder<TripsCubit, TripsState>(
                  buildWhen: (previous, current) =>
                      previous.trips != current.trips ||
                      previous.tripsStatus != current.tripsStatus,
                  builder: (context, state) {
                    if (state.tripsStatus == TripsStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final trips = state.trips
                        .where(
                          (t) =>
                              t.status == TripStatus.inProgress ||
                              t.status == TripStatus.draft,
                        )
                        .toList();

                    return ListView(
                      controller: scrollController,
                      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                      children: [
                        if (trips.isEmpty)
                          _EmptyTrips(place: widget.place)
                        else ...[
                          Text(
                            'Select a trip',
                            style: AppTextStyles.h9SemiBold.copyWith(
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ...trips.map(
                            (trip) => _TripTile(
                              trip: trip,
                              place: widget.place,
                              isLoading: _loadingTripId == trip.id,
                              onTap: () => _addToExisting(trip),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Divider(
                            thickness: 0.5,
                            color: context.colorTheme.outlineVariant,
                          ),
                          SizedBox(height: 12.h),
                        ],
                        _NewTripButton(place: widget.place),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _addToExisting(Trip trip) async {
    setState(() => _loadingTripId = trip.id);

    // Spin up a TripDetailsCubit scoped to this operation
    final cubit = sl<TripDetailsCubit>();
    await cubit.loadTripDetails(trip.id);
    await cubit.addPlaceAuto(widget.place);

    if (mounted) {
      setState(() => _loadingTripId = null);
      Navigator.of(context).pop();
      _showDoneSnackbar(context, trip);
    }
  }

  void _showDoneSnackbar(BuildContext context, Trip trip) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                '${widget.place.name} added to ${trip.title}',
                style: AppTextStyles.h9Medium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColors.customgreeen,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Trip Tile
// ─────────────────────────────────────────────

class _TripTile extends StatelessWidget {
  final Trip trip;
  final PlaceEntity place;
  final bool isLoading;
  final VoidCallback onTap;

  const _TripTile({
    required this.trip,
    required this.place,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final coverUrl =
        trip.itineraryCoverUrl ??
        (trip.placePreviews.isNotEmpty
            ? trip.placePreviews.first['imageUrl']
            : null);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: isLoading
              ? context.colorTheme.primaryContainer.withValues(alpha: 0.5)
              : context.colorTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isLoading
                ? context.colorTheme.primary.withValues(alpha: 0.4)
                : context.colorTheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Cover image or placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                width: 52.r,
                height: 52.r,
                color: AppColors.primaryLightGray,
                child: coverUrl != null && coverUrl.isNotEmpty
                    ? Image.network(
                        coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.map_outlined),
                      )
                    : const Icon(
                        Icons.map_outlined,
                        color: AppColors.darkGray1,
                      ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h9SemiBold.copyWith(
                      color: context.colorTheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    _buildSubtitle(trip),
                    style: AppTextStyles.h9Regular.copyWith(
                      color: context.colorTheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            if (isLoading)
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Icon(
                Icons.add_circle_outline_rounded,
                color: context.colorTheme.primary,
                size: 22.r,
              ),
          ],
        ),
      ),
    );
  }

  String _buildSubtitle(Trip trip) {
    final parts = <String>[];
    if (trip.destination.isNotEmpty) parts.add(trip.destination);
    final count = trip.placePreviews.length;
    if (count > 0) parts.add('$count places');
    if (parts.isEmpty) return trip.status.name;
    return parts.join(' · ');
  }
}

// ─────────────────────────────────────────────
// "New Trip" button
// ─────────────────────────────────────────────

class _NewTripButton extends StatelessWidget {
  final PlaceEntity place;
  const _NewTripButton({required this.place});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        Navigator.of(context).pop();
        _showNewTripDialog(context, place);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: context.colorTheme.primary,
        side: BorderSide(color: context.colorTheme.primary),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.r),
        ),
        minimumSize: Size(double.infinity, 0),
      ),
      icon: const Icon(Icons.add_rounded),
      label: const Text('Create new trip'),
    );
  }
}

// ─────────────────────────────────────────────
// Empty state (no trips yet)
// ─────────────────────────────────────────────

class _EmptyTrips extends StatelessWidget {
  final PlaceEntity place;
  const _EmptyTrips({required this.place});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.travel_explore_rounded,
              size: 48.r,
              color: context.colorTheme.outline.withValues(alpha: 0.4),
            ),
            SizedBox(height: 12.h),
            Text(
              "You don't have any trips yet.",
              style: AppTextStyles.h9Regular.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
            SizedBox(height: 20.h),
            _NewTripButton(place: place),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// New Trip Dialog / Sheet
// ─────────────────────────────────────────────

void _showNewTripDialog(BuildContext context, PlaceEntity place) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BlocProvider.value(
      value: sl<TripsCubit>(),
      child: _NewTripSheet(place: place),
    ),
  );
}

class _NewTripSheet extends StatefulWidget {
  final PlaceEntity place;
  const _NewTripSheet({required this.place});

  @override
  State<_NewTripSheet> createState() => _NewTripSheetState();
}

class _NewTripSheetState extends State<_NewTripSheet> {
  final _titleController = TextEditingController();
  DayPeriod _period = DayPeriod.morning;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = 'Trip to ${widget.place.location.address}';
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: context.colorTheme.outlineVariant,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'New trip',
              style: AppTextStyles.h7Bold.copyWith(
                color: context.colorTheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Adding: ${widget.place.name}',
              style: AppTextStyles.h9Regular.copyWith(
                color: context.colorTheme.outline,
              ),
            ),
            SizedBox(height: 20.h),

            // Trip title
            TextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Trip title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Period picker
            Text(
              'Schedule at',
              style: AppTextStyles.h9SemiBold.copyWith(
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: DayPeriod.values
                  .map(
                    (p) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: p != DayPeriod.evening ? 8.w : 0,
                        ),
                        child: _PeriodChip(
                          period: p,
                          selected: _period == p,
                          onTap: () => setState(() => _period = p),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 24.h),

            // Create button
            FilledButton(
              onPressed: _isSaving ? null : _create,
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: _isSaving
                  ? SizedBox(
                      width: 20.r,
                      height: 20.r,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Create trip & add place'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _create() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() => _isSaving = true);

    final tripsCubit = context.read<TripsCubit>();
    final tripId = await tripsCubit.createDraft(widget.place.location.address);

    // Save draft with custom title
    final trip = tripsCubit.state.trips.firstWhere((t) => t.id == tripId);
    final namedTrip = trip.copyWith(title: title);
    await tripsCubit.saveTripDraft(namedTrip);

    // Add the place via TripDetailsCubit
    final detailsCubit = sl<TripDetailsCubit>();
    await detailsCubit.loadTripDetails(tripId);
    await detailsCubit.addPlace(
      dayNumber: 1,
      period: _period,
      place: widget.place,
    );

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'New trip created with ${widget.place.name}!',
                  style: AppTextStyles.h9Medium.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: AppColors.customgreeen,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}

class _PeriodChip extends StatelessWidget {
  final DayPeriod period;
  final bool selected;
  final VoidCallback onTap;

  const _PeriodChip({
    required this.period,
    required this.selected,
    required this.onTap,
  });

  String get label => switch (period) {
    DayPeriod.morning => '🌅 Morning',
    DayPeriod.afternoon => '☀️ Afternoon',
    DayPeriod.evening => '🌙 Evening',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: selected
              ? context.colorTheme.primary
              : context.colorTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: selected
                ? context.colorTheme.primary
                : context.colorTheme.outlineVariant,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.h9SemiBold.copyWith(
            color: selected
                ? Colors.white
                : context.colorTheme.onSurfaceVariant,
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
