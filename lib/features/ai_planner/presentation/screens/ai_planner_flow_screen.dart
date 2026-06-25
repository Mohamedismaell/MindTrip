import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/ai_planner_flow_listnener.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/animated_progress_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/budget_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/destination_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/duration_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/interests_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/travelers_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/ai_chat_bot_button.dart';
import 'package:uuid/uuid.dart';

class AiPlannerFlowScreen extends StatelessWidget {
  const AiPlannerFlowScreen({super.key, this.tripId});

  final String? tripId;

  @override
  Widget build(BuildContext context) {
    return _AiPlannerFlowView(tripId: tripId);
  }
}

class _AiPlannerFlowView extends StatefulWidget {
  const _AiPlannerFlowView({this.tripId});
  final String? tripId;

  @override
  State<_AiPlannerFlowView> createState() => _AiPlannerFlowViewState();
}

class _AiPlannerFlowViewState extends State<_AiPlannerFlowView> {
  static const int _progressSteps = 5;
  final PageController _pageController = PageController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _customBudgetController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final AiPlannerCubit _plannerCubit;
  final String _sessionId = const Uuid().v4();

  @override
  void initState() {
    super.initState();

    _plannerCubit = context.read<AiPlannerCubit>();

    _destinationController.addListener(() {
      if (!_plannerCubit.isClosed) {
        _plannerCubit.updateDestinationQuery(_destinationController.text);
      }
    });

    _customBudgetController.addListener(() {
      if (!_plannerCubit.isClosed) {
        _plannerCubit.updateCustomBudget(_customBudgetController.text);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _destinationController.dispose();
    _customBudgetController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleBack(bool isLeaving) async {
    if (isLeaving) {
      if (mounted) context.pop();
      return;
    }
    final canGoBack = _plannerCubit.goBack();
    if (!canGoBack && mounted) {
      context.pop();
    }
  }

  Future<void> _onStepCompleted() async {
    FocusScope.of(context).unfocus();

    final hasNextPage = _plannerCubit.goNext();

    if (!hasNextPage) {
      _plannerCubit.generatePlan();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final currentPage = context.select(
      (AiPlannerCubit cubit) => cubit.state.currentPage,
    );

    final showFab = !isKeyboardOpen && (currentPage != 4);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await _handleBack(false);
      },
      child: Scaffold(
        backgroundColor: context.colorTheme.surface,
        floatingActionButton: showFab
            ? AiChatBotButton(sessionId: _sessionId)
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: AiPlannerFlowListnener(
              pageController: _pageController,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _HeaderIconButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => _handleBack(false),
                      ),
                      Builder(
                        builder: (context) {
                          final page = context.select(
                            (AiPlannerCubit cubit) => cubit.state.currentPage,
                          );
                          final double progressValue =
                              (page + 1) / _progressSteps;
                          return SizedBox(
                            width: 220.w,
                            child: AnimatedProgressBar(progress: progressValue),
                          );
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryLightGray,
                          shape: BoxShape.circle,
                        ),
                        child: TapScaleEffect(
                          onTap: () => _handleBack(true),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Icon(
                              Icons.close,
                              color: context.colorTheme.onSurfaceVariant,
                            ),
                          ),
                        ),
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
                              _destinationController.text = '';
                            },
                            onContinue: _onStepCompleted,
                          ),
                          DurationStep(onContinue: _onStepCompleted),
                          TravelersStep(onContinue: _onStepCompleted),
                          BudgetStep(
                            customBudgetController: _customBudgetController,
                            onContinue: _onStepCompleted,
                          ),
                          InterestsStep(
                            scrollController: _scrollController,
                            onContinue: _onStepCompleted,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
    return TapScaleEffect(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.r),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryLightGray,
        ),
        child: Icon(
          icon,
          size: 32.sp,
          color: context.colorTheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
