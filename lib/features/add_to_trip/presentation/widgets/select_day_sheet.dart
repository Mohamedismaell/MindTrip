import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/day_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';

class SelectDaySheet extends StatelessWidget {
  const SelectDaySheet({
    super.key,
    this.scrollController,
    required this.onBack,
    required this.onClose,
  });

  final ScrollController? scrollController;
  final VoidCallback onBack;
  final VoidCallback onClose;

  void _showLoading(BuildContext context, Widget dialog) {
    AppDialog.hideLoading(context);

    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AddToTripStatus.updatingTrip) {
          _showLoading(
            context,
            const GeneratingDialog(
              title: 'Saving changes...',
              description: 'Updating your trip plan.',
            ),
          );
        } else if (state.status == AddToTripStatus.success) {
          AppDialog.hideLoading(context);
          onClose();
        } else if (state.status == AddToTripStatus.initial) {
          AppDialog.hideLoading(context);
        } else if (state.status == AddToTripStatus.generateFailure ||
            state.status == AddToTripStatus.saveFailure) {
          AppDialog.hideLoading(context);
          AppGlassSnackBar.showError(
            context: context,
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        final trip = state.selectedTrip;
        if (trip == null) {
          return const SizedBox.shrink();
        }

        final tripTitle = trip.title;
        final totalDays = trip.plan.daysCount > 0
            ? trip.plan.daysCount
            : (trip.durationDays > 0 ? trip.durationDays : 1);

        return Column(
          children: [
            const DragDivider(),
            SizedBox(height: 16.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBack,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: Column(
                    children: [
                      Text(
                        'Add to $tripTitle',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h6Bold.copyWith(
                          color: AppColors.pureBlack,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Choose where to add it',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorTheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: totalDays,
                itemBuilder: (context, index) {
                  final dayNum = index + 1;
                  final dayPlan =
                      trip.plan.days[dayNum] ??
                      const DayPlanEntity(
                        morning: [],
                        afternoon: [],
                        evening: [],
                      );
                  final places = dayPlan.allPlaces;
                  final dayKey = 'day$dayNum';
                  final isDaySelected = dayKey == state.selectedDay;

                  return Container(
                    margin: EdgeInsets.only(bottom: 24.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDaySelected
                            ? context.colorTheme.primary
                            : context.colorTheme.outline,
                        width: isDaySelected ? 1.5 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TapScaleEffect(
                          onTap: () =>
                              context.read<AddToTripCubit>().selectDay(dayKey),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20.r,
                                color: AppColors.pureBlack,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Day $dayNum',
                                style: context.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: PlaceDayPeriod.values.map((period) {
                            final isSelected =
                                state.selectedDay == dayKey &&
                                state.selectedPeriod == period;

                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: TapScaleEffect(
                                  onTap: () {
                                    context
                                        .read<AddToTripCubit>()
                                        .selectDayAndPeriod(dayKey, period);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOutCubic,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? context.colorTheme.primary
                                          : context.colorTheme.surface,
                                      border: Border.all(
                                        color: isSelected
                                            ? context.colorTheme.primary
                                            : context.colorTheme.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      period.name.capitalize(),
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.h9SemiBold.copyWith(
                                        color: isSelected
                                            ? Colors.white
                                            : context.colorTheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        if (places.isNotEmpty) ...[
                          SizedBox(height: 16.h),
                          ...places
                              .take(2)
                              .map(
                                (place) => Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.h,
                                  ),
                                  child: Text(
                                    '• ${place.name}',
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                          color: context
                                              .colorTheme
                                              .onSurfaceVariant,
                                        ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                          if (places.length > 2)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              child: Text(
                                '+${places.length - 2} more places',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorTheme.outline,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            child: Text(
                              'Includes ${places.length} places',
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Builder(
                builder: (context) {
                  final trip = state.selectedTrip;
                  final isAlreadyInTrip = trip != null &&
                      trip.plan.days.values.any(
                        (day) => day.allPlaces.any(
                          (p) => p.placeId == state.place.id,
                        ),
                      );

                  return CustomGradientButton(
                    width: double.infinity,
                    text: isAlreadyInTrip ? 'Move' : 'Add',
                    onTap: state.canAddToExistingTrip
                        ? () {
                            context.read<AddToTripCubit>().addToExistingTrip(
                              isMoveMode: isAlreadyInTrip,
                            );
                          }
                        : null,
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }
}
