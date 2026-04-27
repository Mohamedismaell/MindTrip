import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/flow_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/range_calendar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/tsep_heading.dart';

class DurationStep extends StatelessWidget {
  const DurationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final canContinue = context.select(
      (AiPlannerCubit cubit) => cubit.state.canContinue,
    );
    final cubit = context.read<AiPlannerCubit>();

    return ListView(
      padding: EdgeInsets.only(top: 6.h, bottom: 24.h),
      children: [
        const StepHeading(
          title: 'How long is your trip?',
          subtitle: 'Choose how many days you are planning to travel.',
          icon: Icons.calendar_today_rounded,
        ),
        SizedBox(height: 24.h),
        const RangeCalendar(),
        SizedBox(height: 24.h),
        FlowButton(
          enabled: canContinue,
          text: 'Continue',
          onTap: cubit.nextPage,
        ),
        SizedBox(height: 22.h),
        const AiHint(
          message: 'Not sure about the dates? Ask AI',
          centerText: true,
        ),
      ],
    );
  }
}
