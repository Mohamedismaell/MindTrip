import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/widget/custom_head_line.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trp_share_state.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/itinerary/presentation/cubit/trip_share_cubit.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_day.dart';
import 'package:mindtrip/features/itinerary/domain/entities/trip_itinerary.dart';
import 'package:mindtrip/features/itinerary/presentation/widgets/ai_refinement_sheet.dart';
import 'package:mindtrip/features/itinerary/presentation/widgets/trip_day_overview_card.dart';
import 'package:mindtrip/features/itinerary/presentation/widgets/trip_details_bar.dart';
import 'package:mindtrip/features/itinerary/presentation/widgets/trip_map_preview_card.dart';
import 'package:mindtrip/features/map/data/models/map_trip_extra.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TripDetailsScreen extends StatelessWidget {
  final String tripId;
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

  const TripDetailsScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripShareCubit, TripShareState>(
      listener: (context, state) {
        if (state is TripShareLoading) {
          AppDialog.showLoading(context: context);
        } else if (state is TripShareSuccess) {
          AppDialog.hideLoading(context);
        } else if (state is TripShareError) {
          AppDialog.hideLoading(context);
          AppSnackBar.showError(context: context, message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<TripDetailsCubit, TripDetailsState>(
            builder: (context, state) {
              final isLoading = state.status == TripDetailsStatus.loading;

              if (state.status == TripDetailsStatus.error) {
                return _MessageState(
                  message: state.errorMessage ?? 'Error loading trip',
                );
              }

              final trip = isLoading ? _dummyTrip : state.trip;
              final itinerary = isLoading ? _dummyItinerary : state.itinerary;

              if (!isLoading &&
                  (trip == null ||
                      itinerary == null ||
                      itinerary.days.isEmpty)) {
                return const _MessageState(message: 'Trip not found');
              }

              final expandedDay = state.activeDay;

              return Skeletonizer(
                enabled: isLoading,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 14.w,
                    right: 14.w,
                    bottom: 55.h,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      TripDetailsTopBar(
                        onBack: () => context.go(AppRoutes.myTrips),
                        onShare: () {
                          if (isLoading || trip == null || itinerary == null) {
                            return;
                          }
                          final RenderBox? box =
                              context.findRenderObject() as RenderBox?;
                          final sharePositionOrigin = box != null
                              ? box.localToGlobal(Offset.zero) & box.size
                              : null;

                          context.read<TripShareCubit>().shareTrip(
                            context: context,
                            trip: trip,
                            itinerary: itinerary,
                            sharePositionOrigin: sharePositionOrigin,
                          );
                        },
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 52.h)),
                      SliverList.separated(
                        itemCount: itinerary?.days.length ?? 0 + 3,
                        separatorBuilder: (_, index) {
                          return SizedBox(height: 42.h);
                        },
                        itemBuilder: (context, index) {
                          if (itinerary != null &&
                              index < itinerary.days.length) {
                            final day = itinerary.days[index];
                            return TripDayOverviewCard(
                              day: day,
                              tripCoverAsset: trip?.coverAsset ?? '',
                              isExpanded: day.dayNumber == expandedDay,
                              onToggle: () {
                                context
                                    .read<TripDetailsCubit>()
                                    .toggleActiveDay(day.dayNumber);
                              },
                              onRefine: () => AiRefinementSheet.show(
                                context,
                                trip?.id ?? '',
                                const [],
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 42.h)),

                      SliverToBoxAdapter(
                        child: TripMapPreviewCard(
                          days: itinerary?.days ?? [],
                          onViewMap: itinerary?.days.isEmpty ?? true
                              ? null
                              : () => context.push(
                                  AppRoutes.map,
                                  extra: MapTripExtra(
                                    days: itinerary?.days ?? [],
                                  ),
                                ),
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 42.h)),
                      SliverToBoxAdapter(
                        child: _EstimateNote(
                          estimatedTotalCost:
                              itinerary?.estimatedTotalCost ?? 0,
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 42.h)),

                      if ((trip?.status ?? TripStatus.draft) ==
                          TripStatus.completed)
                        const SliverToBoxAdapter(child: SizedBox.shrink())
                      else
                        SliverToBoxAdapter(
                          child: _SaveTripButton(
                            trip: trip ?? _dummyTrip,
                            onSave: () {
                              if (trip != null) {
                                _saveTrip(context, trip);
                              }
                            },
                          ),
                        ),
                      SliverToBoxAdapter(child: SizedBox(height: 42.h)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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

final _dummyTrip = Trip(
  id: 'skeleton',
  title: 'Loading Trip...',
  status: TripStatus.draft,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  destination: 'Loading Destination',
  adults: 2,
  children: 0,
  pets: 0,
  customBudget: '',
  interests: const [],
);

final _dummyItinerary = TripItinerary(
  tripId: 'skeleton',
  days: List.generate(
    3,
    (i) => TripDay(
      dayNumber: i + 1,
      title: 'Loading Day...',
      coverImageUrl: '',
      tags: const ['Category', 'Category'],
      stopCount: 3,
      estimatedCost: 1500,
      timeSlots: const [],
    ),
  ),
  estimatedTotalCost: 4500,
);
