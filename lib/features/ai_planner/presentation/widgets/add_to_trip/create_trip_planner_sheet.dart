import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/add_to_trip_state.dart';
import 'package:intl/intl.dart';

class CreateTripPlannerSheet extends StatefulWidget {
  const CreateTripPlannerSheet({super.key});

  @override
  State<CreateTripPlannerSheet> createState() => _CreateTripPlannerSheetState();
}

class _CreateTripPlannerSheetState extends State<CreateTripPlannerSheet> {
  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedBudget = 'Economic';
  final _peopleController = TextEditingController(text: '1');

  final _budgetOptions = ['Economic', 'Comfortable', 'Luxury'];
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _peopleController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? (_startDate ?? DateTime.now()));
    final first = isStart ? DateTime.now() : (_startDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: DateTime.now().add(const Duration(days: 730)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primaryBlue,
            onPrimary: AppColors.pureWhite,
            surface: context.colorTheme.surface,
          ),
        ),
        child: child!,
      ),
    );

    if (picked == null) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        // Reset end date if it's before the new start
        if (_endDate != null && _endDate!.isBefore(picked)) _endDate = null;
      } else {
        _endDate = picked;
      }
    });
  }

  void _onGenerate(BuildContext context) {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select start and end dates')),
      );
      return;
    }
    final people = int.tryParse(_peopleController.text) ?? 1;
    context.read<AddToTripCubit>().quickGenerateTrip(
      startDate: _startDate!,
      endDate: _endDate!,
      budgetTier: _selectedBudget,
      numberOfPeople: people,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToTripCubit, AddToTripState>(
      listener: (context, state) {
        if (state.status == AddToTripStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          left: 24.w,
          right: 24.w,
          top: 20.h,
          bottom: MediaQuery.of(context).padding.bottom + 24.h,
        ),
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 48.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLightGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 24.h),

              // Title
              Text(
                'Quick AI Trip Planning',
                style: AppTextStyles.h7Bold.copyWith(
                  color: context.colorTheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6.h),

              // Subtitle with link
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorTheme.onSurfaceVariant,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'This is a quick overview. For a detailed itinerary,\nreturn to the ',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          context.go(AppRoutes.aiPlannerIntro);
                        },
                        child: Text(
                          'AI trip planner',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryBlue,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Duration card
              _SectionCard(
                title: 'Duration',
                child: Column(
                  children: [
                    _DateField(
                      label: 'Start date :',
                      value: _startDate != null
                          ? _dateFormat.format(_startDate!)
                          : null,
                      onTap: () => _pickDate(isStart: true),
                    ),
                    Divider(
                      height: 1,
                      color: context.colorTheme.outlineVariant,
                    ),
                    _DateField(
                      label: 'End date :',
                      value: _endDate != null
                          ? _dateFormat.format(_endDate!)
                          : null,
                      onTap: () => _pickDate(isStart: false),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // Budget card
              _SectionCard(
                title: 'Budget',
                child: Wrap(
                  spacing: 8.w,
                  children: _budgetOptions.map((b) {
                    final selected = _selectedBudget == b;
                    return ChoiceChip(
                      label: Text(b),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedBudget = b),
                      selectedColor: AppColors.primaryLightBlue1,
                      labelStyle: context.textTheme.bodyMedium?.copyWith(
                        color: selected
                            ? AppColors.primaryBlue
                            : context.colorTheme.onSurface,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: selected
                              ? AppColors.primaryBlue
                              : context.colorTheme.outline,
                        ),
                      ),
                      backgroundColor: context.colorTheme.surface,
                      showCheckmark: false,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.h),

              // Number of people card
              _SectionCard(
                title: 'Number of people',
                child: TextField(
                  controller: _peopleController,
                  keyboardType: TextInputType.number,
                  style: context.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                    hintText: '1',
                    hintStyle: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // Generate Plan button
              BlocBuilder<AddToTripCubit, AddToTripState>(
                builder: (context, state) {
                  final isLoading = state.status == AddToTripStatus.processing;
                  return SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _onGenerate(context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: isLoading
                              ? null
                              : AppColors.blueLightGradient,
                          color: isLoading ? AppColors.primaryLightGray : null,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Center(
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryBlue,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  'Generate Plan',
                                  style: AppTextStyles.h9Bold.copyWith(
                                    color: AppColors.pureWhite,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Reusable card that wraps a section with a bold title and rounded border.
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorTheme.outlineVariant),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h9Bold.copyWith(
              color: context.colorTheme.onSurface,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

/// A tappable date display row inside the Duration card.
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
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
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
                  color: AppColors.primaryBlue,
                  size: 20.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
