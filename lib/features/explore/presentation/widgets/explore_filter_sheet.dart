import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/custom_otlined_button.dart';

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      // barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) => const ExploreFilterSheet(),
      useRootNavigator: true,
    );
  }

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  //! Dummy models
  // States
  RangeValues _priceRange = const RangeValues(100, 600);
  int _selectedRating = 1; // 0 = 2+,  1 = 3+
  int _selectedDuration = 1; // index
  Set<int> _selectedTripTypes = {0, 2}; // Beach, Adventure
  Set<int> _selectedLocations = {0, 1}; // South Sinai, Cairo

  static const _ratings = ['1+', '2+', '3+', '4+', '5+'];
  static const _durations = ['1 day', '2-3 days', '4-7 days', '1 week+'];
  static const _tripTypes = [
    ('🏖️', 'Beach'),
    ('⛰️', 'Mountain'),
    ('🏕️', 'Adventure'),
    ('🏙️', 'City break'),
    ('💎', 'Luxury'),
    ('💰', 'Budget'),
  ];
  static const _locations = [
    'South Sinai',
    'Cairo',
    'Dahab',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Fayoum',
  ];

  void _resetAll() {
    setState(() {
      _priceRange = const RangeValues(0, 1000);
      _selectedRating = -1;
      _selectedDuration = -1;
      _selectedTripTypes = {};
      _selectedLocations = {};
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => context.pop(),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.82,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: context.colorTheme.surface,
              borderRadius: BorderRadius.all(Radius.circular(24.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Drag handle
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, bottom: 8.h),
                    child: Container(
                      width: 90.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: context.colorTheme.outline,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),

                  //  Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style: AppTextStyles.h6SemiBold.copyWith(
                          // fontWeight: FontWeight.w700,
                        ),
                      ),
                      GestureDetector(
                        onTap: _resetAll,
                        child: Text(
                          'Reset All',
                          style: AppTextStyles.h8SemiBold.copyWith(
                            color: context.colorTheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.h),

                  // content
                  Expanded(
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      interactive: true,
                      trackVisibility: false,
                      radius: Radius.circular(12.r),
                      thickness: 4.w,
                      child: ListView(
                        controller: scrollController,
                        children: [
                          SizedBox(height: 12.h),

                          // Price Range
                          _SectionLabel(label: 'Price Range'),
                          SizedBox(height: 8.h),
                          _PriceDisplay(range: _priceRange),
                          SizedBox(height: 4.h),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              padding: EdgeInsets.zero,
                              trackHeight: 10.h,
                              activeTrackColor: context.colorTheme.primary,
                              inactiveTrackColor: AppColors.primaryShadow,
                              thumbColor: context.colorTheme.primary,
                              overlayColor: context.colorTheme.primary,
                              rangeThumbShape: RoundRangeSliderThumbShape(
                                enabledThumbRadius: 10.r,
                              ),
                              tickMarkShape: SliderTickMarkShape.noTickMark,
                            ),
                            child: RangeSlider(
                              values: _priceRange,
                              min: 0,
                              max: 1000,
                              divisions: 20,
                              onChanged: (v) => setState(() => _priceRange = v),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '0\$',
                                  style: AppTextStyles.h8SemiBold.copyWith(
                                    color: context.colorTheme.outline,
                                  ),
                                ),
                                Text(
                                  '500\$',
                                  style: AppTextStyles.h8SemiBold.copyWith(
                                    color: context.colorTheme.outline,
                                  ),
                                ),
                                Text(
                                  '1000\$',
                                  style: AppTextStyles.h8SemiBold.copyWith(
                                    color: context.colorTheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 28.h),
                          // Minimum Rating
                          _SectionLabel(label: 'Minimum Rating'),
                          SizedBox(height: 12.h),
                          //! needs to be editing as ui
                          Wrap(
                            spacing: 14.w,
                            runSpacing: 10.h,
                            children: List.generate(_ratings.length, (i) {
                              final isActive = _selectedRating == i;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedRating = i),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: isActive
                                        ? AppColors.primaryLightBlue1
                                              .withValues(alpha: 0.35)
                                        : context.colorTheme.surface,
                                    border: Border.all(
                                      color: isActive
                                          ? AppColors.primaryBlue.withValues(
                                              alpha: 0.5,
                                            )
                                          : context.colorTheme.outline
                                                .withValues(alpha: 0.3),
                                      width: isActive ? 1.2 : 0.8,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: AppColors.customYellow,
                                        size: 18.sp,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        _ratings[i],
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 24.h),

                          // Duration
                          _SectionLabel(label: 'Duration'),
                          SizedBox(height: 12.h),
                          //! edit to real data
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: List.generate(_durations.length, (i) {
                              return _SelectableChip(
                                label: _durations[i],
                                isSelected: _selectedDuration == i,
                                onTap: () =>
                                    setState(() => _selectedDuration = i),
                              );
                            }),
                          ),
                          SizedBox(height: 24.h),

                          // Trip Type
                          _SectionLabel(label: 'Trip Type'),
                          SizedBox(height: 12.h),
                          //! edit to real data
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: List.generate(_tripTypes.length, (i) {
                              final isActive = _selectedTripTypes.contains(i);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isActive) {
                                      _selectedTripTypes.remove(i);
                                    } else {
                                      _selectedTripTypes.add(i);
                                    }
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.r),
                                    color: isActive
                                        ? AppColors.primaryLightBlue1
                                              .withValues(alpha: 0.25)
                                        : context.colorTheme.surface,
                                    border: Border.all(
                                      color: isActive
                                          ? context.colorTheme.primary
                                                .withValues(alpha: 0.45)
                                          : context.colorTheme.outline
                                                .withValues(alpha: 0.3),
                                      width: isActive ? 1.2 : 0.8,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _tripTypes[i].$1,
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(
                                        _tripTypes[i].$2,
                                        style: AppTextStyles.h8SemiBold,
                                      ),
                                      SizedBox(width: 8.w),
                                      Icon(
                                        isActive
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        size: 16.sp,
                                        color: isActive
                                            ? context.colorTheme.primary
                                            : context.colorTheme.outline,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 24.h),

                          // Location
                          _SectionLabel(label: 'Location'),
                          SizedBox(height: 12.h),
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
                            children: List.generate(_locations.length, (i) {
                              final isActive = _selectedLocations.contains(i);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (isActive) {
                                      _selectedLocations.remove(i);
                                    } else {
                                      _selectedLocations.add(i);
                                    }
                                  });
                                },
                                child: _SelectableChip(
                                  label: _locations[i],
                                  isSelected: isActive,
                                  onTap: () {
                                    setState(() {
                                      if (isActive) {
                                        _selectedLocations.remove(i);
                                      } else {
                                        _selectedLocations.add(i);
                                      }
                                    });
                                  },
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),

                  // Bottom bar
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 40.h,
                    ),
                    child: GestureDetector(
                      //Todo add funcitonality
                      onTap: () => context.pop(),
                      child: CustomOtlinedButton(
                        onPressed: () {},
                        text: 'Show Results',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.h8SemiBold.copyWith(
        color: context.colorTheme.outline,
      ),
    );
  }
}

class _PriceDisplay extends StatelessWidget {
  const _PriceDisplay({required this.range});
  final RangeValues range;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.labelMedium!;
    return RichText(
      text: TextSpan(
        style: context.textTheme.bodyLarge?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: context.colorTheme.onSurface,
        ),
        children: [
          TextSpan(
            text: 'From ',
            style: textStyle.copyWith(color: context.colorTheme.onSurface),
          ),
          TextSpan(
            text: '${range.start.round()}\$',
            style: textStyle.copyWith(color: context.colorTheme.primary),
          ),
          TextSpan(
            text: ' to ',
            style: textStyle.copyWith(color: context.colorTheme.onSurface),
          ),
          TextSpan(
            text: '${range.end.round()}\$',
            style: textStyle.copyWith(color: context.colorTheme.primary),
          ),
        ],
      ),
    );
  }
}

class _SelectableChip extends StatelessWidget {
  const _SelectableChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: isSelected
              ? AppColors.primaryLightBlue1.withValues(alpha: 0.25)
              : context.colorTheme.surface,
          border: Border.all(
            color: isSelected
                ? context.colorTheme.primary.withValues(alpha: 0.45)
                : context.colorTheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 1.2 : 0.8,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.h8SemiBold.copyWith(
            color: isSelected
                ? context.colorTheme.onSurface
                : context.colorTheme.outline,
          ),
        ),
      ),
    );
  }
}
