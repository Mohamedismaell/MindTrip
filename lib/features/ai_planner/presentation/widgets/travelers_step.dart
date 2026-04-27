import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/counter_row.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/flow_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/tsep_heading.dart';

class TravelersStep extends StatelessWidget {
  const TravelersStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.adults,
    required this.children,
    required this.pets,
    required this.onDecreaseAdults,
    required this.onIncreaseAdults,
    required this.onDecreaseChildren,
    required this.onIncreaseChildren,
    required this.onDecreasePets,
    required this.onIncreasePets,
    required this.canContinue,
    required this.onContinue,
    required this.aiHint,
  });

  final String title;
  final String subtitle;
  final int adults;
  final int children;
  final int pets;
  final VoidCallback onDecreaseAdults;
  final VoidCallback onIncreaseAdults;
  final VoidCallback onDecreaseChildren;
  final VoidCallback onIncreaseChildren;
  final VoidCallback onDecreasePets;
  final VoidCallback onIncreasePets;
  final bool canContinue;
  final VoidCallback onContinue;
  final String aiHint;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 6.h, bottom: 24.h),
      children: [
        StepHeading(
          title: title,
          subtitle: subtitle,
          icon: Icons.groups_rounded,
        ),
        SizedBox(height: 42.h),
        CounterRow(
          label: 'Adults',
          value: adults,
          onDecrease: onDecreaseAdults,
          onIncrease: onIncreaseAdults,
          showDivider: true,
        ),
        CounterRow(
          label: 'Children',
          value: children,
          onDecrease: onDecreaseChildren,
          onIncrease: onIncreaseChildren,
          showDivider: true,
        ),
        CounterRow(
          label: 'Pets',
          value: pets,
          onDecrease: onDecreasePets,
          onIncrease: onIncreasePets,
        ),
        SizedBox(height: 34.h),
        FlowButton(enabled: canContinue, text: 'Continue', onTap: onContinue),
        SizedBox(height: 24.h),
        AiHint(message: aiHint, centerText: true),
      ],
    );
  }
}
