import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';
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
            borderRadius: BorderRadius.circular(44.r),
          ),
          insetPadding: EdgeInsets.all(20.r),
          child: RangeCalendar(
            startDate: state.startDate,
            endDate: state.endDate,
            onDateSelected: (date) {
              if (state.startDate == null || (state.startDate != null && state.endDate != null)) {
                cubit.updateStartDate(date);
                // Clear end date when starting a new selection
                // cubit.updateEndDate(null); 
              } else {
                if (date.isAfter(state.startDate!)) {
                  cubit.updateEndDate(date);
                } else {
                  cubit.updateStartDate(date);
                }
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.status == AddToTripStatus.loading) {
          AppDialog.showLoading(context: context);
        } else if (state.status == AddToTripStatus.success) {
          AppDialog.hideLoading(context);
          AppDialog.show(
            context: context,
            title: 'Trip Created!',
            description: 'Your trip with ${state.place.name} has been prepared.',
            primaryText: 'Awesome',
            onPrimary: onClose,
          );
        } else if (state.status == AddToTripStatus.failure) {
          AppDialog.hideLoading(context);
          AppGlassSnackBar.showError(context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        final cubit = context.read<AddToTripCubit>();
        return SingleChildScrollView(
          child: Column(
            children: [
              const DragDivider(),
              SizedBox(height: 24.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      onPressed: onBack,
                    ),
                  ),
                  Text('New Trip Details', style: AppTextStyles.h6Bold),
                ],
              ),
              SizedBox(height: 24.h),
              _SectionCard(
                title: 'When are you going?',
                child: Row(
                  children: [
                    Expanded(
                      child: _DateField(
                        label: 'Start Date',
                        value: state.startDate != null ? DateFormat('dd MMM yyyy').format(state.startDate!) : 'Select',
                        onTap: () => _showCalendar(context),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _DateField(
                        label: 'End Date',
                        value: state.endDate != null ? DateFormat('dd MMM yyyy').format(state.endDate!) : 'Select',
                        onTap: () => _showCalendar(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _SectionCard(
                title: 'Who is coming?',
                child: Row(
                  children: [
                    Expanded(
                      child: _CounterField(
                        label: 'Adults',
                        count: state.adultCount,
                        onDecrement: () => cubit.updateAdults(state.adultCount > 0 ? state.adultCount - 1 : 0),
                        onIncrement: () => cubit.updateAdults(state.adultCount + 1),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _CounterField(
                        label: 'Children',
                        count: state.childCount,
                        onDecrement: () => cubit.updateChildren(state.childCount > 0 ? state.childCount - 1 : 0),
                        onIncrement: () => cubit.updateChildren(state.childCount + 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _SectionCard(
                title: 'What is your budget?',
                child: Wrap(
                  spacing: 12.w,
                  runSpacing: 10.h,
                  children: AiPlannerMockData.budgetTiers.map((b) {
                    final isSelected = state.budget == b.title;
                    return ChoiceChip(
                      label: Text(b.title),
                      selected: isSelected,
                      onSelected: (val) => cubit.updateBudget(b.title),
                      selectedColor: context.colorTheme.primaryContainer,
                      labelStyle: TextStyle(
                        color: isSelected ? context.colorTheme.primary : context.colorTheme.onSurface,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 32.h),
              CustomGradientButton(
                width: double.infinity,
                onTap: (state.startDate != null && state.endDate != null && state.budget.isNotEmpty)
                    ? cubit.createNewTripAndAdd
                    : null,
                text: 'Create & Add',
              ),
              SizedBox(height: 48.h),
            ],
          ),
        );
      },
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
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.colorTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.h8Bold),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const _DateField({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapScaleEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: context.colorTheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.h10Medium.copyWith(color: context.colorTheme.outline)),
            SizedBox(height: 4.h),
            Text(value, style: AppTextStyles.h9Bold),
          ],
        ),
      ),
    );
  }
}

class _CounterField extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _CounterField({
    required this.label,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.colorTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.h10Medium.copyWith(color: context.colorTheme.outline)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.remove_circle_outline, size: 20),
                onPressed: onDecrement,
              ),
              Text('$count', style: AppTextStyles.h8Bold),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.add_circle_outline, size: 20),
                onPressed: onIncrement,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
