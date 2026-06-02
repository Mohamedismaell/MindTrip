import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/time_slot.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';

class SelectDaySheet extends StatelessWidget {
  const SelectDaySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.status == AddToTripStatus.error && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
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
            left: 24.w,
            right: 24.w,
            top: 24.h,
            bottom: MediaQuery.of(context).padding.bottom + 24.h,
          ),
          decoration: BoxDecoration(
            color: context.colorTheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16.h),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        context.read<AddToTripCubit>().loadTrips();
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'Add to $tripTitle',
                          style: AppTextStyles.h6Bold.copyWith(color: context.colorTheme.onSurface),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Choose where to add it',
                          style: context.textTheme.bodyMedium?.copyWith(color: context.colorTheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              if (state.status == AddToTripStatus.processing)
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              else ...[
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: itinerary.days.length,
                    itemBuilder: (context, index) {
                      final day = itinerary.days[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryLightBlue1),
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primaryLightBlue1.withOpacity(0.1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16, color: AppColors.primaryBlue),
                                SizedBox(width: 8.w),
                                Text('Day ${day.dayNumber}', style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: DayPeriod.values.map((period) {
                                return InkWell(
                                  onTap: () {
                                    if (state.status == AddToTripStatus.managing) {
                                      context.read<AddToTripCubit>().moveToDay(day.dayNumber, period);
                                    } else {
                                      context.read<AddToTripCubit>().addToTrip(dayNumber: day.dayNumber, period: period);
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                    decoration: BoxDecoration(
                                      color: AppColors.pureWhite,
                                      border: Border.all(color: context.colorTheme.outline),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      period.name[0].toUpperCase() + period.name.substring(1),
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 12.h),
                            Text('Includes ${day.stopCount} places', style: context.textTheme.bodyMedium?.copyWith(color: context.colorTheme.onSurfaceVariant)),
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
                        const Icon(Icons.auto_awesome, color: AppColors.primaryBlue),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Let AI Decide', style: context.textTheme.bodyLarge?.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                            Text('Find the best day automatically', style: context.textTheme.bodySmall?.copyWith(color: AppColors.primaryBlue)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
