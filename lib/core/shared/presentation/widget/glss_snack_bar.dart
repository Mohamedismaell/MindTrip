import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';

enum AppGlassSnackBarType { success, error, note }

class AppGlassSnackBar {
  static OverlayEntry? _currentEntry;
  static Timer? _timer;

  static void show({
    required BuildContext context,
    required String message,
    required AppGlassSnackBarType type,
    Duration duration = const Duration(seconds: 2),
  }) {
    _removeCurrent();

    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _GlassSnackBarWidget(
        message: message,
        type: type,
        onClose: _removeCurrent,
      ),
    );

    _currentEntry = entry;
    overlay.insert(entry);

    _timer = Timer(duration, _removeCurrent);
  }

  static void showSuccess({
    required BuildContext context,
    required String message,
  }) {
    show(
      context: context,
      message: message,
      type: AppGlassSnackBarType.success,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
  }) {
    show(context: context, message: message, type: AppGlassSnackBarType.error);
  }

  static void showNote({
    required BuildContext context,
    required String message,
  }) {
    show(context: context, message: message, type: AppGlassSnackBarType.note);
  }

  static void _removeCurrent() {
    _timer?.cancel();
    _timer = null;

    _currentEntry?.remove();
    _currentEntry = null;
  }
}

class _GlassSnackBarWidget extends StatefulWidget {
  final String message;
  final AppGlassSnackBarType type;
  final VoidCallback onClose;

  const _GlassSnackBarWidget({
    required this.message,
    required this.type,
    required this.onClose,
  });

  @override
  State<_GlassSnackBarWidget> createState() => _GlassSnackBarWidgetState();
}

class _GlassSnackBarWidgetState extends State<_GlassSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color get color {
    switch (widget.type) {
      case AppGlassSnackBarType.success:
        return AppColors.successGreen;
      case AppGlassSnackBarType.error:
        return AppColors.errorRed;
      case AppGlassSnackBarType.note:
        return AppColors.customYellow;
    }
  }

  IconData get icon {
    switch (widget.type) {
      case AppGlassSnackBarType.success:
        return Icons.check_rounded;
      case AppGlassSnackBarType.error:
        return Icons.error_outline_rounded;
      case AppGlassSnackBarType.note:
        return Icons.info_rounded;
    }
  }

  String get title {
    switch (widget.type) {
      case AppGlassSnackBarType.success:
        return 'Success';
      case AppGlassSnackBarType.error:
        return 'Error';
      case AppGlassSnackBarType.note:
        return 'Heads up';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24.w,
      right: 24.w,
      bottom: 40.h,
      child: Material(
        color: Colors.transparent,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          onDismissed: (_) => widget.onClose(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow layer
              Container(
                height: 88.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.r),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: .10),
                      blurRadius: 35,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),

              // Glass card
              ClipRRect(
                borderRadius: BorderRadius.circular(28.r),
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return CustomPaint(
                      foregroundPainter: SnackbarProgressBorderPainter(
                        progress: controller.value,
                        color: color,
                      ),
                      child: child,
                    );
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.r),

                        // Main glass layer
                        color: Colors.white.withValues(alpha: .9),

                        // border: Border.all(
                        //   color: context.colorTheme.outline.withValues(
                        //     alpha: .2,
                        //   ),
                        //   width: 1.5,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: .08),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.withValues(alpha: .10),
                              border: Border.all(
                                color: color.withValues(alpha: .9),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: color.withValues(alpha: .15),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Icon(icon, color: color, size: 24.sp),
                          ),
                          SizedBox(width: 16.w),

                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: AppTextStyles.h8SemiBold.copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.black87,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Text(
                                  widget.message,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.h9Medium.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Icon(
                              Icons.close_rounded,
                              color: color,
                              size: 24.sp,
                            ),
                          ),
                          // Container(
                          //   width: 44.w,
                          //   height: 44.h,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: color.withValues(alpha: .15),
                          //         blurRadius: 8,
                          //         spreadRadius: 0.2,
                          //       ),
                          //     ],
                          //   ),
                          //   child:
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SnackbarProgressBorderPainter extends CustomPainter {
  final double progress;
  final Color color;

  const SnackbarProgressBorderPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(1, 1, size.width - 2, size.height - 2),
          const Radius.circular(27),
        ),
      );

    final metric = path.computeMetrics().first;

    canvas.drawPath(
      metric.extractPath(0, metric.length * progress),
      Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant SnackbarProgressBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
