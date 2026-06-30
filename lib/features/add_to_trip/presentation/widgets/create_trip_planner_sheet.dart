import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mindtrip/core/shared/presentation/widget/appp_dialog.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/add_to_trip/presentation/cubit/add_to_trip_state.dart';
import 'package:mindtrip/features/add_to_trip/presentation/widgets/drag_divider.dart';
import 'package:mindtrip/features/ai_planner/data/models/budget_tier_model.dart';
import 'package:mindtrip/features/ai_planner/presentation/data/ai_planner_mock_data.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/range_calendar.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';

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
            onDateSelected: (date) {
              if (state.startDate == null ||
                  (state.startDate != null && state.endDate != null)) {
                cubit.updateStartDate(date);
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

  void _showCustomBudgetDialog(BuildContext context, AddToTripState state) {
    final cubit = context.read<AddToTripCubit>();
    final controller = TextEditingController(text: state.customBudget);

    AppDialog.show(
      context: context,
      title: 'Custom Budget',
      description: 'Enter your preferred budget',
      primaryText: 'Save',
      secondaryText: 'Cancel',
      showIcon: false,
      child: StatefulBuilder(
        builder: (context, setState) {
          final text = controller.text.trim();
          final parsedBudget = int.tryParse(text) ?? 0;
          final canValidate = state.startDate != null && state.endDate != null;

          final tripDays = canValidate
              ? state.endDate!.difference(state.startDate!).inDays + 1
              : 0;
          final minimumBudget = tripDays > 0 ? tripDays * 1800 : 0;

          String? errorText;
          if (text.isNotEmpty && canValidate && parsedBudget < minimumBudget) {
            errorText =
                'Minimum budget is EGP $minimumBudget for $tripDays day(s)';
          }

          return TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Enter custom budget',
              errorText: errorText,
              filled: true,
              fillColor: AppColors.primaryLightGray,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 12.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: context.colorTheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: context.colorTheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(
                  color: context.colorTheme.primary,
                  width: 1.2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(color: context.colorTheme.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide(
                  color: context.colorTheme.error,
                  width: 1.2,
                ),
              ),
            ),
          );
        },
      ),
      onPrimary: () {
        cubit.updateCustomBudget(controller.text.trim());
      },
      onSecondary: () {},
    );
  }

  void _showLoading(BuildContext context, Widget dialog) {
    AppDialog.hideLoading(context);

    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => dialog,
    );
  }

  void _handleStatus(BuildContext context, AddToTripState state) {
    if (state.status == AddToTripStatus.generatingNewTripPlan) {
      _showLoading(
        context,
        const GeneratingDialog(
          title: 'Generating itinerary...',
          description: 'Our AI is creating the perfect trip for you.',
        ),
      );
      return;
    }

    if (state.status == AddToTripStatus.creatingTrip) {
      _showLoading(
        context,
        const GeneratingDialog(
          title: 'Saving trip...',
          description: 'Please wait while we save your trip.',
        ),
      );
      return;
    }

    if (state.status == AddToTripStatus.success) {
      AppDialog.hideLoading(context);

      AppDialog.show(
        context: context,
        icon: Icons.check_circle_outline,
        title: 'Trip Created!',
        description: 'Your trip to ${state.place.name} has been prepared.',
        primaryText: 'Check it now',
        onPrimary: () {
          final trip = state.createdTrip;
          if (trip == null) return;

          onClose();

          context.push(
            '${AppRoutes.tripDetails}?tripId=${trip.tripId}',
            extra: trip,
          );
        },
      );
      return;
    }

    if (state.status == AddToTripStatus.generateFailure ||
        state.status == AddToTripStatus.saveFailure) {
      AppDialog.hideLoading(context);
      AppGlassSnackBar.showError(context: context, message: state.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToTripCubit, AddToTripState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStatus,
      builder: (context, state) {
        final cubit = context.read<AddToTripCubit>();
        final interests = context.read<UserCubit>().state.interests;
        final budgetValidationMessage = state.budgetValidationMessage;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const DragDivider(),
              SizedBox(height: 24.h),
              _SheetHeader(onBack: onBack),
              SizedBox(height: 8.h),
              Text(
                'This is a quick overview. For a detailed itinerary.',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
              SizedBox(height: 33.h),
              _SectionCard(
                title: 'Duration',
                child: _DurationSection(
                  state: state,
                  onTapDate: () => _showCalendar(context),
                ),
              ),
              SizedBox(height: 16.h),
              _SectionCard(
                title: 'Budget',
                child: _BudgetSection(
                  state: state,
                  onSelectBudget: cubit.selectBudget,
                  onTapCustomBudget: () =>
                      _showCustomBudgetDialog(context, state),
                  validationMessage: budgetValidationMessage,
                ),
              ),
              SizedBox(height: 16.h),
              _SectionCard(
                title: 'Traveler',
                child: _TravelerSection(
                  adultCount: state.adultCount,
                  onDecrease: () => cubit.updateAdults(
                    state.adultCount > 1 ? state.adultCount - 1 : 1,
                  ),
                  onIncrease: () => cubit.updateAdults(state.adultCount + 1),
                ),
              ),
              SizedBox(height: 16.h),
              CustomGradientButton(
                width: double.infinity,
                onTap: state.canCreateTrip
                    ? () => cubit.createNewTripAndAdd(userInterests: interests)
                    : null,
                text: 'Create & Add',
              ),
              SizedBox(height: 40.h),
            ],
          ),
        );
      },
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}

class _DurationSection extends StatelessWidget {
  const _DurationSection({required this.state, required this.onTapDate});

  final AddToTripState state;
  final VoidCallback onTapDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DateField(
          label: 'Start date :',
          value: state.startDate != null
              ? DateFormat('dd MMM yyyy').format(state.startDate!)
              : null,
          onTap: onTapDate,
        ),
        SizedBox(height: 18.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Divider(height: 1, color: context.colorTheme.outlineVariant),
        ),
        SizedBox(height: 18.h),
        _DateField(
          label: 'End date :',
          value: state.endDate != null
              ? DateFormat('dd MMM yyyy').format(state.endDate!)
              : null,
          onTap: onTapDate,
        ),
      ],
    );
  }
}

class _BudgetSection extends StatelessWidget {
  const _BudgetSection({
    required this.state,
    required this.onSelectBudget,
    required this.onTapCustomBudget,
    required this.validationMessage,
  });

  final AddToTripState state;
  final ValueChanged<BudgetTierModel?> onSelectBudget;
  final VoidCallback onTapCustomBudget;
  final String? validationMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 14.w,
          runSpacing: 10.h,
          children: AiPlannerMockData.budgetTiers.map((b) {
            final selected =
                state.selectedBudget == b && state.customBudget.trim().isEmpty;

            return AnimatedContainer(
              margin: EdgeInsets.only(bottom: 10.r),
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
              child: TapScaleEffect(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                enableOverlay: false,
                onTap: () => onSelectBudget(b),
                child: Text(
                  '${b.title} - EGP ${b.amount}',
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
        SizedBox(height: 8.h),
        Text(
          'Or enter your custom budget',
          style: AppTextStyles.h9Medium.copyWith(
            color: context.colorTheme.outline,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.primaryLightGray,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: validationMessage != null
                  ? context.colorTheme.error
                  : state.customBudget.trim().isNotEmpty
                  ? context.colorTheme.primary
                  : context.colorTheme.outline,
            ),
          ),
          child: TapScaleEffect(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            onTap: onTapCustomBudget,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    state.customBudget.trim().isNotEmpty
                        ? 'EGP ${state.customBudget}'
                        : 'Enter custom budget',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h9Medium.copyWith(
                      color: state.customBudget.trim().isNotEmpty
                          ? context.colorTheme.onSurface
                          : context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.edit_outlined,
                  color: validationMessage != null
                      ? context.colorTheme.error
                      : context.colorTheme.primary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        if (validationMessage != null) ...[
          SizedBox(height: 8.h),
          Text(
            validationMessage!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorTheme.error,
            ),
          ),
        ],
      ],
    );
  }
}

class _TravelerSection extends StatelessWidget {
  const _TravelerSection({
    required this.adultCount,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int adultCount;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Adults',
          style: AppTextStyles.h8Medium.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        Row(
          children: [
            _CounterButton(icon: Icons.remove, onTap: onDecrease),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text('$adultCount', style: AppTextStyles.h7Bold),
            ),
            _CounterButton(icon: Icons.add, onTap: onIncrease),
          ],
        ),
      ],
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: context.colorTheme.outline),
      ),
      child: TapScaleEffect(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        onTap: onTap,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.h8Medium.copyWith(
            color: context.colorTheme.onSurface,
          ),
        ),
        SizedBox(height: 6.h),
        TapScaleEffect(
          enableOverlay: false,
          onTap: onTap,
          child: Container(
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
        ),
      ],
    );
  }
}
