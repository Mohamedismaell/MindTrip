import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindtrip/core/shared/presentation/widget/glss_snack_bar.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_cubit.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_state.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/ai_planner/generating_loading_dialog.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_input_bar.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_message_bubble.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_suggestion_chips.dart';
import 'package:mindtrip/features/ai_planner/presentation/widgets/chat_bot/chat_typing_indicator.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_cubit.dart';
import 'package:mindtrip/features/trips/presentation/cubit/trips_state.dart';
import 'package:uuid/uuid.dart';

//Todo Bug with float button wrong nav route
class AiPlannerChatScreen extends StatefulWidget {
  const AiPlannerChatScreen({super.key});

  @override
  State<AiPlannerChatScreen> createState() => _AiPlannerChatScreenState();
}

class _AiPlannerChatScreenState extends State<AiPlannerChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  // One session ID lives for the lifetime of this screen instance.
  final String _sessionId = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    final userName =
        context.read<UserCubit>().state.user?.displayName ?? 'Traveler';
    context.read<ChatCubit>().initialize(userName);
    _scrollToBottom();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSendMessage() {
    final text = _textController.text;
    final cubit = context.read<ChatCubit>();
    if (text.trim().isEmpty && cubit.state.attachments.isEmpty) return;

    cubit.sendMessage(text, sessionId: _sessionId);
    _textController.clear();
    _scrollToBottom();
  }

  void _onSuggestionTap(String suggestion) {
    context.read<ChatCubit>().sendMessage(suggestion, sessionId: _sessionId);
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

  // void _onPhotosPicked(List<XFile> files) {
  //   if (files.isEmpty) return;
  //   final cubit = context.read<ChatCubit>();
  //   final currentPhotos = cubit.state.attachments
  //       .where((a) => a.type == AttachmentType.image)
  //       .length;
  //   if (currentPhotos + files.length > 6) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Maximum 6 photos allowed in total.')),
  //       );
  //     }
  //     final allowed = 6 - currentPhotos;
  //     if (allowed <= 0) return;
  //     files = files.take(allowed).toList();
  //   }
  //   cubit.addAttachments(
  //     files
  //         .map((f) => ChatAttachment(path: f.path, type: AttachmentType.image))
  //         .toList(),
  //   );
  // }

  // void _onVideoPicked(XFile file) {
  //   final cubit = context.read<ChatCubit>();
  //   final hasVideo = cubit.state.attachments.any(
  //     (a) => a.type == AttachmentType.video,
  //   );
  //   if (hasVideo) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Only 1 video allowed per message.')),
  //       );
  //     }
  //     return;
  //   }
  //   cubit.addAttachments([
  //     ChatAttachment(path: file.path, type: AttachmentType.video),
  //   ]);
  // }

  // void _onFilesPicked(List<PlatformFile> files) {
  //   if (files.isEmpty) return;
  //   final cubit = context.read<ChatCubit>();
  //   final currentFiles = cubit.state.attachments
  //       .where((a) => a.type == AttachmentType.file)
  //       .length;
  //   if (currentFiles + files.length > 2) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Maximum 2 files allowed in total.')),
  //       );
  //     }
  //     final allowed = 2 - currentFiles;
  //     if (allowed <= 0) return;
  //     files = files.take(allowed).toList();
  //   }
  //   cubit.addAttachments(
  //     files
  //         .map((f) => ChatAttachment(path: f.path!, type: AttachmentType.file))
  //         .toList(),
  //   );
  // }

  void _confirmNewConversation() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Start new conversation?'),
        content: const Text('Your current chat will be cleared.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final userName =
                  context.read<UserCubit>().state.user?.displayName ??
                  'Traveler';
              context.read<ChatCubit>().startNewConversation(userName);
            },
            child: const Text('Start new'),
          ),
        ],
      ),
    );
  }

  //Todo: When real API is ready, replace this with a proper API call using metadata
  Future<void> _onGeneratePlan() async {
    final chatCubit = context.read<ChatCubit>();
    final messages = chatCubit.state.messages;
    if (messages.isEmpty) return;

    final tripsCubit = context.read<TripsCubit>();

    //Todo: either we extract the reponse of the back end  json or we get a flag so we don't extract any thing
    final metadata = chatCubit.state.tripMetadata;
    final destination = metadata?['destination'] as String? ?? 'My Trip';
    final title = 'Trip to $destination';

    final newTripId = DateTime.now().millisecondsSinceEpoch.toString();
    final snapshot = Trip(
      id: newTripId,
      title: title,
      status: TripStatus.draft,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      destination: destination,
      people: int.tryParse(metadata?['adults']?.toString() ?? '1') ?? 1,
      totalBudget: int.tryParse(metadata?['budget']?.toString() ?? '0') ?? 0,
      totalCost: 0,
      interests: (metadata?['interests'] as List?)?.cast<String>() ?? const [],
      // currentPage: 5,
      // chatMessages: messages,
    );

    // await tripsCubit.saveTripDraft(snapshot);

    if (!mounted) return;
    // Trigger generation flow in the background (state handles UI)
    // tripsCubit.generateTrip(snapshot);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        final displayName = userState.user?.displayName ?? 'Traveler';

        return Scaffold(
          body: SafeArea(
            child: BlocListener<TripsCubit, TripsState>(
              listenWhen: (previous, current) =>
                  previous.isGenerating != current.isGenerating ||
                  previous.generatedTripId != current.generatedTripId,
              listener: (context, state) {
                if (state.isGenerating) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const GeneratingDialog(),
                  );
                } else if (state.generatedTripId != null) {
                  context.go(
                    '${AppRoutes.tripDetails}?tripId=${state.generatedTripId}',
                  );
                } else if (state.tripsStatus == TripsStatus.error) {
                  AppGlassSnackBar.showError(
                    context: context,
                    message: state.errorMessage ?? 'Generation failed',
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Center(
                  child: Column(
                    children: [
                      //  Header
                      _ChatHeader(
                        displayName: displayName,
                        onNewChat: _confirmNewConversation,
                      ),
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

                                    // Special Generate Plan Card inside the chat
                                    if (message.isReadyToGenerate &&
                                        message == messages.last)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 16.h,
                                          bottom: 8.h,
                                        ),
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: context.colorTheme.primary
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              border: Border.all(
                                                color: context
                                                    .colorTheme
                                                    .primary
                                                    .withValues(alpha: 0.3),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.auto_awesome,
                                                  color: context
                                                      .colorTheme
                                                      .primary,
                                                  size: 32.sp,
                                                ),
                                                SizedBox(height: 8.h),
                                                Text(
                                                  'Ready to build your trip!',
                                                  style: AppTextStyles
                                                      .h8SemiBold
                                                      .copyWith(
                                                        color: context
                                                            .colorTheme
                                                            .primary,
                                                      ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  'I have enough information to create a personalized itinerary for you.',
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyles.h9Regular
                                                      .copyWith(
                                                        color: context
                                                            .colorTheme
                                                            .onSurfaceVariant,
                                                      ),
                                                ),
                                                SizedBox(height: 16.h),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: _onGeneratePlan,
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: context
                                                          .colorTheme
                                                          .primary,
                                                      foregroundColor: context
                                                          .colorTheme
                                                          .onPrimary,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 12.h,
                                                          ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12.r,
                                                            ),
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    child: Text(
                                                      'Generate Trip Plan',
                                                      style: AppTextStyles
                                                          .h8SemiBold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),

                      //  Input Bar
                      BlocSelector<ChatCubit, ChatState, List<ChatAttachment>>(
                        selector: (state) => state.attachments,
                        builder: (context, attachments) {
                          return ChatInputBar(
                            controller: _textController,
                            onSend: _onSendMessage,
                            // onPhotosPicked: _onPhotosPicked,
                            // onVideoPicked: _onVideoPicked,
                            // onFilesPicked: _onFilesPicked,
                            attachments: attachments,
                            onRemoveAttachment: (int index) {
                              // context.read<ChatCubit>().removeAttachment(index);
                            },
                            // profilePhotoUrl: userState.user?.photoURL,
                          );
                        },
                      ),
                    ],
                  ),
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
  const _ChatHeader({required this.displayName, required this.onNewChat});

  final String displayName;
  final VoidCallback onNewChat;

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
            Align(
              alignment: Alignment.topRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onNewChat,
                    icon: Icon(
                      Icons.add_comment_outlined,
                      color: context.colorTheme.outline,
                      size: 24.sp,
                    ),
                    tooltip: 'New conversation',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
