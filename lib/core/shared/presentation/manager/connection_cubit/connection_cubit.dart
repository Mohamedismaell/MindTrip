import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mindtrip/core/connections/retry_runner.dart';

part 'connection_state.dart';

class AppConnectionCubit extends Cubit<AppConnectionState> {
  AppConnectionCubit(this._internetConnection, this.retryRunner)
    : super(ConnectionInitial()) {
    _init();
  }
  final InternetConnection _internetConnection;
  final RetryRunner retryRunner;
  StreamSubscription<InternetStatus>? _subscription;

  void _init() {
    _subscription = _internetConnection.onStatusChange.listen((
      InternetStatus status,
    ) {
      if (status == InternetStatus.connected) {
        emit(Connected());
        retryRunner.retryAll();
      } else {
        emit(Disconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
