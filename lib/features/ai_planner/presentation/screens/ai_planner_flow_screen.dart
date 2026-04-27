import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_chat_bot_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/animated_progress_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/destination_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/duration_step.dart';

class AiPlannerFlowScreen extends StatelessWidget {
  const AiPlannerFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AiPlannerFlowView();
  }
}

class _AiPlannerFlowView extends StatefulWidget {
  const _AiPlannerFlowView();

  @override
  State<_AiPlannerFlowView> createState() => _AiPlannerFlowViewState();
}

class _AiPlannerFlowViewState extends State<_AiPlannerFlowView> {
  static const int _progressSteps = 5;
  final PageController _pageController = PageController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _customBudgetController = TextEditingController();

  @override
  void initState() {
    print('init called ');
    super.initState();

    // Sync controllers with cubit
    _destinationController.addListener(() {
      context.read<AiPlannerCubit>().updateDestinationQuery(
        _destinationController.text,
      );
    });

    _customBudgetController.addListener(() {
      context.read<AiPlannerCubit>().updateCustomBudget(
        _customBudgetController.text,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _destinationController.dispose();
    _customBudgetController.dispose();
    super.dispose();
  }

  Future<void> _handleBack() async {
    final cubit = context.read<AiPlannerCubit>();
    if (cubit.state.currentPage == 0) {
      context.pop();
      return;
    }
    cubit.previousPage();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiPlannerCubit>();

    return Scaffold(
      backgroundColor: context.colorTheme.surface,
      floatingActionButton: const AiChatBotButton(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: BlocListener<AiPlannerCubit, AiPlannerState>(
            listenWhen: (previous, current) =>
                previous.currentPage != current.currentPage,
            listener: (context, state) {
              _pageController.animateToPage(
                state.currentPage,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeIn,
              );
            },
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    _HeaderIconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: _handleBack,
                    ),
                    SizedBox(width: 28.w),
                    Builder(
                      builder: (context) {
                        final currentPage = context.select(
                          (AiPlannerCubit cubit) => cubit.state.currentPage,
                        );
                        final double progressValue =
                            (currentPage + 1) / _progressSteps;
                        return SizedBox(
                          width: 220.w,
                          child: AnimatedProgressBar(progress: progressValue),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        DestinationStep(
                          controller: _destinationController,
                          onDestinationTap: (dest) {
                            _destinationController.text = dest;
                            cubit.selectDestination(dest);
                          },
                        ),
                        const DurationStep(),
                        // const TravelersStep(),
                        // const BudgetStep(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({required this.onTap, required this.icon});
  final VoidCallback onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.r),
      child: SizedBox(
        width: 50.w,
        height: 50.h,
        child: Icon(
          icon,
          size: 32.sp,
          color: context.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
 // TravelersStep(
                        //   title: 'Who is traveling?',
                        //   subtitle: 'Tell us how many people are joining.',
                        //   adults: state.adults,
                        //   children: state.children,
                        //   pets: state.pets,
                        //   onDecreaseAdults: () => cubit.changeAdults(-1),
                        //   onIncreaseAdults: () => cubit.changeAdults(1),
                        //   onDecreaseChildren: () => cubit.changeChildren(-1),
                        //   onIncreaseChildren: () => cubit.changeChildren(1),
                        //   onDecreasePets: () => cubit.changePets(-1),
                        //   onIncreasePets: () => cubit.changePets(1),
                        //   canContinue: state.canContinue,
                        //   onContinue: () => cubit.nextPage(),
                        //   aiHint: 'Skip the clicks! Tell AI who is joining.',
                        // ),
                        // BudgetStep(
                        //   title: 'What is your budget?',
                        //   subtitle: 'This is your budget per person.',
                        //   budgets: AiPlannerMockData.budgetTiers,
                        //   selectedBudget: state.selectedBudget,
                        //   customBudgetController: _customBudgetController,
                        //   onBudgetTap: cubit.selectBudget,
                        //   onCustomBudgetChanged: cubit.updateCustomBudget,
                        //   canContinue: state.canContinue,
                        //   onContinue: () => cubit.nextPage(),
                        //   aiHint: 'Need help estimating your budget? Ask AI',
                        // ),