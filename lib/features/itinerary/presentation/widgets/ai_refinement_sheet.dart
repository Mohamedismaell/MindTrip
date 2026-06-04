import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_message_bubble.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_typing_indicator.dart';

//Todo replace it with share
class AiRefinementSheet extends StatefulWidget {
  final String tripId;
  final List<ChatMessage> initialMessages;

  const AiRefinementSheet({
    super.key,
    required this.tripId,
    this.initialMessages = const [],
  });

  static Future<void> show(
    BuildContext context,
    String tripId,
    List<ChatMessage> messages,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ChatCubit>(),
        child: AiRefinementSheet(tripId: tripId, initialMessages: messages),
      ),
    );
  }

  @override
  State<AiRefinementSheet> createState() => _AiRefinementSheetState();
}

class _AiRefinementSheetState extends State<AiRefinementSheet> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load existing chat history if any
    if (widget.initialMessages.isNotEmpty) {
      context.read<ChatCubit>().loadMessages(widget.initialMessages);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.colorTheme.outline.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: context.colorTheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: context.colorTheme.primary,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text('Refine with Mindy', style: AppTextStyles.h7Bold),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(),

          // Chat Area
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state.messages.isNotEmpty) _scrollToBottom();
              },
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(20.r),
                  itemCount: state.messages.length + (state.isAiTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.messages.length) {
                      return const Align(
                        alignment: Alignment.centerLeft,
                        child: ChatTypingIndicator(),
                      );
                    }
                    final message = state.messages[index];
                    return ChatMessageBubble(message: message);
                  },
                );
              },
            ),
          ),

          // Suggestions
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                _SuggestionChip(
                  label: '🏰 More museums',
                  onTap: () => _controller.text =
                      'Can you add more historical sites and museums?',
                ),
                _SuggestionChip(
                  label: '🍝 Local food',
                  onTap: () => _controller.text =
                      'I want more authentic local food stops.',
                ),
                _SuggestionChip(
                  label: '💰 Cheaper options',
                  onTap: () => _controller.text =
                      'Make the itinerary more budget-friendly.',
                ),
              ],
            ),
          ),

          // Input Area
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask Mindy to change anything...',
                      filled: true,
                      fillColor: context.colorTheme.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                    ),
                    onSubmitted: (val) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 8.w),
                CircleAvatar(
                  backgroundColor: context.colorTheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: ActionChip(
        label: Text(label, style: AppTextStyles.h10SemiBold),
        onPressed: onTap,
        backgroundColor: context.colorTheme.surfaceContainerHighest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: BorderSide.none,
        ),
      ),
    );
  }
}
