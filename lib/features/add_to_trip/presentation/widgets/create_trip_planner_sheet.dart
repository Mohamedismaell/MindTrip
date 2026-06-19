import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_snackbar.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/range_calendar.dart';

class CreateTripPlannerSheet extends StatelessWidget {
  const CreateTripPlannerSheet({
    super.key,
    required this.onBack,
    required this.onClose,
  });

  final VoidCallback onBack;
  final VoidCallback onClose;

  void _showCalendar(BuildContext context) {
    final cubit = context.read<AddToTripCubit>();
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<AddToTripCubit, AddToTripState>(
        bloc: cubit,
        builder: (context, state) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(48.r),
          ),
          insetPadding: EdgeInsets.all(20.r),
          child: RangeCalendar(
            startDate: state.startDate,
            endDate: state.endDate,
            onDateSelected: cubit.selectTripDate,
          ),
        ),
      ),
    );
  }

  void _onGenerate(BuildContext context) {
    context.read<AddToTripCubit>().quickGenerateTrip();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.creatingStatus == ActionStatus.processing ||
            state.addingStatus == ActionStatus.processing) {
          AppDialog.showLoading(
            context: context,
            title: state.loadingTitle,
            description: state.loadingDescription,
          );
        } else if (state.creatingStatus == ActionStatus.error ||
            state.addingStatus == ActionStatus.error) {
          AppDialog.hideLoading(context);
          if (state.errorMessage != null) {
            AppSnackBar.showError(
              context: context,
              message: state.errorMessage!,
            );
          }
        } else if (state.creatingStatus == ActionStatus.success &&
            state.addingStatus == ActionStatus.success) {
          AppDialog.hideLoading(context);
          AppDialog.show(
            context: context,
            title: 'Your trip has been generated',
            primaryText: 'Continue Exploring',
            icon: Icons.check_circle_outline_outlined,
            // iconColor: AppColors.customgreeen,
            onPrimary: () {
              context.read<AddToTripCubit>().reset();
              onClose();
            },
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddToTripCubit>();
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DragDivider(),
              SizedBox(height: 24.h),
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
                    child: Text(
                      'Quick AI Trip Planning',
                      style: AppTextStyles.h6Bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'This is a quick overview. For a detailed itinerary. ',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
              SizedBox(height: 33.h),
              _SectionCard(
                title: 'Duration',
                child: Column(
                  children: [
                    _DateField(
                      label: 'Start date :',
                      value: state.formattedStartDate,
                      onTap: () => _showCalendar(context),
                    ),
                    SizedBox(height: 18.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Divider(
                        height: 1,
                        color: context.colorTheme.outlineVariant,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    _DateField(
                      label: 'End date :',
                      value: state.formattedEndDate,
                      onTap: () => _showCalendar(context),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _SectionCard(
                title: 'Budget',
                child: Wrap(
                  spacing: 14.w,
                  children: AiPlannerMockData.budgetTiers.map((b) {
                    final selected = state.selectedBudget == b.title;
                    return TapScaleEffect(
                      onTap: () => cubit.updateBudget(b.title),
                      child: AnimatedContainer(
                        margin: EdgeInsets.only(bottom: 10.r),
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.primaryLightBlue1
                              : context.colorTheme.surface,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: selected
                                ? context.colorTheme.primary
                                : context.colorTheme.outline,
                          ),
                        ),
                        child: Text(
                          b.title,
                          style: AppTextStyles.h9Medium.copyWith(
                            color: selected
                                ? context.colorTheme.primary
                                : context.colorTheme.outline,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.h),
              _SectionCard(
                title: 'Traveler',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Traveler',
                      style: AppTextStyles.h8Medium.copyWith(
                        color: context.colorTheme.onSurface,
                      ),
                    ),
                    Row(
                      children: [
                        _CounterButton(
                          icon: Icons.remove,
                          onTap: () =>
                              cubit.updatePeople(state.numberOfPeople - 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            '${state.numberOfPeople}',
                            style: AppTextStyles.h7Bold,
                          ),
                        ),
                        _CounterButton(
                          icon: Icons.add,
                          onTap: () =>
                              cubit.updatePeople(state.numberOfPeople + 1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              CustomGradientButton(
                width: double.infinity,
                onTap: state.isPlanReady ? () => _onGenerate(context) : null,
                text: 'Generate Plan',
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: context.colorTheme.outline),
        ),
        child: Icon(icon, size: 20.sp, color: context.colorTheme.primary),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorTheme.outline),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h7Bold),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.h8Medium.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primaryLightGray,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value ?? 'Select date',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: value != null
                        ? context.colorTheme.onSurface
                        : context.colorTheme.onSurfaceVariant,
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: context.colorTheme.primary,
                  size: 22.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
