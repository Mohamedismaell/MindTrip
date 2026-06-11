import 'dart:async';
import 'dart:ui';

import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_bloc.dart';

mixin RefreshOnReconnect {
  late final StreamSubscription _connectionSub;

  void reconnect(AppConnectionBloc connectionBloc, VoidCallback onReconnect) {
    _connectionSub = connectionBloc.stream.listen((state) {
      if (state is Connected) {
        onReconnect();
      }
    });
  }

  void disposeReconnect() {
    _connectionSub.cancel();
  }
}
