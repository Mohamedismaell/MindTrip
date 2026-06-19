import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';

class AppErrorWidget extends StatefulWidget {
  final String? title;
  final String? message;
  final String? imagePath;
  final String? buttonText;
  final VoidCallback? onPressed;
  final Widget? action;
  final double imageSize;

  const AppErrorWidget({
    super.key,
    this.title,
    this.message,
    this.imagePath,
    this.buttonText,
    this.onPressed,
    this.action,
    this.imageSize = 140,
  });

  factory AppErrorWidget.network({Key? key, VoidCallback? onRetry}) {
    return AppErrorWidget(
      key: key,
      title: 'No internet connection',
      message: 'Check your connection and try again.',
      onPressed: onRetry,
    );
  }

  factory AppErrorWidget.nearbyPlaces({Key? key, VoidCallback? onRetry}) {
    return AppErrorWidget(
      key: key,
      // title: 'Nearby places unavailable',
      message: 'We couldn\'t load found nearby places',
      onPressed: onRetry,
    );
  }

  factory AppErrorWidget.download({Key? key, VoidCallback? onRetry}) {
    return AppErrorWidget(
      key: key,
      title: 'Download failed',
      message: 'Something interrupted the download.',
      buttonText: 'Download Again',
      onPressed: onRetry,
    );
  }

  factory AppErrorWidget.notFound({Key? key, VoidCallback? onRetry}) {
    return AppErrorWidget(
      key: key,
      title: 'Page not found',
      message: 'The page you are looking for does not exist.',
      buttonText: 'Go Back',
      onPressed: onRetry,
    );
  }

  factory AppErrorWidget.route({Key? key, VoidCallback? onRetry}) {
    return AppErrorWidget(
      key: key,
      title: 'Unable to open page',
      message: 'Something went wrong while navigating.',
      buttonText: 'Go Back',
      onPressed: onRetry,
    );
  }

  factory AppErrorWidget.noInfo({
    Key? key,
    VoidCallback? onRetry,
    String? message,
    double imageSize = 140,
  }) {
    return AppErrorWidget(
      key: key,
      title: 'No information found',
      message: message ?? 'There is no data available at the moment.',
      onPressed: onRetry,
      imageSize: imageSize,
    );
  }

  @override
  State<AppErrorWidget> createState() => _AppErrorWidgetState();
}

class _AppErrorWidgetState extends State<AppErrorWidget> {
  int _retryCountdown = 0;
  Timer? _timer;

  void _startTimer() {
    setState(() {
      _retryCountdown = 5;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_retryCountdown == 0) {
        timer.cancel();
      } else {
        setState(() {
          _retryCountdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCooldown = _retryCountdown > 0;
    final hasButton = widget.action != null || widget.onPressed != null;
    final image = widget.imagePath ?? AppAssets.errorBotMap;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppCachedImage(
              imagePath: image,
              width: widget.imageSize.w,
              height: widget.imageSize.w,
            ),
            if (widget.title != null)
              Text(
                widget.title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.h7SemiBold,
              ),
            if (widget.message != null) ...[
              SizedBox(height: 8.h),
              Text(
                widget.message!,
                textAlign: TextAlign.center,
                style: AppTextStyles.h9Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ],
            if (hasButton) ...[
              SizedBox(height: 20.h),
              TapScaleEffect(
                onTap: isCooldown
                    ? null
                    : () {
                        widget.onPressed?.call();
                        _startTimer();
                      },
                child:
                    widget.action ??
                    FilledButton.icon(
                      onPressed: isCooldown
                          ? null
                          : () {
                              widget.onPressed?.call();
                              _startTimer();
                            },
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(
                        isCooldown
                            ? 'Wait ${_retryCountdown}s'
                            : (widget.buttonText ?? 'Try Again'),
                      ),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
