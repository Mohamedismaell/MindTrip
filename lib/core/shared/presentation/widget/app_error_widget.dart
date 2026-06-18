import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/tap_scale_effect.dart';

class AppErrorWidget extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final hasButton = action != null || onPressed != null;
    final image = imagePath ?? AppAssets.errorBotMap;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppCachedImage(
              imagePath: image,
              width: imageSize.w,
              height: imageSize.w,
            ),

            if (title != null)
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.h7SemiBold,
              ),

            if (message != null) ...[
              SizedBox(height: 8.h),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppTextStyles.h9Regular.copyWith(
                  color: context.colorTheme.outline,
                ),
              ),
            ],

            if (hasButton) ...[
              SizedBox(height: 20.h),
              TapScaleEffect(
                onTap: onPressed,
                child:
                    action ??
                    FilledButton.icon(
                      onPressed: onPressed,
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(buttonText ?? 'Try Again'),
                    ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
