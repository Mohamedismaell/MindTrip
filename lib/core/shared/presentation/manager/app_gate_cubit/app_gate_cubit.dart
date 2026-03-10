import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final LogoutUseCase logoutUseCase;
  final AuthLocalDataSource authLocal;

  AppGateCubit({
    required this.onboardingRepository,
    required this.logoutUseCase,
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
  }

  void loginSuccess() {
    emit(AppGateAuthenticated());
  }

  Future<void> logout() async {
    emit(AppGateLoading());
    final result = await logoutUseCase();
    result.when(
      success: (_) {
        emit(AppGateUnauthenticated());
      },
      failure: (error) {
        // You could emit an error state here if needed,
        // but typically you still log the user out locally or show a toast.
        emit(AppGateUnauthenticated());
      },
    );
  }
}
