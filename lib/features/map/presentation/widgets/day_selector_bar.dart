import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_shadows.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class DaySelectorBar extends StatefulWidget {
  const DaySelectorBar({super.key});

  @override
  State<DaySelectorBar> createState() => _DaySelectorBarState();
}

class _DaySelectorBarState extends State<DaySelectorBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _toggleExpand() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _animController.forward();
    } else {
      _animController.reverse();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (prev, curr) =>
          prev.generatedPlan != curr.generatedPlan ||
          prev.selectedDayNumber != curr.selectedDayNumber,
      builder: (context, state) {
        final days = state.generatedPlan?.days;

        if (days == null || days.isEmpty) {
          return const SizedBox.shrink();
        }

        final dayNumbers = days.keys.toList()..sort();

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SizeTransition(
                    axis: Axis.horizontal,
                    sizeFactor: CurvedAnimation(
                      parent: _animController,
                      curve: Curves.easeOutCubic,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(dayNumbers.length, (index) {
                          final reversedIndex = dayNumbers.length - 1 - index;

                          final dayNumber = dayNumbers[reversedIndex];

                          final isSelected =
                              state.selectedDayNumber == dayNumber;

                          return Padding(
                            padding: EdgeInsets.only(right: 6.w),
                            child: GestureDetector(
                              onTap: () {
                                context.read<MapCubit>().selectDay(dayNumber);

                                _toggleExpand();
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.w,
                                  vertical: 8.h,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.colorTheme.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: Text(
                                  'Day $dayNumber',
                                  style: AppTextStyles.h10Bold.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: _toggleExpand,
              child: Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [AppShadows.mapToolButtons],
                ),
                child: AnimatedRotation(
                  turns: _isExpanded ? 0.5 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 20.sp,
                    color: context.colorTheme.primary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
