import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final AuthCubit authCubit;
  final AuthLocalDataSource authLocal;
  StreamSubscription? _authSubscription;

  AppGateCubit({
    required this.onboardingRepository,
    required this.authCubit,
    required this.authLocal,
  }) : super(AppGateLoading());

  Future<void> start() async {
    final isFirstTime = await onboardingRepository.isFirstTime();

    if (isFirstTime) {
      emit(AppGateOnboarding());
    }
    final token = await authLocal.getAccessToken();

    if (token != null && token.isNotEmpty) {
      emit(AppGateAuthenticated());
      print('token == > $token');
    } else {
      emit(AppGateUnauthenticated());
    }
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = authCubit.stream.listen((authState) {
      if (authState.status == AuthStatus.success) {
        emit(AppGateAuthenticated());
      } else if (authState.status == AuthStatus.initial) {
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
