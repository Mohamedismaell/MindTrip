import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_cached_image.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class EditAvatar extends StatelessWidget {
  const EditAvatar({
    super.key,
    required this.imageUrl,
    required this.onCameraTap,
    this.localPhotoPath,
    this.photoUploadStatus = PhotoUploadStatus.idle,
    this.onRetryTap,
  });

  final String imageUrl;
  final VoidCallback onCameraTap;
  final String? localPhotoPath;
  final PhotoUploadStatus photoUploadStatus;
  final VoidCallback? onRetryTap;

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

        //! review
        // Upload progress overlay
        if (photoUploadStatus == PhotoUploadStatus.uploading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withValues(alpha: 0.4),
              ),
              child: Center(
                child: SizedBox(
                  width: 32.w,
                  height: 32.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

        // Retry overlay on failure
        if (photoUploadStatus == PhotoUploadStatus.failed)
          Positioned.fill(
            child: GestureDetector(
              onTap: onRetryTap,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Retry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

  /// Shows local file preview during upload, otherwise loads from network.
  Widget _buildImage() {
    if (localPhotoPath != null) {
      return Image.file(
        File(localPhotoPath!),
        width: 120.w,
        height: 120.w,
        fit: BoxFit.cover,
      );
    }
    return AppCachedImage(imageUrl: imageUrl);
  }
}
