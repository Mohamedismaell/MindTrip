import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/ai_hint.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/counter_row.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/ai_flow_action_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/step_heading.dart';

class TravelersStep extends StatelessWidget {
  const TravelersStep({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiPlannerCubit>();
    final adults = context.select((AiPlannerCubit c) => c.state.adults);
    final children = context.select((AiPlannerCubit c) => c.state.children);
    return ListView(
      padding: EdgeInsets.only(top: 6.h, bottom: 24.h),
      children: [
        StepHeading(
          title: 'Who is traveling?',
          subtitle: 'Tell us how many people are joining.',
          icon: Icons.groups_rounded,
        ),
        SizedBox(height: 42.h),
        CounterRow(
          label: 'Travelers',
          value: adults,
          onDecrease: () => cubit.changeAdults(-1),
          onIncrease: () => cubit.changeAdults(1),
          showDivider: true,
        ),
        // CounterRow(
        //   label: 'Children',
        //   value: children,
        //   onDecrease: () => cubit.changeChildren(-1),
        //   onIncrease: () => cubit.changeChildren(1),
        //   showDivider: true,
        // ),
        // SizedBox(height: 200.h),
        AiFlowActionButton(text: 'Continue', onTap: onContinue),
        SizedBox(height: 24.h),
        Center(
          child: AiHint(
            message: 'Skip the clicks! Tell AI who is joining.',
            actionMessage: ' Ask AI',
          ),
        ),
      ],
    );
  }
}
