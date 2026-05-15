import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_bot_image.dart';

String _formatTime(DateTime time) {
  final hour = time.hour > 12
      ? time.hour - 12
      : time.hour == 0
      ? 12
      : time.hour;

  final minute = time.minute.toString().padLeft(2, '0');

  final period = time.hour >= 12 ? 'PM' : 'AM';

  return '$hour:$minute $period';
}

class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return message.isUser
        ? _UserBubble(message: message)
        : _AiBubble(message: message);
  }
}

class _AiBubble extends StatelessWidget {
  const _AiBubble({required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final timeStr = _formatTime(message.timestamp);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChatBotImage(width: 42, height: 42, isButton: false),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      timeStr,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'AI Assistant',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                    border: Border.all(
                      color: context.colorTheme.outline,
                      width: 1.3.w,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.hasAttachments)
                        ...message.attachments!.map(
                          (a) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: _AttachmentPreview(attachment: a),
                          ),
                        ),
                      if (message.content.isNotEmpty)
                        Text(
                          message.content,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 32.w),
        ],
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final timeStr = _formatTime(message.timestamp);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: 60.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorTheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (message.hasAttachments)
                        ...message.attachments!.map(
                          (a) => Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: _AttachmentPreview(attachment: a),
                          ),
                        ),
                      if (message.content.isNotEmpty)
                        Text(
                          message.content,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.pureWhite,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  timeStr,
                  style: AppTextStyles.h10Regular.copyWith(
                    color: context.colorTheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentPreview extends StatelessWidget {
  const _AttachmentPreview({required this.attachment});
  final ChatAttachment attachment;

  @override
  Widget build(BuildContext context) {
    switch (attachment.type) {
      case AttachmentType.image:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: attachment.path.startsWith('http')
              ? Image.network(attachment.path, width: 200.w, fit: BoxFit.cover)
              : Image.file(
                  File(attachment.path),
                  width: 200.w,
                  fit: BoxFit.cover,
                ),
        );
      case AttachmentType.video:
        return Container(
          width: 200.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.play_circle_fill, size: 50.sp, color: Colors.white70),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: Colors.black54,
                  child: Text(
                    'Video',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      case AttachmentType.file:
        final fileName = attachment.path.split('/').last;
        return Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.insert_drive_file, color: Colors.white),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
    }
  }
}
