import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/place_city.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';

class CusotmCityExpandedCard extends StatefulWidget {
  const CusotmCityExpandedCard({super.key});

  @override
  State<CusotmCityExpandedCard> createState() => _CusotmCityExpandedCardState();
}

class _CusotmCityExpandedCardState extends State<CusotmCityExpandedCard> {
  late final ExpansibleController _expansiblecontroller;
  late final ScrollController _listController;
  bool _expanded = false;
  PlaceCity? _selectedCity;

  @override
  void initState() {
    super.initState();
    _expansiblecontroller = ExpansibleController();
    _listController = ScrollController();
  }

  @override
  void dispose() {
    _expansiblecontroller.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          controller: _expansiblecontroller,
          dense: true,
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
          childrenPadding: EdgeInsets.only(
            left: 8.w,
            right: 8.w,
            bottom: 8.h,
            top: 4.h,
          ),

          onExpansionChanged: (value) {
            setState(() => _expanded = value);
          },

          trailing: AnimatedRotation(
            turns: _expanded ? .5 : 0,
            duration: const Duration(milliseconds: 220),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.colorTheme.outline,
            ),
          ),

          title: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTextStyles.h9SemiBold.copyWith(
              color: _selectedCity == null
                  ? context.colorTheme.primary
                  : context.colorTheme.onSurface,
            ),
            child: Text(_selectedCity?.displayName ?? 'Select a city'),
          ),

          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 150.h),
              child: Scrollbar(
                controller: _listController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _listController,
                  shrinkWrap: true,
                  itemCount: PlaceCity.values.length,
                  itemBuilder: (context, index) {
                    final city = PlaceCity.values[index];
                    final selected = city == _selectedCity;

                    return Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Material(
                        color: selected
                            ? context.colorTheme.primary.withValues(alpha: .08)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        child: TapScaleEffect(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            setState(() {
                              _selectedCity = city;
                            });

                            _expansiblecontroller.collapse();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    city.displayName,
                                    style: AppTextStyles.h9SemiBold.copyWith(
                                      color: selected
                                          ? context.colorTheme.primary
                                          : context.colorTheme.onSurface,
                                    ),
                                  ),
                                ),
                                if (selected)
                                  Icon(
                                    Icons.check_rounded,
                                    size: 18.sp,
                                    color: context.colorTheme.primary,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
