import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'voice_search_state.dart';

class VoiceSearchCubit extends Cubit<VoiceSearchState> {
  final SpeechToText _speech;

  VoiceSearchCubit(this._speech) : super(const VoiceSearchState());

  Future<void> initialize() async {
    // Prevent duplicate initialization
    if (state.status != VoiceSearchStatus.idle) return;

    await _performInit();
  }

  Future<void> retry() async {
    await _performInit();
  }

  Future<void> _performInit() async {
    if (state.status == VoiceSearchStatus.initializing) return;

    emit(
      state.copyWith(status: VoiceSearchStatus.initializing, errorMessage: ""),
    );

    try {
      // Small timeout to prevent hanging if native side is stuck
      final initialized = await _speech.initialize(
        onError: _onError,
        onStatus: _onStatus,
        debugLogging: false,
      );
      // .timeout(const Duration(seconds: 4), onTimeout: () => false);

      _speech.errorListener = _onError;
      _speech.statusListener = _onStatus;

      if (initialized) {
        await startListening();
      } else {
        emit(
          state.copyWith(
            status: VoiceSearchStatus.error,
            errorMessage: "Voice system currently unavailable",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: VoiceSearchStatus.error,
          errorMessage: "Failed to start voice search",
        ),
      );
    }
  }

  void _onStatus(String status) {
    if (isClosed) return;

    if (status == "listening") {
      emit(state.copyWith(status: VoiceSearchStatus.listening));
    } else if (status == "notListening" || status == "done") {
      if (state.status == VoiceSearchStatus.listening) {
        emit(state.copyWith(status: VoiceSearchStatus.completed));
      }
    }
  }

  void _onError(SpeechRecognitionError error) {
    if (isClosed) return;

    if (error.errorMsg == "error_no_match" ||
        error.errorMsg == "error_speech_timeout") {
      emit(state.copyWith(status: VoiceSearchStatus.completed));
      return;
    }

    emit(
      state.copyWith(
        status: VoiceSearchStatus.error,
        errorMessage: error.errorMsg,
      ),
    );
  }

  void _onResult(SpeechRecognitionResult result) {
    if (isClosed) return;

    emit(
      state.copyWith(
        transcript: result.recognizedWords,
        isFinalResult: result.finalResult,
      ),
    );

    if (result.finalResult) {
      emit(state.copyWith(status: VoiceSearchStatus.completed));
    }
  }

  Future<void> startListening() async {
    if (state.status == VoiceSearchStatus.listening) return;

    try {
      await _speech.listen(
        onResult: _onResult,
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.search,
          partialResults: true,
          cancelOnError: true,
          pauseFor: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VoiceSearchStatus.error,
          errorMessage: "Microphone error",
        ),
      );
    }
  }

  Future<void> stopListening() async {
    _speech.stop();
  }

  @override
  Future<void> close() async {
    _speech.cancel();
    return super.close();
  }
}
