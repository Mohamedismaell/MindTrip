import 'dart:async';
import 'dart:ui';

import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';

mixin RefreshOnReconnect {
  late final StreamSubscription _connectionSub;

  void reconnect(AppConnectionCubit connectionCubit, VoidCallback onReconnect) {
    _connectionSub = connectionCubit.stream.listen((state) {
      if (state is Connected) {
        onReconnect();
      }
    });
  }

  void disposeReconnect() {
    _connectionSub.cancel();
  }
}
