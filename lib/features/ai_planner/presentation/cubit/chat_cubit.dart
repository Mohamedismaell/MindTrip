import 'package:flutter_bloc/flutter_bloc.dart';
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

  //Todo Add Cancel Token
  final SendMessageUseCase _sendMessageUseCase;
  final ChatRepository _chatRepository;

  void initialize(String userName) {
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

  /// Sends a user message and waits for the AI response.
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Add user message
    final userMessage = ChatMessage(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      content: text.trim(),
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isAiTyping: true,
        clearError: true,
      ),
    );

    // 2. Get AI response
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

  /// Sends a suggestion chip as a user message.
  Future<void> sendSuggestion(String suggestion) => sendMessage(suggestion);

  /// Generates a trip summary from the completed planner flow.
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

  /// Shows a retry message when plan generation fails.
  void showRetryMessage() {
    final retryMsg = _chatRepository.getRetryMessage();
    emit(state.copyWith(messages: [...state.messages, retryMsg]));
  }

  /// Clears all messages (when plan is completed).
  void clearChat() {
    emit(const ChatState());
  }
}
