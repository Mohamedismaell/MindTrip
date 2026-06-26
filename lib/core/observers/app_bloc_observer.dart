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

    // Uncomment while debugging ONE specific bloc.
    //
    // if (bloc.runtimeType.toString() == 'AiPlannerCubit') {
    //   _log(_pretty(transition.nextState));
    // }
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

    // Uncomment while debugging ONE specific cubit.
    //
    // if (bloc.runtimeType.toString() == 'TripDetailsCubit') {
    //   _log(_pretty(change.nextState));
    // }
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

  void _log(String text) {
    for (var i = 0; i < text.length; i += _chunkSize) {
      debugPrint(
        text.substring(
          i,
          i + _chunkSize > text.length ? text.length : i + _chunkSize,
        ),
      );
    }
  }

  String _pretty(Object? object) {
    try {
      dynamic value = object;

      final dynamic dyn = value;
      try {
        value = dyn.toJson();
      } catch (_) {}

      final text = const JsonEncoder.withIndent('  ').convert(value);

      if (text.length <= _maxLength) {
        return text;
      }

      return '${text.substring(0, _maxLength)}'
          '\n\n... <truncated ${text.length - _maxLength} chars>';
    } catch (_) {
      final text = object.toString();

      if (text.length <= _maxLength) {
        return text;
      }

      return '${text.substring(0, _maxLength)}'
          '\n\n... <truncated ${text.length - _maxLength} chars>';
    }
  }
}
