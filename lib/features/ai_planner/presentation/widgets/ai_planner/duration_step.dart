import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/flow_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/range_calendar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/step_heading.dart';

class DurationStep extends StatelessWidget {
  const DurationStep({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
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
        FlowButton(text: 'Continue', onTap: onContinue),
        SizedBox(height: 22.h),
        Center(
          child: const AiHint(
            message: 'Not sure about the dates? ',
            actionMessage: 'Ask AI',
          ),
        ),
      ],
    );
  }
}
