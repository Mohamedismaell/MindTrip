import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/ai_refinement_sheet.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_day_overview_card.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_details_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key, required this.tripId, this.trip});

  final String tripId;
  final Trip? trip;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripDetailsCubit>().initialize(
            widget.tripId,
            initialTrip: widget.trip,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (context.canPop()) {
          context.pop();
        }
      },
      child: BlocListener<TripDetailsCubit, TripDetailsState>(
        listenWhen: (previous, current) =>
            previous.actionStatus != current.actionStatus,
        listener: (context, state) {
          if (state.actionStatus == TripDetailsActionStatus.loading) {
            AppDialog.showLoading(context: context);
          } else if (state.actionStatus == TripDetailsActionStatus.error) {
            AppDialog.hideLoading(context);
            AppGlassSnackBar.showError(
              context: context,
              message: state.actionError ?? 'Operation failed',
            );
            context.read<TripDetailsCubit>().resetActionStatus();
          } else if (state.actionStatus == TripDetailsActionStatus.success) {
            AppDialog.hideLoading(context);
            context.read<TripsCubit>().loadTrips(silent: true);
            context.read<TripDetailsCubit>().resetActionStatus();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocBuilder<TripDetailsCubit, TripDetailsState>(
              builder: (context, state) {
                final isLoading = state.status == TripDetailsStatus.loading;
                final trip = state.trip;
                final plan = state.generatedPlan;

                if (state.status == TripDetailsStatus.error && trip == null) {
                  return _MessageState(
                    message: state.errorMessage ?? 'Error loading trip',
                  );
                }

                if (!isLoading && trip == null) {
                  return const _MessageState(message: 'Trip not found');
                }

                final double totalCost =
                    (trip?.totalCost ?? plan?.totalCalculatedCost ?? 0)
                        .toDouble();

                return Skeletonizer(
                  enabled: isLoading,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 14.w,
                      right: 14.w,
                      bottom: 20.h,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        TripDetailsTopBar(
                          onBack: () => context.canPop()
                              ? context.pop()
                              : context.go(AppRoutes.myTrips),
                          onShare: trip == null
                              ? null
                              : () => context.read<TripsCubit>().shareTrip(
                                  trip.tripId,
                                ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 24.h),
                            child: Hero(
                              tag: 'trip-image-${widget.tripId}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: AppCachedImage(
                                  imagePath: trip?.coverImageUrl ?? '',
                                  height: 200.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (plan != null)
                          SliverList.separated(
                            itemCount: plan.daysCount,
                            separatorBuilder: (_, _) => SizedBox(height: 42.h),
                            itemBuilder: (context, index) {
                              final dayNum = index + 1;
                              final dayPlan = plan.days[dayNum];
                              if (dayPlan == null) {
                                return const SizedBox.shrink();
                              }

                              return TripDayOverviewCard(
                                dayEntity: dayPlan,
                                dayNumber: dayNum,
                                tripCoverAsset: '',
                                isExpanded: dayNum == state.activeDay,
                                onToggle: () => context
                                    .read<TripDetailsCubit>()
                                    .onDayChanged(dayNum),
                                onRefine: () {
                                  AiRefinementSheet.show(
                                    context,
                                    plan.tripId,
                                    'refinement-${plan.tripId}',
                                    const [],
                                  );
                                },
                              );
                            },
                          )
                        else
                          const SliverToBoxAdapter(
                            child: Center(
                              child: Text('Trip details are not available.'),
                            ),
                          ),
                        SliverToBoxAdapter(child: SizedBox(height: 42.h)),
                        SliverToBoxAdapter(
                          child: _EstimateNote(estimatedTotalCost: totalCost),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 42.h)),
                        SliverToBoxAdapter(
                          child:
                              BlocBuilder<TripDetailsCubit, TripDetailsState>(
                                builder: (context, state) {
                                  final trip = state.trip;
                                  if (trip == null || isLoading) {
                                    return const SizedBox.shrink();
                                  }

                                  if (trip.status == TripStatus.completed) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20.h,
                                      ),
                                      child: CustomGradientButton(
                                        text: 'Write a Review',
                                        onTap: () {
                                          // Todo: Show review sheet
                                        },
                                        width: double.infinity,
                                      ),
                                    );
                                  }

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.h,
                                    ),
                                    child: CustomGradientButton(
                                      text: trip.status == TripStatus.draft
                                          ? 'Start Trip'
                                          : 'Mark Completed',
                                      onTap: () {
                                        final nextStatus =
                                            trip.status == TripStatus.draft
                                            ? 1
                                            : 2;
                                        context
                                            .read<TripDetailsCubit>()
                                            .changeTripStatus(nextStatus);
                                      },
                                      width: double.infinity,
                                    ),
                                  );
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
