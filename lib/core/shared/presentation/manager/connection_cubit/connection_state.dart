part of 'connection_cubit.dart';

sealed class AppConnectionState extends Equatable {
  const AppConnectionState();

  @override
  List<Object> get props => [];
}

final class ConnectionInitial extends AppConnectionState {}

final class Connected extends AppConnectionState {}

final class Disconnected extends AppConnectionState {}
