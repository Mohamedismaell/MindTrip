import 'dart:math';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_attachment.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/send_message_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_state.dart';

class ChatCubit extends SafeCubit<ChatState> {
  ChatCubit({
    required SendMessageUseCase sendMessageUseCase,
    required ChatRepository chatRepository,
  }) : _sendMessageUseCase = sendMessageUseCase,
       super(const ChatState());

  final SendMessageUseCase _sendMessageUseCase;

  String _generateId(String prefix) =>
      '${prefix}_${DateTime.now().millisecondsSinceEpoch}';

  void loadMessages(List<ChatMessage> messages) {
    if (messages.isEmpty) return;
    emitSafe(state.copyWith(messages: messages, status: ChatStatus.loaded));
  }

  void initialize(String userName) {
    if (state.messages.isNotEmpty) return;

    final greeting = ChatMessage(
      id: _generateId('greeting'),
      content:
          "Hi $userName! 👋 I'm Mindy. Where would you like to go, or what are you in the mood to explore today?",
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      suggestions: const [
        '🗺️ Plan a trip',
        '📍 Discover places',
        '🏨 Find hotels',
        '🍽️ Food & cafés',
        '🏖️ Beaches',
        '🏛️ Historical sites',
        '🎉 Nightlife',
        '🛍️ Shopping',
      ],
    );

    emitSafe(state.copyWith(messages: [greeting], status: ChatStatus.loaded));
  }

  void startNewConversation(String userName) {
    emitSafe(const ChatState());
    initialize(userName);
  }

  // void addAttachments(List<ChatAttachment> newAttachments) {
  //   final updated = List<ChatAttachment>.from(state.attachments)
  //     ..addAll(newAttachments);
  //   emitSafe(state.copyWith(attachments: updated));
  // }

  // void removeAttachment(int index) {
  //   final updated = List<ChatAttachment>.from(state.attachments)
  //     ..removeAt(index);
  //   emitSafe(state.copyWith(attachments: updated));
  // }

  Future<void> sendMessage(
    String text, {
    required String sessionId,
    CollectedPlannerDataEntity? collected,
  }) async {
    final cleanText = text.trim();

    if (cleanText.isEmpty && state.attachments.isEmpty) return;

    final userMessage = ChatMessage(
      id: _generateId('user'),
      content: cleanText,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      attachments: state.attachments.isNotEmpty ? state.attachments : null,
    );

    emitSafe(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isAiTyping: true,
        errorMessage: null,
        attachments: const [],
      ),
    );

    try {
      final request = ChatRequestModel.fromCollected(
        sessionId: sessionId,
        message: cleanText,
        collected: collected ?? state.collected,
      );

      final response = await _sendMessageUseCase(request);

      final aiMessage = response.toChatMessage(
        id: _generateId('ai'),
        timestamp: DateTime.now(),
      );

      emitSafe(
        state.copyWith(
          messages: [...state.messages, aiMessage],
          isAiTyping: false,
          lastResponse: response,
        ),
      );
    } catch (e) {
      final errorBubble = ChatMessage(
        id: _generateId('error'),
        content: 'Failed to get response. Please try again.',
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
        isError: true,
      );
      emitSafe(
        state.copyWith(
          isAiTyping: false,
          errorMessage: 'Failed to get response. Please try again.',
          messages: [...state.messages, errorBubble],
        ),
      );
    }
  }

  void sendMediaMessages(List<ChatAttachment> attachments) {
    if (attachments.isEmpty) return;

    final newMessages = attachments
        .map(
          (a) => ChatMessage(
            id: 'media_${DateTime.now().millisecondsSinceEpoch}_${a.path.hashCode}',
            content: '',
            sender: MessageSender.user,
            timestamp: DateTime.now(),
            attachments: [a],
          ),
        )
        .toList();

    emitSafe(state.copyWith(messages: [...state.messages, ...newMessages]));
  }

  Future<void> sendSuggestion(String suggestion, {required String sessionId}) =>
      sendMessage(suggestion, sessionId: sessionId);

  // void generateTripSummary({
  //   required String destination,
  //   required DateTime startDate,
  //   required DateTime endDate,
  //   required int adults,
  //   required int children,
  //   required int pets,
  //   required String budget,
  //   required List<String> interests,
  // }) {
  //   final summary = _chatRepository.generateTripSummary(
  //     destination: destination,
  //     startDate: startDate,
  //     endDate: endDate,
  //     adults: adults,
  //     children: children,
  //     pets: pets,
  //     budget: budget,
  //     interests: interests,
  //   );

  //   emitSafe(state.copyWith(messages: [...state.messages, summary]));
  // }

  void showRetryMessage() {
    final random = Random();
    final retryMsg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(9999)}',
      content: '',
      //  ChatMockResponses.retryMessage,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      suggestions: [''],
      // ChatMockResponses.retrySuggestions
    );
    emitSafe(state.copyWith(messages: [...state.messages, retryMsg]));
  }

  void clearChat() {
    emitSafe(const ChatState());
  }
}
