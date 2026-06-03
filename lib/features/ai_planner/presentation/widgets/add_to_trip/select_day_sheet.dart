import 'package:flutter/material.dart' hide DayPeriod;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/core/widget/appp_dialog.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/add_to_trip/drag_divider.dart';

class SelectDaySheet extends StatelessWidget {
  const SelectDaySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.addingStatus == ActionStatus.processing) {
          AppDialog.showLoading(
            context: context,
            title: 'Adding to trip',
            description:
                'Please wait while our AI works its magic to create the perfect trip plan tailored to your preferences.',
          );
        } else {
          AppDialog.hideLoading(context);
        }

        if (state.addingStatus == ActionStatus.error) {
          AppSnackBar.showError(
            context: context,
            message: state.errorMessage ?? 'Failed to add to trip',
          );
        }
      },
      builder: (context, state) {
        // if (state.selectedTrip == null || state.selectedItinerary == null) {
        //   return const SizedBox.shrink();
        // }

        final tripTitle = state.selectedTrip!.title;
        final itinerary = state.selectedItinerary!;

        return Column(
          mainAxisSize: MainAxisSize.min,
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
                  final places = day.timeSlots
                      .expand((slot) => slot.places)
                      .toList();
                  final isDaySelected = day.dayNumber == state.selectedDay;
                  return TapScaleEffect(
                    onTap: () =>
                        context.read<AddToTripCubit>().selectDay(day.dayNumber),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 24.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isDaySelected
                              ? context.colorTheme.primary
                              : context.colorTheme.outline,
                        ),
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
                          if (places.isNotEmpty) ...[
                            SizedBox(height: 12.h),
                            ...places
                                .take(2)
                                .map(
                                  (place) => Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      "• ${place.name}",
                                      style: context.textTheme.bodyMedium
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
                                  horizontal: 10.w,
                                  vertical: 4,
                                ),
                                child: Text(
                                  '+${places.length - 2} more places',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: context.colorTheme.outline,
                                  ),
                                ),
                              ),
                            SizedBox(height: 12.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 4,
                              ),
                              child: Text(
                                'Includes ${day.stopCount} places',
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: AppColors.pureBlack,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.h),
            TapScaleEffect(
              onTap: () {
                context.read<AddToTripCubit>().addToTrip(); // Let AI decide
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryLightBlue1,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AiPlannerAssets.chatFaceIcon,
                      width: 42.w,
                      height: 42.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.pureBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 25.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Let AI Decide', style: AppTextStyles.h8Bold),
                          SizedBox(height: 7.h),
                          Text(
                            'Find the best day automatically',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.pureBlack,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.chevron_right,
                      size: 24.r,
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: CustomGradientButton(
                width: double.infinity,
                text: 'Add',
                onTap: state.selectedDay != null
                    ? () {
                        context.read<AddToTripCubit>().addToTrip();
                      }
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
