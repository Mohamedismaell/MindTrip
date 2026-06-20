import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_snackbar.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/search/presentation/cubit/voice_search_cubit.dart';
import 'package:mindtrip/features/search/presentation/cubit/voice_search_state.dart';
import 'package:mindtrip/features/search/presentation/widgets/blinking_cursor.dart';
import 'package:mindtrip/features/search/presentation/widgets/pulse_mic.dart';
import 'package:mindtrip/features/search/presentation/widgets/suggestion_rotator.dart';

class VoiceSearchScreen extends StatefulWidget {
  const VoiceSearchScreen({super.key});

  @override
  State<VoiceSearchScreen> createState() => _VoiceSearchScreenState();
}

class _VoiceSearchScreenState extends State<VoiceSearchScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final AnimationController _pageController;

  late final Animation<double> _entranceFade;
  late final Animation<Offset> _micSlide;
  late final Animation<double> _micScale;

  static const List<String> _suggestions = [
    'Best beaches in Hurghada',
    'Historical sites in Cairo',
    'Popular cafes in Alexandria',
    'Hidden gems in Luxor',
    'Italian restaurants near me',
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _pageController.forward();

    // Start voice initialization after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final cubit = context.read<VoiceSearchCubit>();
        //  start animation
        if (cubit.state.status == VoiceSearchStatus.listening) {
          _pulseController.repeat();
        }
        cubit.initialize();
      }
    });
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _pageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _entranceFade = CurvedAnimation(
      parent: _pageController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _micSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _pageController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    _micScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _pageController,
        curve: const Interval(0.2, 1.0, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VoiceSearchCubit, VoiceSearchState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == VoiceSearchStatus.listening) {
          _pulseController.repeat();
          HapticFeedback.lightImpact();
        } else if (state.status == VoiceSearchStatus.completed) {
          _pulseController.stop();
          HapticFeedback.mediumImpact();
          // Short delay to let user see final result
          Future.delayed(const Duration(milliseconds: 600), () {
            if (context.mounted) {
              context.pop(state.transcript);
            }
          });
        } else if (state.status == VoiceSearchStatus.idle) {
          _pulseController.stop();
        } else if (state.status == VoiceSearchStatus.error) {
          _pulseController.stop();
          AppSnackBar.showError(message: state.errorMessage, context: context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _buildBackground(context),
      ),
    );
  }

  Widget _buildBackground(BuildContext context) {
    final theme = context.colorTheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [theme.surface, const Color(0xFFF7F9FD), theme.surface],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            _buildCloseButton(context, theme),
            _buildContent(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context, ColorScheme theme) {
    return Positioned(
      top: 12.h,
      right: 16.w,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.selectionClick();
          context.read<VoiceSearchCubit>().stopListening();
          context.pop();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.close_rounded),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ColorScheme theme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            _buildHeader(context),
            SizedBox(height: 32.h),
            _buildTranscript(context, theme),
            SizedBox(height: 60.h),
            _buildMic(),
            SizedBox(height: 12.h),
            _buildSuggestions(context, theme),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeTransition(
      opacity: _entranceFade,
      child: Text(
        "Where do you want\nto explore?",
        textAlign: TextAlign.center,
        style: context.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildTranscript(BuildContext context, ColorScheme theme) {
    return FadeTransition(
      opacity: _entranceFade,
      child: BlocBuilder<VoiceSearchCubit, VoiceSearchState>(
        builder: (context, state) {
          final isListening =
              state.status == VoiceSearchStatus.listening &&
              !state.isFinalResult;
          final isInitializing = state.status == VoiceSearchStatus.initializing;
          final isError = state.status == VoiceSearchStatus.error;

          String text = state.transcript;
          if (text.isEmpty) {
            if (isInitializing) {
              text = "Initializing...";
            } else if (isError) {
              text = "Error occurred";
            } else {
              text = "Text ...";
            }
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: text,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: (state.transcript.isEmpty || isError)
                          ? theme.outline
                          : theme.onSurface,
                    ),
                  ),
                  if (isListening)
                    WidgetSpan(child: BlinkingCursor(active: true)),
                ],
              ),
              key: ValueKey("${state.transcript}_${state.status}"),
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMic() {
    return SlideTransition(
      position: _micSlide,
      child: ScaleTransition(
        scale: _micScale,
        child: BlocBuilder<VoiceSearchCubit, VoiceSearchState>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return PulseMic(
              animation: _pulseController,
              listening: state.status == VoiceSearchStatus.listening,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context, ColorScheme theme) {
    return FadeTransition(
      opacity: _entranceFade,
      child: BlocBuilder<VoiceSearchCubit, VoiceSearchState>(
        buildWhen: (p, c) => p.transcript.isEmpty != c.transcript.isEmpty,
        builder: (context, state) {
          return SuggestionRotator(
            suggestions: _suggestions,
            enabled: state.transcript.isEmpty,
          );
        },
      ),
    );
  }
}
