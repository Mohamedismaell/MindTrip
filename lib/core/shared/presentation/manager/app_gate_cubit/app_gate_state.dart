part of 'app_gate_cubit.dart';

sealed class AppGateState extends Equatable {
  const AppGateState();

  @override
  List<Object> get props => [];
}

final class AppGateLoading extends AppGateState {}

final class AppGateOnboarding extends AppGateState {}

final class AppGateUnauthenticated extends AppGateState {}

final class AppGateAuthenticated extends AppGateState {}
