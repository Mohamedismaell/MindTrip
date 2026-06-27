import 'package:dio/dio.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/ai_planner/data/models/edit_plan_request_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_message.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/usecases/edit_plan_use_case.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_to_models_mapper.dart';
import 'package:uuid/uuid.dart';

import 'ai_edit_state.dart';

class AiEditCubit extends SafeCubit<AiEditState> {
  final EditPlanUseCase _editPlanUseCase;
  final Trip trip;
  CancelToken? _cancelToken;

  AiEditCubit({
    required EditPlanUseCase editPlanUseCase,
    required this.trip,
    required GeneratedPlanEntity initialPlan,
  }) : _editPlanUseCase = editPlanUseCase,
       super(AiEditState(
         tripId: trip.tripId,
         currentPlan: initialPlan,
         messages: [],
       ));

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      id: const Uuid().v4(),
      content: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    emitSafe(state.copyWith(
      status: AiEditStatus.loading,
      messages: [...state.messages, userMessage],
      errorMessage: '',
    ));

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final request = EditPlanRequestModel(
      targetChange: text,
      destination: trip.city.isNotEmpty ? trip.city : trip.destinationGovernorate,
      city: trip.city.isNotEmpty ? trip.city : trip.destinationGovernorate,
      days: state.currentPlan?.daysCount ?? 0,
      budget: state.currentPlan?.totalCalculatedCost.toInt() ?? 0,
      people: state.currentPlan?.people ?? 0,
      interests: trip.collected?.interests ?? [],
      existingPlan: state.currentPlan?.toModels() ?? [],
      conversation: state.messages.map((m) => ConversationTurnModel(
        role: m.sender == MessageSender.user ? 'user' : 'assistant',
        content: m.content,
      )).toList(),
      tripId: state.tripId,
    );

    final result = await _editPlanUseCase(
      request: request,
      cancelToken: _cancelToken,
    );

    result.when(
      success: (response) {
        final aiMessage = ChatMessage(
          id: const Uuid().v4(),
          content: response.message ?? response.changeApplied ?? 'Change applied successfully.',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );

        emitSafe(state.copyWith(
          status: AiEditStatus.success,
          messages: [...state.messages, aiMessage],
          lastAIResponse: response,
          currentPlan: response.plan ?? state.currentPlan,
        ));
      },
      failure: (error) {
        emitSafe(state.copyWith(
          status: AiEditStatus.failure,
          errorMessage: error.message,
        ));
      },
      cancelled: () {},
    );
  }

  @override
  Future<void> close() {
    _cancelToken?.cancel();
    return super.close();
  }
}
