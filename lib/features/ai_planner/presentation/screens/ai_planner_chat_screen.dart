import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_input_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_message_bubble.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_suggestion_chips.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_typing_indicator.dart';

//Todo save chat until plan is completed or add new button to start the chat from first idk
//todo add functionality to the menu
//todo: start with Place place place details
class AiPlannerChatScreen extends StatefulWidget {
  const AiPlannerChatScreen({super.key});

  @override
  State<AiPlannerChatScreen> createState() => _AiPlannerChatScreenState();
}

class _AiPlannerChatScreenState extends State<AiPlannerChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final userName =
        context.read<UserCubit>().state.user?.displayName ?? 'Traveler';
    context.read<ChatCubit>().initialize(userName);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSendMessage() {
    final text = _textController.text;
    if (text.trim().isEmpty) return;

    context.read<ChatCubit>().sendMessage(text);
    _textController.clear();
    _scrollToBottom();
  }

  void _onSuggestionTap(String suggestion) {
    context.read<ChatCubit>().sendSuggestion(suggestion);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future<void>.delayed(const Duration(milliseconds: 100), () {
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
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        final displayName = userState.user?.displayName ?? 'Traveler';

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: Center(
                child: Column(
                  children: [
                    //  Header
                    _ChatHeader(displayName: displayName),
                    SizedBox(height: 20.h),

                    //  Message List
                    Expanded(
                      child: BlocConsumer<ChatCubit, ChatState>(
                        listener: (context, state) {
                          _scrollToBottom();
                        },
                        builder: (context, state) {
                          final messages = state.messages;
                          return ListView.builder(
                            controller: _scrollController,
                            padding: EdgeInsets.only(bottom: 8.h),
                            itemCount:
                                messages.length + (state.isAiTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              // Show indicator as the last item
                              if (index == messages.length &&
                                  state.isAiTyping) {
                                return const ChatTypingIndicator();
                              }

                              final message = messages[index];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ChatMessageBubble(message: message),

                                  //Todo: Edit with suit ui
                                  if (message.hasSuggestions &&
                                      message == messages.last)
                                    ChatSuggestionChips(
                                      suggestions: message.suggestions!,
                                      onTap: _onSuggestionTap,
                                    ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),

                    //  Input Bar
                    ChatInputBar(
                      controller: _textController,
                      onSend: _onSendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: SizedBox(
        height: 48.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: context.colorTheme.outline,
                  size: 32.sp,
                ),
              ),
            ),

            Text(
              'Hello, $displayName 👋',
              style: AppTextStyles.h6SemiBold.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
