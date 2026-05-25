import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import '../cubit/map_cubit.dart';
import '../cubit/map_state.dart';

class DaySelectorBar extends StatelessWidget {
  const DaySelectorBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      buildWhen: (previous, current) =>
          previous.tripDays != current.tripDays ||
          previous.selectedDayIndex != current.selectedDayIndex,
      builder: (context, state) {
        final days = state.tripDays;
        if (days == null || days.isEmpty) return const SizedBox.shrink();

        return SizedBox(
          height: 60.h,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final day = days[index];
              final isSelected = state.selectedDayIndex == index;

              return ChoiceChip(
                label: Text('Day ${day.dayNumber}'),
                selected: isSelected,
                onSelected: (_) {
                   context.read<MapCubit>().selectDay(index);
                },
                selectedColor: context.colorTheme.primary,
                showCheckmark: false,
                labelStyle: AppTextStyles.h8SemiBold.copyWith(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  side: BorderSide(
                    color: isSelected
                        ? context.colorTheme.primary
                        : Colors.grey.shade300,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
