import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
part 'app_gate_state.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [AppGateCubit] — Central navigation gate
///
/// Determines which flow the user should be in (onboarding, auth, or app)
/// and listens to [AuthCubit] for login/logout transitions. GoRouter's
/// [refreshListenable] reacts to state changes here, so **no manual
/// `context.go()` calls are needed** in auth screens.
/// ──────────────────────────────────────────────────────────────────────────────
class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final AuthCubit authCubit;

  StreamSubscription? _authSubscription;

  AppGateCubit({required this.onboardingRepository, required this.authCubit})
    : super(AppGateLoading());

  Future<void> start() async {
    final isFirstTime = await onboardingRepository.isFirstTime();

    if (isFirstTime) {
      emit(AppGateOnboarding());
    } else {
      emit(AppGateUnauthenticated());
    }
    _listenToAuthChanges();
  }

  /// Listens to [AuthCubit] state transitions.
  ///
  /// • [AuthStatus.success] → user is logged in → [AppGateAuthenticated]
  /// • [AuthStatus.initial] → user logged out / no session → [AppGateUnauthenticated]
  void _listenToAuthChanges() {
    _authSubscription = authCubit.stream.listen((authState) {
      if (authState.status == AuthStatus.success) {
        emit(AppGateAuthenticated());
      } else if (authState.status == AuthStatus.initial) {
        // Only revert to unauthenticated if we were previously authenticated
        // (i.e. the user logged out). Ignore the initial app-start emission.
        if (state is AppGateAuthenticated) {
          emit(AppGateUnauthenticated());
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await _authSubscription?.cancel();
    return super.close();
  }
}
