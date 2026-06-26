import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/features/ai_planner/data/models/generate_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_message_bubble.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_suggestion_chips.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_typing_indicator.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/generate_plan_card.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required VoidCallback scrollToBottom,
    required VoidCallback onSuggestionTap,
    required ScrollController scrollController,
    required ValueChanged<GeneratePlanRequestModel> onGeneratePlan,
  }) : _scrollToBottom = scrollToBottom,
       _onGeneratePlan = onGeneratePlan,
       _onSuggestionTap = onSuggestionTap,
       _scrollController = scrollController;
  final VoidCallback _scrollToBottom;
  final VoidCallback _onSuggestionTap;
  final ValueChanged<GeneratePlanRequestModel> _onGeneratePlan;
  final ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          _scrollToBottom();
        },
        builder: (context, state) {
          final messages = state.messages;
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 8.h),
            itemCount: messages.length + (state.isAiTyping ? 1 : 0),
            itemBuilder: (context, index) {
              // Show indicator as the last item
              if (index == messages.length && state.isAiTyping) {
                return const ChatTypingIndicator();
              }
              final message = messages[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChatMessageBubble(message: message),
                  //Todo: Edit with suit ui
                  if (message.hasSuggestions && message == messages.last)
                    ChatSuggestionChips(
                      suggestions: message.suggestions!,
                      onTap: (value) => _onSuggestionTap,
                    ),

                  //Generate Plan Card
                  if (message.isReadyToGenerate && message == messages.last)
                    GeneratePlanCard(
                      collected: state.collected,
                      aiMessage: state.aiOutput,
                      onGenerate: _onGeneratePlan,
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
