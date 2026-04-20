import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

/// Filter bottom sheet matching the Explore screen design.
///
/// Shows: Price Range slider, Minimum Rating chips, Duration chips,
/// Trip Type chips, Location chips, and a Show Results button.
class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key});

  /// Shows the filter bottom sheet.
  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ExploreFilterSheet(),
    );
  }

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  // ── State ───────────────────────────────────────────────────
  RangeValues _priceRange = const RangeValues(100, 600);
  int _selectedRating = 1; // 0 = 2+,  1 = 3+
  int _selectedDuration = 1; // index
  Set<int> _selectedTripTypes = {0, 2}; // Beach, Adventure
  Set<int> _selectedLocations = {0, 1}; // South Sinai, Cairo

  static const _ratings = ['2+', '3+'];
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
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.92,
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
                  padding: EdgeInsets.only(
                    top: 30.h,
                    bottom: 8.h,
                    // left: 20.w,
                    // right: 20.w,
                  ),
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
                  child: ListView(
                    controller: scrollController,
                    // padding: EdgeInsets.symmetric(horizontal: 23.w),
                    children: [
                      SizedBox(height: 12.h),

                      // Price Range
                      _SectionLabel(label: 'Price Range'),
                      SizedBox(height: 8.h),
                      _PriceDisplay(range: _priceRange),
                      SizedBox(height: 4.h),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10.h,
                          activeTrackColor: AppColors.primaryBlue,
                          inactiveTrackColor: AppColors.primaryShadow,
                          thumbColor: AppColors.primaryBlue,
                          // overlayColor: AppColors.primaryBlue.withOpacity(0.12),
                          rangeThumbShape: RoundRangeSliderThumbShape(
                            enabledThumbRadius: 10.r,
                          ),
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
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '0\$',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                            Text(
                              '500\$',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                            Text(
                              '1000\$',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorTheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // ── Minimum Rating ──────────────────
                      _SectionLabel(label: 'Minimum Rating'),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 12.w,
                        children: List.generate(_ratings.length, (i) {
                          final isActive = _selectedRating == i;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedRating = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: isActive
                                    ? AppColors.primaryLightBlue1.withOpacity(
                                        0.35,
                                      )
                                    : context.colorTheme.surface,
                                border: Border.all(
                                  color: isActive
                                      ? AppColors.primaryBlue.withOpacity(0.5)
                                      : context.colorTheme.outline.withOpacity(
                                          0.3,
                                        ),
                                  width: isActive ? 1.2 : 0.8,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ...List.generate(
                                    i == 0 ? 2 : 3,
                                    (_) => Icon(
                                      Icons.star_rounded,
                                      size: 16.sp,
                                      color: AppColors.customYellow,
                                    ),
                                  ),
                                  if (i == 0)
                                    ...List.generate(
                                      3,
                                      (_) => Icon(
                                        Icons.star_border_rounded,
                                        size: 16.sp,
                                        color: AppColors.customYellow
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                  if (i == 1)
                                    ...List.generate(
                                      2,
                                      (_) => Icon(
                                        Icons.star_border_rounded,
                                        size: 16.sp,
                                        color: AppColors.customYellow
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    _ratings[i],
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24.h),

                      // ── Duration ────────────────────────
                      _SectionLabel(label: 'Duration'),
                      SizedBox(height: 12.h),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: List.generate(_durations.length, (i) {
                          return _SelectableChip(
                            label: _durations[i],
                            isSelected: _selectedDuration == i,
                            onTap: () => setState(() => _selectedDuration = i),
                          );
                        }),
                      ),
                      SizedBox(height: 24.h),

                      // ── Trip Type ───────────────────────
                      _SectionLabel(label: 'Trip Type'),
                      SizedBox(height: 12.h),
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
                                    ? AppColors.primaryLightBlue1.withOpacity(
                                        0.25,
                                      )
                                    : context.colorTheme.surface,
                                border: Border.all(
                                  color: isActive
                                      ? AppColors.primaryBlue.withOpacity(0.45)
                                      : context.colorTheme.outline.withOpacity(
                                          0.3,
                                        ),
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
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          fontSize: 13.sp,
                                          fontWeight: isActive
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    isActive
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    size: 16.sp,
                                    color: isActive
                                        ? AppColors.primaryBlue
                                        : context.colorTheme.outline
                                              .withOpacity(0.4),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 24.h),

                      // ── Location ────────────────────────
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

                // ── Bottom bar ──────────────────────────
                Container(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                  decoration: BoxDecoration(
                    color: context.colorTheme.surface,
                    border: Border(
                      top: BorderSide(
                        color: context.colorTheme.outline.withOpacity(0.15),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '48 results',
                        style: AppTextStyles.h10SemiBold.copyWith(),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 28.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28.r),
                            border: Border.all(
                              color: AppColors.primaryBlue,
                              width: 1.2,
                            ),
                          ),
                          child: Text(
                            'Show Results',
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
              ? AppColors.primaryLightBlue1.withOpacity(0.25)
              : context.colorTheme.surface,
          border: Border.all(
            color: isSelected
                ? AppColors.primaryBlue.withOpacity(0.45)
                : context.colorTheme.outline.withOpacity(0.3),
            width: isSelected ? 1.2 : 0.8,
          ),
        ),
        child: Text(
          label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected
                ? context.colorTheme.onSurface
                : context.colorTheme.outline,
          ),
        ),
      ),
    );
  }
}
