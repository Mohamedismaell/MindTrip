import 'package:flutter/material.dart';
import 'package:mindtrip/core/utils/extension.dart';

class SuggestionRotator extends StatefulWidget {
  final List<String> suggestions;
  final bool enabled;

  const SuggestionRotator({
    super.key,
    required this.suggestions,
    required this.enabled,
  });

  @override
  State<SuggestionRotator> createState() => _SuggestionRotatorState();
}

class _SuggestionRotatorState extends State<SuggestionRotator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _index = (_index + 1) % widget.suggestions.length;
          });
          _controller.forward(from: 0);
        }
      }
    });

    if (widget.enabled) _controller.forward();
  }

  @override
  void didUpdateWidget(SuggestionRotator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      widget.enabled ? _controller.forward() : _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled && _index == 0) return const SizedBox.shrink();

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        'Try "${widget.suggestions[_index]}"',
        key: ValueKey(_index),
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colorTheme.outline.withValues(alpha: 0.7),
        ),
      ),
    );
  }
}
