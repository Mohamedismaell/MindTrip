import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              border: Border.all(
                color: context.colorTheme.outline,
                width: 1.5,
              ),
            ),
            child: IconButton(
              onPressed: onAttachTap ?? () {},
              icon: Icon(
                Icons.add,
                color: context.colorTheme.onSurfaceVariant,
                size: 22.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Text field
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _handleSend(),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 17.w,
                ),
                hintText: 'Type a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.r),
                  borderSide: BorderSide(
                    color: context.colorTheme.outline,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.r),
                  borderSide: BorderSide(
                    color: context.colorTheme.outline,
                  ),
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
                suffixIcon: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, value, _) {
                    final hasText = value.text.trim().isNotEmpty;

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: IconButton(
                        key: ValueKey(hasText),
                        onPressed: hasText ? _handleSend : null,
                        icon: Icon(
                          hasText
                              ? Icons.arrow_upward_rounded
                              : Icons.graphic_eq,
                          size: 22.sp,
                          color: hasText
                              ? context.colorTheme.primary
                              : context.colorTheme.onSurfaceVariant,
                        ),
                      ),
                    );
                  },
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
