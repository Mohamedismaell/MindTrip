part of 'connection_bloc.dart';

sealed class AppConnectionEvent {
  const AppConnectionEvent();
}

final class ConnectionStatusConnected extends AppConnectionEvent {
  const ConnectionStatusConnected();
}

final class ConnectionStatusDisconnected extends AppConnectionEvent {
  const ConnectionStatusDisconnected();
}
