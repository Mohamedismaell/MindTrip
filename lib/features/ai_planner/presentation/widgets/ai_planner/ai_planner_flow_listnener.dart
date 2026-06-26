import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner_status_listener.dart';

class AiPlannerFlowListnener extends StatelessWidget {
  const AiPlannerFlowListnener({
    super.key,
    required PageController pageController,
    required this.child,
  }) : _pageController = pageController;

  final PageController _pageController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AiPlannerCubit, AiPlannerState>(
          listenWhen: (previous, current) =>
              previous.currentPage != current.currentPage,
          listener: (_, state) {
            _pageController.animateToPage(
              state.currentPage,
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeIn,
            );
          },
        ),
      ],
      child: AiPlannerStatusListener(child: child),
    );
  }
}
