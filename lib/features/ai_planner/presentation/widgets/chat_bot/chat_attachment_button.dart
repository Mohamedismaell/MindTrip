import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/services/attachment_picker_service.dart';

class ChatAttachmentButton extends StatefulWidget {
  const ChatAttachmentButton({
    super.key,
    required this.onPhotos,
    required this.onVideo,
    required this.onFiles,
  });

  final void Function(List<XFile>) onPhotos;
  final void Function(XFile) onVideo;
  final void Function(List<PlatformFile>) onFiles;

  @override
  State<ChatAttachmentButton> createState() => _ChatAttachmentButtonState();
}

class _ChatAttachmentButtonState extends State<ChatAttachmentButton> {
  final OverlayPortalController _controller = OverlayPortalController();

  Future<void> _handleCamera() async {
    final files = await AttachmentPickerService.pickPhotos(
      context,
      source: ImageSource.camera,
    );
    if (files.isNotEmpty) widget.onPhotos(files);
    _controller.hide();
  }

  Future<void> _handlePhoto() async {
    final files = await AttachmentPickerService.pickPhotos(
      context,
      source: ImageSource.gallery,
    );
    if (files.isNotEmpty) widget.onPhotos(files);
    _controller.hide();
  }

  Future<void> _handleVideo() async {
    final file = await AttachmentPickerService.pickVideo(context);
    if (file != null) widget.onVideo(file);
    _controller.hide();
  }

  Future<void> _handleFile() async {
    final files = await AttachmentPickerService.pickFiles(context);
    if (files.isNotEmpty) widget.onFiles(files);
    _controller.hide();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) {
        return Positioned(
          bottom: 100.h,
          left: 28.w,
          child: TapRegion(
            onTapOutside: (event) {
              if (_controller.isShowing) {
                _controller.hide();
              }
            },
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 220),
              tween: Tween<double>(begin: 0.8, end: 1),
              curve: Curves.easeOutCubic,
              builder: (context, scale, child) {
                return Opacity(
                  opacity: scale,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.bottomLeft,
                    child: child,
                  ),
                );
              },
              child: Container(
                width: 180.w,
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 12.w,
                  top: 12.h,
                  bottom: 12.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: context.colorTheme.onSurfaceVariant.withValues(
                      alpha: 0.6,
                    ),
                    width: 1.5.r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _item(Icons.camera_alt_outlined, 'Camera', _handleCamera),
                    SizedBox(height: 12.h),
                    _item(Icons.photo_library_outlined, 'Photo', _handlePhoto),
                    SizedBox(height: 12.h),
                    _item(Icons.attach_file_rounded, 'File', _handleFile),
                    SizedBox(height: 12.h),
                    _item(Icons.videocam_outlined, 'Video', _handleVideo),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: IconButton(
        onPressed: () {
          if (_controller.isShowing) {
            _controller.hide();
          } else {
            // Dismiss keyboard
            FocusScope.of(context).unfocus();
            _controller.show();
          }
        },
        icon: Icon(
          Icons.add,
          fontWeight: FontWeight.bold,
          color: context.colorTheme.onSurfaceVariant,
          size: 22.sp,
        ),
      ),
    );
  }

  Widget _item(IconData icon, String text, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryLightGray,
                child: Icon(icon, size: 24.sp, color: Colors.black),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: AppTextStyles.h9Medium.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
