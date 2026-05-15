import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/utils/extension.dart';
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

  late final AiPlannerCubit _plannerCubit;
  late final ChatCubit _chatCubit;
  late final TripsCubit _tripsCubit;

  /// The active trip ID – set when auto-saving or when resuming.
  String? _activeTripId;

  @override
  void initState() {
    super.initState();

    _plannerCubit = context.read<AiPlannerCubit>();
    _chatCubit = context.read<ChatCubit>();
    _tripsCubit = context.read<TripsCubit>();

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

    if (widget.tripId != null) {
      _activeTripId = widget.tripId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _resumeFromTripId(widget.tripId!);
      });
    }
  }

  Future<void> _resumeFromTripId(String tripId) async {
    if (_tripsCubit.isClosed) return;
    // Load if not Loaded yet
    if (_tripsCubit.state.trips.isEmpty) {
      await _tripsCubit.loadTrips();
    }
    if (_tripsCubit.isClosed) return;

    final trip = _tripsCubit.state.trips
        .where((t) => t.id == tripId)
        .firstOrNull;
    if (trip == null || !mounted) return;

    if (!_plannerCubit.isClosed) _plannerCubit.loadFromTrip(trip);
    if (!_chatCubit.isClosed) _chatCubit.loadMessages(trip.chatMessages);

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
    if (_plannerCubit.isClosed || _tripsCubit.isClosed || _chatCubit.isClosed) {
      return;
    }

    final plannerState = _plannerCubit.state;
    if (plannerState.selectedDestination == null ||
        plannerState.selectedDestination!.isEmpty) {
      return;
    }

    final chatMessages = _chatCubit.state.messages;

    if (_activeTripId != null) {
      final snapshot = _plannerCubit.toTripSnapshot(
        chatMessages,
        tripId: _activeTripId!,
      );
      await _tripsCubit.saveTripDraft(snapshot);
    } else {
      final newId = await _tripsCubit.createDraft(
        plannerState.selectedDestination!,
      );
      if (_tripsCubit.isClosed) return;
      _activeTripId = newId;

      final snapshot = _plannerCubit.toTripSnapshot(
        chatMessages,
        tripId: newId,
      );
      await _tripsCubit.saveTripDraft(snapshot);
    }
  }

  Future<void> _handleBack() async {
    if (_plannerCubit.isClosed) return;
    if (_plannerCubit.state.currentPage == 0) {
      await _autoSave();
      if (mounted) context.pop();
      return;
    }
    _plannerCubit.previousPage();
    _autoSave();
  }

  void _onStepCompleted() {
    if (_plannerCubit.isClosed) return;
    if (_plannerCubit.state.currentPage < 4) {
      _plannerCubit.nextPage();
      _autoSave();
    } else {
      _finishPlanning();
    }
  }

  Future<void> _finishPlanning() async {
    if (_plannerCubit.isClosed || _tripsCubit.isClosed || _chatCubit.isClosed) {
      return;
    }

    _plannerCubit.markReadyToGenerate();

    final chatMessages = _chatCubit.state.messages;
    final plannerState = _plannerCubit.state;

    if (_activeTripId == null && plannerState.selectedDestination != null) {
      _activeTripId = await _tripsCubit.createDraft(
        plannerState.selectedDestination!,
      );
      if (_tripsCubit.isClosed) return;
    }

    if (_activeTripId != null) {
      final snapshot = _plannerCubit.toTripSnapshot(
        chatMessages,
        tripId: _activeTripId!,
      );
      await _tripsCubit.saveTripDraft(snapshot);
      // Wait for actual generation before calling completeTrip
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
