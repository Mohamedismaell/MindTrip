import 'package:freezed_annotation/freezed_annotation.dart';

part 'voice_search_state.freezed.dart';

enum VoiceSearchStatus { idle, initializing, listening, completed, error }

@freezed
abstract class VoiceSearchState with _$VoiceSearchState {
  const factory VoiceSearchState({
    @Default(VoiceSearchStatus.idle) VoiceSearchStatus status,
    @Default("") String transcript,
    @Default("") String errorMessage,
    @Default(false) bool isFinalResult,
  }) = _VoiceSearchState;
}
