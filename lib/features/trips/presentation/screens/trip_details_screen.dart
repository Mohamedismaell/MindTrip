import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
import 'package:mindtrip/features/trips/domain/entities/trip_details_args.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/ai_refinement_sheet.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_day_overview_card.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_details_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TripDetailsScreen extends StatefulWidget {
  final TripDetailsArgs args;
  const TripDetailsScreen({super.key, required this.args});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripDetailsCubit>().initialize(widget.args);
    });
  }

  Future<void> _saveTrip(BuildContext context) async {
    AppDialog.show(
      context: context,
      title: 'Save Trip',
      description: 'You can access this itinerary anytime from My Trips.',
      primaryText: 'Save',
      secondaryText: 'Cancel',
      icon: Icons.check_circle,
      onPrimary: () async {
        await context.read<TripDetailsCubit>().saveTrip();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TripDetailsCubit, TripDetailsState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == TripDetailsStatus.saving) {
          AppDialog.showLoading(context: context);
        } else if (state.status == TripDetailsStatus.saved) {
          AppDialog.hideLoading(context);
          AppGlassSnackBar.showSuccess(
            context: context,
            message: 'Trip saved successfully',
          );
          context.go(AppRoutes.myTrips);
        } else if (state.status == TripDetailsStatus.error) {
          AppDialog.hideLoading(context);
          AppGlassSnackBar.showError(
            context: context,
            message: state.errorMessage ?? 'An error occurred',
          );
        }
      },
      // child: BlocListener<TripShareCubit, TripShareState>(
      // listener: (context, state) {
      //   if (state is TripShareLoading) {
      //     AppDialog.showLoading(context: context);
      //   } else if (state is TripShareSuccess) {
      //     AppDialog.hideLoading(context);
      //   } else if (state is TripShareError) {
      //     AppDialog.hideLoading(context);
      //     AppGlassSnackBar.showError(context: context, message: state.message);
      //   }
      // },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          context.go(AppRoutes.myTrips);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocBuilder<TripDetailsCubit, TripDetailsState>(
              builder: (context, state) {
                final isLoading = state.status == TripDetailsStatus.loading;

                if (state.status == TripDetailsStatus.error &&
                    state.trip == null &&
                    state.generatedPlan == null) {
                  return _MessageState(
                    message: state.errorMessage ?? 'Error loading trip',
                  );
                }

                // Data handles
                final trip = state.trip;
                final plan = state.generatedPlan;
                final isUnsaved = state.isUnsaved;

                // Normalized data for UI
                final double totalCost =
                    (trip?.totalCost ?? plan?.totalCalculatedCost ?? 0)
                        .toDouble();

                if (!isLoading && trip == null && plan == null) {
                  return const _MessageState(message: 'Trip not found');
                }

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
                          onShare: isUnsaved
                              ? null
                              : () {
                                  // if (isLoading || trip == null) return;
                                  // final RenderBox? box =
                                  //     context.findRenderObject() as RenderBox?;
                                  // final sharePositionOrigin = box != null
                                  //     ? box.localToGlobal(Offset.zero) &
                                  //           box.size
                                  //     : null;

                                  // context.read<TripShareCubit>().shareTrip(
                                  //   context: context,
                                  //   trip: trip,
                                  //   itinerary:
                                  //       null, // Update ShareCubit if needed
                                  //   sharePositionOrigin: sharePositionOrigin,
                                  // );
                                },
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 52.h)),

                        // Days List
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
                                    .toggleActiveDay(dayNum),
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
                        else if (trip != null)
                          // Handle saved trip display (legacy or updated)
                          const SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                "Saved Trip Details Implementation...",
                              ),
                            ),
                          ),

                        SliverToBoxAdapter(child: SizedBox(height: 42.h)),

                        SliverToBoxAdapter(
                          child: _EstimateNote(estimatedTotalCost: totalCost),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 42.h)),

                        if (!isUnsaved &&
                            (trip?.status == TripStatus.completed))
                          const SliverToBoxAdapter(child: SizedBox.shrink())
                        else
                          SliverToBoxAdapter(
                            child: _SaveTripButton(
                              isUnsaved: isUnsaved,
                              onSave: () => _saveTrip(context),
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
      // ),
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
  const _SaveTripButton({required this.isUnsaved, required this.onSave});

  final bool isUnsaved;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: CustomGradientButton(
        onTap: isUnsaved ? onSave : null,
        text: isUnsaved ? 'Save Trip' : 'Trip Saved',
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
