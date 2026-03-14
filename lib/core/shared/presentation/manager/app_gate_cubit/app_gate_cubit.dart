import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final LogoutUseCase logoutUseCase;
  final AuthLocalDataSource authLocal;
  final GoogleAuthProvider googleAuthProvider;
  final FacebookAuthProvider facebookAuthProvider;
  AppGateCubit({
    required this.onboardingRepository,
    required this.logoutUseCase,
    required this.authLocal,
    required this.googleAuthProvider,
    required this.facebookAuthProvider,
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
    await googleAuthProvider.signOut();
    await facebookAuthProvider.signOut();
    result.when(
      success: (_) {
        emit(AppGateUnauthenticated());
      },
      failure: (error) {
        // error state here later if needed,
        // log the user out locally .
        emit(AppGateUnauthenticated());
      },
    );
  }
}
