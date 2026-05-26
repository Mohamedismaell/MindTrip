import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/utils/extension.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({
    super.key,
    this.imageUrl,
    required this.onCameraTap,
    this.pendingPhotoPath,
  });

  final String? imageUrl;
  final VoidCallback onCameraTap;

  final String? pendingPhotoPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Avatar image
        Container(
          width: 120.w,
          height: 120.w,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.antiAlias,
          child: _buildImage(),
        ),

        // Camera button
        Positioned(
          right: -4.w,
          bottom: 6.h,
          child: InkWell(
            onTap: onCameraTap,
            borderRadius: BorderRadius.circular(19.r),
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: context.colorTheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (pendingPhotoPath != null) {
      return Image.file(
        File(pendingPhotoPath!),
        width: 120.w,
        height: 120.w,
        fit: BoxFit.cover,
      );
    }
    return imageUrl != null
        ? AppCachedImage(imagePath: imageUrl!)
        : Image.asset('assets/images/profile/deafult_user_cover.webp');
  }
}
