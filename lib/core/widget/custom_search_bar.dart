import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_colors.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/voice_input_button.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    required this.controller,
    required this.handleSend,
    this.hintText,
    super.key,
    this.isSubmittable,
  });

  final TextEditingController controller;
  final VoidCallback handleSend;
  final String? hintText;
  final bool? isSubmittable;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, _) {
        final text = value.text.trim();
        final hasText = text.isNotEmpty;
        final length = value.text.length;
        final isOverLimit = length >= 200;

        return Container(
          padding: EdgeInsets.only(right: 6.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: context.colorTheme.outline, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => handleSend,
                  minLines: 1,
                  maxLines: 1,
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
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: context.colorTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: hintText ?? 'Type a message',

                    hintStyle: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),
              if (isSubmittable == false)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 120),

                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },

                  child: hasText
                      ? GestureDetector(
                          key: const ValueKey('send_button'),

                          onTap: isOverLimit ? null : handleSend,

                          child: Container(
                            padding: EdgeInsets.all(8.r),

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              color: isOverLimit
                                  ? context.colorTheme.onSurfaceVariant
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
                      : VoiceInputButton(
                          key: const ValueKey('voice_button'),

                          onResult: (result) {
                            controller.text = result;

                            handleSend();
                          },

                          activeColor: context.colorTheme.primary,
                        ),
                ),
            ],
          ),
        );
      },
    );
  }
}
