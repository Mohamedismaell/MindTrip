import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mindtrip/core/connections/retry_runner.dart';

part 'connection_event.dart';
part 'connection_state.dart';

EventTransformer<E> _debounceTransformer<E>(Duration duration) {
  return (events, mapper) {
    late StreamController<E> controller;
    Timer? timer;

    controller = StreamController<E>(
      onListen: () {
        events.listen(
          (event) {
            timer?.cancel();
            timer = Timer(duration, () {
              if (!controller.isClosed) controller.add(event);
            });
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
        );
      },
      sync: true,
    );

    return controller.stream.asyncExpand(mapper);
  };
}

class AppConnectionBloc extends Bloc<AppConnectionEvent, AppConnectionState> {
  AppConnectionBloc(this._internetConnection, this.retryRunner)
    : super(ConnectionInitial()) {
    on<ConnectionStatusConnected>(_onConnected);

    on<ConnectionStatusDisconnected>(
      _onDisconnected,
      transformer: _debounceTransformer(const Duration(milliseconds: 1500)),
    );

    _init();
  }

  final InternetConnection _internetConnection;
  final RetryRunner retryRunner;
  StreamSubscription<InternetStatus>? _subscription;

  void _init() {
    _subscription = _internetConnection.onStatusChange.listen((status) {
      if (status == InternetStatus.connected) {
        add(const ConnectionStatusConnected());
      } else {
        add(const ConnectionStatusDisconnected());
      }
    });
  }

  void _onConnected(
    ConnectionStatusConnected event,
    Emitter<AppConnectionState> emit,
  ) {
    if (state is Connected) return;
    emit(Connected());
    retryRunner.retryAll();
  }

  void _onDisconnected(
    ConnectionStatusDisconnected event,
    Emitter<AppConnectionState> emit,
  ) {
    if (state is Disconnected) return;
    emit(Disconnected());
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
