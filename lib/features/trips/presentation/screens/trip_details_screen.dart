import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_head_line.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/trips/domain/entities/trip_details_args.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trip_details_state.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/ai_refinement_sheet.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_day_overview_card.dart';
import 'package:mindtrip/features/trips/presentation/widgets/trip_details/trip_details_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key, required this.args});

  final TripDetailsArgs args;

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
                    bottom: 55.h,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      TripDetailsTopBar(
                        onBack: () => context.go(AppRoutes.myTrips),
                        onShare: trip == null ? null : () {},
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 52.h)),
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
