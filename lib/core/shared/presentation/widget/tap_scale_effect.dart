import 'package:flutter/material.dart';

class TapScaleEffect extends StatefulWidget {
  const TapScaleEffect({
    super.key,
    required this.child,
    this.onTap,
    this.scaleDown = 0.97,
    this.duration = const Duration(milliseconds: 120),
    this.borderRadius,
    this.enableOverlay = true,
    this.shape,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scaleDown;
  final Duration duration;
  final BorderRadius? borderRadius;
  final bool enableOverlay;
  final ShapeBorder? shape;

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
        shape: widget.shape,

        child: InkWell(
          // borderRadius: widget.borderRadius,
          customBorder: widget.shape,
          onTap: widget.onTap,

          overlayColor: widget.enableOverlay
              ? WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.08);
                  }

                  if (states.contains(WidgetState.hovered)) {
                    return Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.08);
                  }

                  return Colors.transparent;
                })
              : WidgetStateProperty.all(Colors.transparent),

          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,

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
