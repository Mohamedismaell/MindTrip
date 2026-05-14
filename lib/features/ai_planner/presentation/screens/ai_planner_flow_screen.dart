import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/ai_planner_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/ai_chat_bot_button.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/animated_progress_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/budget_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/destination_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/duration_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/interests_step.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/travelers_step.dart';

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

  /// The active trip ID – set when auto-saving or when resuming.
  String? _activeTripId;

  @override
  void initState() {
    super.initState();

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

    if (widget.tripId != null) {
      _activeTripId = widget.tripId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _resumeFromTripId(widget.tripId!);
      });
    }
  }

  Future<void> _resumeFromTripId(String tripId) async {
    final tripsCubit = context.read<TripsCubit>();
    // Load if not Loaded yet
    if (tripsCubit.state.trips.isEmpty) {
      await tripsCubit.loadTrips();
    }
    final trip = tripsCubit.state.trips
        .where((t) => t.id == tripId)
        .firstOrNull;
    if (trip == null || !mounted) return;

    context.read<AiPlannerCubit>().loadFromTrip(trip);
    context.read<ChatCubit>().loadMessages(trip.chatMessages);

    _destinationController.text = trip.destination;
    _customBudgetController.text = trip.customBudget;
    // move page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(trip.currentPage);
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

  Future<void> _autoSave() async {
    final plannerState = context.read<AiPlannerCubit>().state;
    if (plannerState.selectedDestination == null ||
        plannerState.selectedDestination!.isEmpty) {
      return;
    }

    final chatMessages = context.read<ChatCubit>().state.messages;
    final tripsCubit = context.read<TripsCubit>();

    if (_activeTripId != null) {
      final snapshot = context.read<AiPlannerCubit>().toTripSnapshot(
        chatMessages,
        tripId: _activeTripId!,
      );
      await tripsCubit.saveTripDraft(snapshot);
    } else {
      final newId = await tripsCubit.createDraft(
        plannerState.selectedDestination!,
      );
      _activeTripId = newId;
      // Now save the full state into it
      final snapshot = context.read<AiPlannerCubit>().toTripSnapshot(
        chatMessages,
        tripId: newId,
      );
      await tripsCubit.saveTripDraft(snapshot);
    }
  }

  Future<void> _handleBack() async {
    final cubit = context.read<AiPlannerCubit>();
    if (cubit.state.currentPage == 0) {
      await _autoSave();
      if (mounted) context.pop();
      return;
    }
    cubit.previousPage();
  }

  void _onStepCompleted() {
    final cubit = context.read<AiPlannerCubit>();
    if (cubit.state.currentPage < 4) {
      cubit.nextPage();
    } else {
      // Last step – mark as complete
      _finishPlanning();
    }
  }

  Future<void> _finishPlanning() async {
    final chatMessages = context.read<ChatCubit>().state.messages;
    final tripsCubit = context.read<TripsCubit>();
    final plannerState = context.read<AiPlannerCubit>().state;

    if (_activeTripId == null && plannerState.selectedDestination != null) {
      _activeTripId = await tripsCubit.createDraft(
        plannerState.selectedDestination!,
      );
    }

    if (_activeTripId != null) {
      final snapshot = context.read<AiPlannerCubit>().toTripSnapshot(
        chatMessages,
        tripId: _activeTripId!,
      );
      await tripsCubit.saveTripDraft(snapshot);
      await tripsCubit.completeTrip(_activeTripId!);
    }

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final currentPage = context.select(
      (AiPlannerCubit cubit) => cubit.state.currentPage,
    );

    final showFab = !isKeyboardOpen && (currentPage != 4);

    return PopScope(
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) await _autoSave();
      },
      child: Scaffold(
        backgroundColor: context.colorTheme.surface,
        floatingActionButton: showFab ? const AiChatBotButton() : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
