import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_bot_image.dart';

class ChatTypingIndicator extends StatefulWidget {
  const ChatTypingIndicator({super.key});

  @override
  State<ChatTypingIndicator> createState() => _ChatTypingIndicatorState();
}

class _ChatTypingIndicatorState extends State<ChatTypingIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  static const int _dotCount = 3;
  static const Duration _dotDuration = Duration(milliseconds: 400);
  static const Duration _dotDelay = Duration(seconds: 160);

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      _dotCount,
      (_) => AnimationController(vsync: this, duration: _dotDuration),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0,
        end: -8.h,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    }).toList();

    _startAnimation();
  }

  void _startAnimation() async {
    while (mounted) {
      for (var i = 0; i < _dotCount; i++) {
        if (!mounted) return;
        _controllers[i].forward();
        await Future<void>.delayed(_dotDelay);
      }
      for (var i = 0; i < _dotCount; i++) {
        if (!mounted) return;
        _controllers[i].reverse();
        await Future<void>.delayed(_dotDelay);
      }
      if (!mounted) return;
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChatBotImage(width: 42, height: 42, isButton: false),
          SizedBox(width: 10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
              ),
              border: Border.all(color: context.colorTheme.outline, width: 1.w),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(_dotCount, (index) {
                return AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _animations[index].value),
                      child: child,
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: context.colorTheme.primary.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
