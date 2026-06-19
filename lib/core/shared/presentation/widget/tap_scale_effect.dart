import 'package:flutter/material.dart';

class TapScaleEffect extends StatefulWidget {
  const TapScaleEffect({
    super.key,
    required this.child,
    this.onTap,
    this.scaleDown = 0.97,
    this.duration = const Duration(milliseconds: 120),
    this.borderRadius,
    this.enableOverlay = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scaleDown;
  final Duration duration;
  final BorderRadius? borderRadius;
  final bool enableOverlay;

  @override
  State<TapScaleEffect> createState() => _TapScaleEffectState();
}

class _TapScaleEffectState extends State<TapScaleEffect> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (mounted) {
      setState(() => _isPressed = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null;

    return AnimatedScale(
      scale: _isPressed && !isDisabled ? widget.scaleDown : 1.0,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: Material(
        color: Colors.transparent,
        borderRadius: widget.borderRadius,
        child: InkWell(
          borderRadius: widget.borderRadius,
          onTap: widget.onTap,
          splashColor: widget.enableOverlay ? null : Colors.transparent,
          highlightColor: widget.enableOverlay ? null : Colors.transparent,
          hoverColor: widget.enableOverlay ? null : Colors.transparent,
          overlayColor: widget.enableOverlay
              ? null
              : WidgetStateProperty.all(Colors.transparent),
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) async {
            await Future.delayed(const Duration(milliseconds: 70));
            _setPressed(false);
          },
          onTapCancel: () => _setPressed(false),
          child: widget.child,
        ),
      ),
    );
  }
}
