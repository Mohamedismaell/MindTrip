import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/features/ai_planner/data/datasources/chat_mock_responses.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/repositories/chat_repository.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/send_message_use_case.dart';
import 'package:mindtrip/features/ai_planner/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required SendMessageUseCase sendMessageUseCase,
    required ChatRepository chatRepository,
  }) : _sendMessageUseCase = sendMessageUseCase,
       _chatRepository = chatRepository,
       super(const ChatState());

  final SendMessageUseCase _sendMessageUseCase;
  final ChatRepository _chatRepository;

  void loadMessages(List<ChatMessage> messages) {
    if (messages.isEmpty) return;
    emit(state.copyWith(messages: messages, status: ChatStatus.loaded));
  }

  void initialize(String userName) {
    if (state.messages.isNotEmpty) return;

    final greeting = ChatMessage(
      id: 'greeting_${DateTime.now().millisecondsSinceEpoch}',
      content:
          "Hi $userName! I'm Mindy, your AI travel assistant 🌍 I can help you plan your perfect trip in Egypt. What would you like to do today?",
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      suggestions: const [
        '🗺️ Plan a trip',
        '🏨 Find hotels',
        '🍽️ Food recommendations',
        '🎯 Things to do',
      ],
    );

    emit(state.copyWith(messages: [greeting], status: ChatStatus.loaded));
  }

  void startNewConversation(String userName) {
    emit(const ChatState());
    initialize(userName);
  }

  void addAttachments(List<ChatAttachment> newAttachments) {
    final updated = List<ChatAttachment>.from(state.attachments)
      ..addAll(newAttachments);
    emit(state.copyWith(attachments: updated));
  }

  void removeAttachment(int index) {
    final updated = List<ChatAttachment>.from(state.attachments)
      ..removeAt(index);
    emit(state.copyWith(attachments: updated));
  }

  Future<void> sendMessage(String text) async {
    final cleanText = text.trim();
    final currentAttachments = state.attachments;

    if (cleanText.isEmpty && currentAttachments.isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      content: cleanText,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
      attachments: currentAttachments.isNotEmpty ? currentAttachments : null,
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isAiTyping: true,
        clearError: true,
        attachments: const [],
      ),
    );

    // Get AI response
    try {
      final aiResponse = await _sendMessageUseCase(text);
      if (isClosed) return;

      emit(
        state.copyWith(
          messages: [...state.messages, aiResponse],
          isAiTyping: false,
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          isAiTyping: false,
          errorMessage: 'Failed to get response. Please try again.',
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

    emit(state.copyWith(messages: [...state.messages, ...newMessages]));
  }

  Future<void> sendSuggestion(String suggestion) => sendMessage(suggestion);

  void generateTripSummary({
    required String destination,
    required DateTime startDate,
    required DateTime endDate,
    required int adults,
    required int children,
    required int pets,
    required String budget,
    required List<String> interests,
  }) {
    final summary = _chatRepository.generateTripSummary(
      destination: destination,
      startDate: startDate,
      endDate: endDate,
      adults: adults,
      children: children,
      pets: pets,
      budget: budget,
      interests: interests,
    );

    emit(state.copyWith(messages: [...state.messages, summary]));
  }

  void showRetryMessage() {
    final random = Random();
    final retryMsg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}_${random.nextInt(9999)}',
      content: ChatMockResponses.retryMessage,
      sender: MessageSender.ai,
      timestamp: DateTime.now(),
      suggestions: ChatMockResponses.retrySuggestions,
    );
    emit(state.copyWith(messages: [...state.messages, retryMsg]));
  }

  void clearChat() {
    emit(const ChatState());
  }
}
