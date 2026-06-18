import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/place_category.dart';
import 'package:mindtrip/core/enums/place_city.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:mindtrip/features/explore/presentation/widgets/cusotm_city_expanded_card.dart';
import 'package:mindtrip/features/places/data/models/get_places_request_model.dart';

class ExploreFilterSheet extends StatefulWidget {
  const ExploreFilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (_) => BlocProvider.value(
        value: context.read<ExploreCubit>(),
        child: const ExploreFilterSheet(),
      ),
      useRootNavigator: true,
    );
  }

  @override
  State<ExploreFilterSheet> createState() => _ExploreFilterSheetState();
}

class _ExploreFilterSheetState extends State<ExploreFilterSheet> {
  // Filters local state
  late Set<String> _selectedCities;
  late Set<String> _selectedCategories;
  late Set<String> _selectedInterests;
  late RangeValues _ratingRange;
  late RangeValues _priceRange;
  late bool _hiddenGem;
  late String _sortBy;
  late String _order;

  @override
  void initState() {
    super.initState();
    final currentFilters = context.read<ExploreCubit>().state.advancedFilters;
    _selectedCities = Set.from(currentFilters?.city ?? []);
    _selectedCategories = Set.from(currentFilters?.category ?? []);
    _selectedInterests = Set.from(currentFilters?.interests ?? []);
    _ratingRange = RangeValues(
      currentFilters?.minRating ?? 0.0,
      currentFilters?.maxRating ?? 5.0,
    );
    _priceRange = RangeValues(
      (currentFilters?.minPrice ?? 0).toDouble(),
      (currentFilters?.maxPrice ?? 1000).toDouble(),
    );
    _hiddenGem = currentFilters?.hiddenGem ?? false;
    _sortBy = currentFilters?.sortBy ?? 'rating';
    _order = currentFilters?.order ?? 'desc';
  }

  void _resetAll() {
    setState(() {
      _selectedCities = {};
      _selectedCategories = {};
      _selectedInterests = {};
      _ratingRange = const RangeValues(0, 5);
      _priceRange = const RangeValues(0, 1000);
      _hiddenGem = false;
      _sortBy = 'rating';
      _order = 'desc';
    });
  }

  void _applyFilters() {
    final filters = GetPlacesRequestModel(
      city: _selectedCities.isEmpty ? null : _selectedCities.toList(),
      category: _selectedCategories.isEmpty
          ? null
          : _selectedCategories.toList(),
      interests: _selectedInterests.isEmpty
          ? null
          : _selectedInterests.toList(),
      minRating: _ratingRange.start == 0 ? null : _ratingRange.start,
      maxRating: _ratingRange.end == 5 ? null : _ratingRange.end,
      minPrice: _priceRange.start == 0 ? null : _priceRange.start.round(),
      maxPrice: _priceRange.end == 1000 ? null : _priceRange.end.round(),
      hiddenGem: _hiddenGem ? true : null,
      sortBy: _sortBy,
      order: _order,
    );
    context.read<ExploreCubit>().applyAdvancedFilters(filters);
    context.pop();
  }

  static const _interests = [
    'Cafe',
    'Seafood',
    'Museum',
    'Beach',
    'Park',
    'Shopping',
  ];
  static const _sortOptions = ['rating', 'reviews', 'price', 'name'];

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

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filters', style: AppTextStyles.h6SemiBold),
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
                  SizedBox(height: 20.h),

                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      padding: EdgeInsets.only(bottom: 20.h),
                      children: [
                        // Cities
                        _SectionLabel(label: 'Locaiotn'),
                        CusotmCityExpandedCard(),
                        SizedBox(height: 28.h),
                        // Categories
                        _SectionLabel(label: 'Categories'),
                        SizedBox(height: 10.h),
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children: PlaceCategory.values
                              .where((c) => c != PlaceCategory.all)
                              .map((cat) {
                                final isSelected = _selectedCategories.contains(
                                  cat.category,
                                );
                                return _SelectableChip(
                                  label: cat.displayName,
                                  isSelected: isSelected,
                                  onTap: () => setState(
                                    () => isSelected
                                        ? _selectedCategories.remove(
                                            cat.category,
                                          )
                                        : _selectedCategories.add(cat.category),
                                  ),
                                );
                              })
                              .toList(),
                        ),
                        SizedBox(height: 25.h),

                        // Interests
                        _SectionLabel(label: 'Interests'),
                        SizedBox(height: 10.h),
                        Wrap(
                          spacing: 10.w,
                          runSpacing: 10.h,
                          children: _interests.map((interest) {
                            final isSelected = _selectedInterests.contains(
                              interest,
                            );
                            return _SelectableChip(
                              label: interest,
                              isSelected: isSelected,
                              onTap: () => setState(
                                () => isSelected
                                    ? _selectedInterests.remove(interest)
                                    : _selectedInterests.add(interest),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 25.h),

                        // Rating Range
                        _SectionLabel(label: 'Rating Range'),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: AppColors.customYellow,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '${_ratingRange.start.toStringAsFixed(1)} - ${_ratingRange.end.toStringAsFixed(1)}',
                              style: AppTextStyles.h8SemiBold,
                            ),
                          ],
                        ),
                        RangeSlider(
                          values: _ratingRange,
                          min: 0,
                          max: 5,
                          divisions: 50,
                          onChanged: (v) => setState(() => _ratingRange = v),
                        ),
                        SizedBox(height: 15.h),

                        // Price Range
                        _SectionLabel(label: 'Price Range'),
                        SizedBox(height: 8.h),
                        _PriceDisplay(range: _priceRange),
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 1000,
                          divisions: 20,
                          onChanged: (v) => setState(() => _priceRange = v),
                        ),
                        SizedBox(height: 25.h),

                        // Hidden Gems
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _SectionLabel(label: 'Hidden Gems Only'),
                            Switch.adaptive(
                              value: _hiddenGem,
                              onChanged: (v) => setState(() => _hiddenGem = v),
                              activeColor: context.colorTheme.primary,
                            ),
                          ],
                        ),
                        SizedBox(height: 25.h),

                        // Sorting
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _SectionLabel(label: 'Sort By'),
                                  DropdownButton<String>(
                                    value: _sortBy,
                                    isExpanded: true,
                                    items: _sortOptions
                                        .map(
                                          (opt) => DropdownMenuItem(
                                            value: opt,
                                            child: Text(opt.capitalize()),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _sortBy = v!),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _SectionLabel(label: 'Order'),
                                  DropdownButton<String>(
                                    value: _order,
                                    isExpanded: true,
                                    items: ['asc', 'desc']
                                        .map(
                                          (opt) => DropdownMenuItem(
                                            value: opt,
                                            child: Text(
                                              opt == 'asc'
                                                  ? 'Ascending'
                                                  : 'Descending',
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => _order = v!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),

                  // Apply Button
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _applyFilters,
                        child: const Text('Show Results'),
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
    return Text(
      '${range.start.round()}\$ - ${range.end.round()}\$',
      style: AppTextStyles.h8SemiBold,
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
