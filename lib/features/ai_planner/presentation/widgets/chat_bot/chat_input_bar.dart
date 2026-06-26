import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/widget/tap_scale_effect.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_attachment.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    // required this.onPhotosPicked,
    // required this.onVideoPicked,
    // required this.onFilesPicked,
    required this.attachments,
    required this.onRemoveAttachment,
    this.profilePhotoUrl,
  });

  final TextEditingController controller;

  final VoidCallback onSend;

  // final void Function(List<XFile>) onPhotosPicked;
  // final void Function(XFile) onVideoPicked;
  // final void Function(List<PlatformFile>) onFilesPicked;

  final List<ChatAttachment> attachments;
  final void Function(int index) onRemoveAttachment;

  final String? profilePhotoUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // // Plus button
          // Container(
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     border: Border.all(color: context.colorTheme.outline, width: 1.5),
          //   ),
          //   child: ChatAttachmentButton(
          //     onPhotos: onPhotosPicked,
          //     onVideo: onVideoPicked,
          //     onFiles: onFilesPicked,
          //   ),
          // ),
          // SizedBox(width: 16.w),

          // Main input container
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, _) {
                final text = value.text.trim();

                final hasText = text.isNotEmpty;

                final length = value.text.length;

                final isOverLimit = length >= 200;

                return Container(
                  padding: EdgeInsets.only(left: 12.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),

                    border: Border.all(
                      color: isOverLimit
                          ? AppColors.errorRed
                          : context.colorTheme.outline,
                      width: 1.2,
                    ),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (attachments.isNotEmpty) ...[
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
                          child: SizedBox(
                            height: 80.h,

                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,

                              itemCount: attachments.length,

                              separatorBuilder: (_, _) => SizedBox(width: 10.w),

                              itemBuilder: (context, index) {
                                final item = attachments[index];

                                return Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(14.r),
                                      child: _buildAttachmentPreview(
                                        item,
                                        context,
                                      ),
                                    ),

                                    Positioned(
                                      top: 4,
                                      right: 4,

                                      child: GestureDetector(
                                        onTap: () {
                                          onRemoveAttachment(index);
                                        },

                                        child: Container(
                                          padding: EdgeInsets.all(4.r),

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black54,
                                          ),

                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 12.h),
                      ],

                      // Input row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,

                              textInputAction: TextInputAction.send,

                              onSubmitted: (_) => _handleSend() ? onSend : null,

                              minLines: 1,
                              maxLines: 4,

                              maxLength: 200,

                              maxLengthEnforcement: MaxLengthEnforcement.none,

                              buildCounter:
                                  (
                                    context, {
                                    required currentLength,
                                    required isFocused,
                                    maxLength,
                                  }) {
                                    return null;
                                  },

                              decoration: InputDecoration(
                                isCollapsed: true,

                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,

                                hintText: 'Type a message',

                                hintStyle: context.textTheme.bodyMedium
                                    ?.copyWith(
                                      color:
                                          context.colorTheme.onSurfaceVariant,
                                    ),
                              ),
                            ),
                          ),

                          SizedBox(width: 8.w),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 120),

                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },

                            child: hasText || attachments.isNotEmpty
                                ? TapScaleEffect(
                                    key: const ValueKey('send_button'),

                                    onTap: isOverLimit
                                        ? null
                                        : _handleSend()
                                        ? onSend
                                        : null,

                                    child: Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        color: isOverLimit
                                            ? context
                                                  .colorTheme
                                                  .onSurfaceVariant
                                                  .withValues(alpha: 0.5)
                                            : context.colorTheme.primary,
                                      ),

                                      child: Icon(
                                        Icons.arrow_upward_rounded,

                                        size: 24.sp,

                                        color: AppColors.pureWhite,
                                      ),
                                    ),
                                  )
                                : TapScaleEffect(
                                    key: const ValueKey('voice_button'),
                                    onTap: () async {
                                      final result = await context.push<String>(
                                        AppRoutes.voiceSearch,
                                      );
                                      if (result != null && result.isNotEmpty) {
                                        controller.text = result;
                                        _handleSend();
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(8.r),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: AppColors.blueLightGradient,
                                      ),
                                      child: Icon(
                                        Icons.mic_rounded,
                                        size: 24.sp,
                                        color: AppColors.pureWhite,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool _handleSend() {
    final text = controller.text;
    final canSend =
        (text.trim().isNotEmpty || attachments.isNotEmpty) &&
        text.length <= 200;
    return canSend;
  }

  Widget _buildAttachmentPreview(ChatAttachment item, BuildContext context) {
    switch (item.type) {
      case AttachmentType.image:
        return Image.file(
          File(item.path),
          width: 80.w,
          height: 80.w,
          fit: BoxFit.cover,
        );
      case AttachmentType.video:
        return Container(
          width: 80.w,
          height: 80.w,
          color: Colors.grey[300],
          child: Icon(Icons.play_circle_fill, color: Colors.white, size: 32.sp),
        );
      case AttachmentType.file:
        return Container(
          width: 80.w,
          height: 80.w,
          color: context.colorTheme.primary.withValues(alpha: 0.1),
          padding: EdgeInsets.all(8.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_drive_file, color: context.colorTheme.primary),
              SizedBox(height: 4.h),
              Text(
                item.path.split('/').last,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.h10Medium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }
}
