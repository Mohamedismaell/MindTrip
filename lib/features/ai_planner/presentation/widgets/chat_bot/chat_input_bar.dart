import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

/// Bottom chat input bar with text field and animated send button.
///
/// Extracted from the user's existing UI work on the chat screen.
class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    this.onAttachTap,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback? onAttachTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Row(
        children: [
          // Attachment button
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colorTheme.outline, width: 1.5),
            ),
            child: ChatAttachmentButton(),
          ),
          SizedBox(width: 20.w),

          // Text field
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _handleSend(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  // vertical: 12.h,
                  horizontal: 17.w,
                ),
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.r),
                  borderSide: BorderSide(color: context.colorTheme.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.r),
                  borderSide: BorderSide(color: context.colorTheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.r),
                  borderSide: BorderSide(
                    color: context.colorTheme.outline,
                    width: 1.5,
                  ),
                ),
                hintStyle: AppTextStyles.h9Medium.copyWith(
                  color: context.colorTheme.onSurfaceVariant,
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(10),
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, _) {
                      final hasText = value.text.trim().isNotEmpty;

                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 100),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: GestureDetector(
                          key: ValueKey(hasText),
                          onTap: hasText ? _handleSend : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 6.r,
                              horizontal: 6.w,
                            ),
                            key: ValueKey(hasText),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: hasText
                                  ? context.colorTheme.primary
                                  : Colors.transparent,
                            ),
                            child: Icon(
                              hasText
                                  ? Icons.arrow_upward_rounded
                                  : Icons.graphic_eq,
                              size: 24.sp,
                              color: hasText
                                  ? AppColors.pureWhite
                                  : context.colorTheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    if (controller.text.trim().isNotEmpty) {
      onSend();
    }
  }
}

class ChatAttachmentButton extends StatefulWidget {
  const ChatAttachmentButton({super.key});

  @override
  State<ChatAttachmentButton> createState() => _ChatAttachmentButtonState();
}

class _ChatAttachmentButtonState extends State<ChatAttachmentButton> {
  final OverlayPortalController _controller = OverlayPortalController();

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,

      overlayChildBuilder: (context) {
        return Positioned(
          bottom: 90.h,
          left: 28.w,
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
                  _item(Icons.camera_alt_outlined, 'Camera'),
                  SizedBox(height: 12.h),
                  _item(Icons.photo_library_outlined, 'Photo'),
                  SizedBox(height: 12.h),
                  _item(Icons.attach_file_rounded, 'File'),
                  SizedBox(height: 12.h),
                  _item(Icons.videocam_outlined, 'Video'),
                ],
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

  Widget _item(IconData icon, String text) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),

        onTap: () {},
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
