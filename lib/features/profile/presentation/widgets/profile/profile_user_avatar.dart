import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';

class ProfileUserAvatar extends StatelessWidget {
  const ProfileUserAvatar({
    super.key,
    required this.displayName,
    this.imageUrl,
    this.radius = 60,
  });

  final String displayName;
  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;

    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(shape: BoxShape.circle),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: (imageUrl != null && imageUrl!.isNotEmpty)
          ? AppCachedImage(imagePath: imageUrl!, width: size.w, height: size.w)
          : Image.asset('assets/images/profile/deafult_user_cover.png'),
    );
  }
}
