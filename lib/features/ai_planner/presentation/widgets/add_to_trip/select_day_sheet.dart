import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/drag_divider.dart';

class SelectDaySheet extends StatelessWidget {
  const SelectDaySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.addingStatus == ActionStatus.error &&
            state.errorMessage != null) {
          AppSnackBar.showError(
            context: context,
            message: state.errorMessage ?? 'Failed to add to trip',
          );
        }
      },
      builder: (context, state) {
        if (state.selectedTrip == null || state.selectedItinerary == null) {
          return const SizedBox.shrink();
        }

        final tripTitle = state.selectedTrip!.title;
        final itinerary = state.selectedItinerary!;

        return Container(
          padding: EdgeInsets.only(
            left: 30.w,
            right: 30.w,
            top: 29.h,
            bottom: 24.h,
          ),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DragDivider(),
              SizedBox(height: 16.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.read<AddToTripCubit>().backToSelectTrip();
                      },
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
                            color: context.colorTheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Choose where to add it',
                          textAlign: TextAlign.center,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorTheme.onSurfaceVariant,
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
                  itemCount: itinerary.days.length,
                  itemBuilder: (context, index) {
                    final day = itinerary.days[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 24.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colorTheme.outline),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20.r,
                                color: AppColors.pureBlack,
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Day ${day.dayNumber}',
                                style: context.textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: DayPeriod.values.map((period) {
                              return InkWell(
                                onTap: () {
                                  if (state.flowStatus ==
                                      AddToTripFlowStatus.managing) {
                                    context.read<AddToTripCubit>().moveToDay(
                                      day.dayNumber,
                                      period,
                                    );
                                  } else {
                                    context.read<AddToTripCubit>().addToTrip(
                                      dayNumber: day.dayNumber,
                                      period: period,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.pureWhite,
                                    border: Border.all(
                                      color: context.colorTheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    period.name[0].toUpperCase() +
                                        period.name.substring(1),
                                    style: context.textTheme.bodyMedium,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Includes ${day.stopCount} places',
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () {
                  context.read<AddToTripCubit>().addToTrip(); // Let AI decide
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLightBlue1,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: AppColors.primaryBlue,
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Let AI Decide',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Find the best day automatically',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
