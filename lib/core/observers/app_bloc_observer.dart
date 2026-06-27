import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  static const int _chunkSize = 800;
  static const int _maxLength = 3000;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (!kDebugMode) return;
    debugPrint('🟢 ${bloc.runtimeType} created');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (!kDebugMode) return;
    debugPrint('📥 ${bloc.runtimeType} | ${event.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!kDebugMode) return;

    debugPrint(
      '🔀 ${bloc.runtimeType}'
      ' | ${transition.event.runtimeType}'
      ' | ${transition.currentState.runtimeType}'
      ' → ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!kDebugMode) return;

    debugPrint(
      '🔄 ${bloc.runtimeType}'
      ' | ${change.currentState.runtimeType}'
      ' → ${change.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (!kDebugMode) return;

    _log('''
❌ ${bloc.runtimeType}

ERROR:
$error

STACKTRACE:
$stackTrace
''');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (!kDebugMode) return;
    debugPrint('🔴 ${bloc.runtimeType} closed');
  }

  static void logRequestBody(Object? body, {String title = 'REQUEST BODY'}) {
    if (!kDebugMode) return;
    _printSection(title, _pretty(body));
  }

  static void logResponseBody(Object? body, {String title = 'RESPONSE BODY'}) {
    if (!kDebugMode) return;
    _printSection(title, _pretty(body));
  }

  static void logMessage(String title, Object? data) {
    if (!kDebugMode) return;
    _printSection(title, _pretty(data));
  }

  static void _printSection(String title, String text) {
    _log('''
📦 $title
$text
''');
  }

  static void _log(String text) {
    final safeText = _truncate(text);
    for (var i = 0; i < safeText.length; i += _chunkSize) {
      debugPrint(
        safeText.substring(
          i,
          i + _chunkSize > safeText.length ? safeText.length : i + _chunkSize,
        ),
      );
    }
  }

  static String _truncate(String text) {
    if (text.length <= _maxLength) return text;
    return '${text.substring(0, _maxLength)}'
        '\n\n... <truncated ${text.length - _maxLength} chars>';
  }

  static String _pretty(Object? object) {
    try {
      dynamic value = object;

      final dynamic dyn = value;
      try {
        value = dyn.toJson();
      } catch (_) {}

      final text = const JsonEncoder.withIndent('  ').convert(value);
      return _truncate(text);
    } catch (_) {
      return _truncate(object.toString());
    }
  }
}
