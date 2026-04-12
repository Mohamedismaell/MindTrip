import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class ProfileUserAvatar extends StatelessWidget {
  const ProfileUserAvatar({
    super.key,
    required this.displayName,
    this.imageUrl,
    this.radius = 34,
  });

  final String displayName;
  final String? imageUrl;
  final double radius;

  String get _initials {
    final parts = displayName
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .toList();

    if (parts.isEmpty) {
      return 'MT';
    }

    return parts.map((part) => part[0].toUpperCase()).join();
  }

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;

    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryLightBlue1.withOpacity(0.55),
        border: Border.all(
          color: context.colorTheme.primary.withOpacity(0.18),
          width: 1.4,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: (imageUrl != null && imageUrl!.isNotEmpty)
          ? AppCachedImage(
              imageUrl: imageUrl!,
              width: size.w,
              height: size.w,
            )
          : Text(
              _initials,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: context.colorTheme.primary,
              ),
            ),
    );
  }
}
