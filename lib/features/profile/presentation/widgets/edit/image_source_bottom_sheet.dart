import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

Future<ImageSource?> showImageSourceSheet(BuildContext context) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    backgroundColor: context.colorTheme.surface,
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: context.colorTheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Choose Photo Source',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: context.colorTheme.onSurface,
              ),
            ),
            SizedBox(height: 24.h),
            _SourceOption(
              key: const Key('image-source-camera'),
              icon: Icons.camera_alt_rounded,
              label: 'Camera',
              onTap: () => Navigator.pop(ctx, ImageSource.camera),
              color: context.colorTheme.primary,
            ),
            SizedBox(height: 12.h),
            _SourceOption(
              key: const Key('image-source-gallery'),
              icon: Icons.photo_library_rounded,
              label: 'Gallery',
              onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              color: context.colorTheme.primary,
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    ),
  );
}

class _SourceOption extends StatelessWidget {
  const _SourceOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(icon, color: color, size: 24.sp),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: context.colorTheme.onSurface,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: context.colorTheme.onSurface.withValues(alpha: 0.4),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onTap: onTap,
    );
  }
}
