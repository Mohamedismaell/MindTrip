import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttproj/features/onboarding/domain/repositories/auth_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;

  StreamSubscription? _authSubscription;

  AppGateCubit({required this.onboardingRepository}) : super(AppGateLoading()) {
    start();
  }

  Future<void> start() async {
    final isFirstTime = await onboardingRepository.isFirstTime();

    if (isFirstTime) {
      emit(AppGateOnboarding());
    } else {
      emit(AppGateUnauthenticated());
    }
    // _listenToAuthChanges();
  }

  // void _listenToAuthChanges() {
  //   _authSubscription = client.auth.onAuthStateChange.listen((event) {
  //     final currentSession = event.session;
  //     if (currentSession == null) {
  //       emit(AppGateUnauthenticated());
  //     } else {
  //       emit(AppGateAuthenticated());
  //     }
  //   });
  // }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
