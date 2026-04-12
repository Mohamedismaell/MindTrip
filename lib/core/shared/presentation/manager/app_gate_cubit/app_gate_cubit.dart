import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final LogoutUseCase logoutUseCase;
  final AuthLocalDataSource authLocal;
  final GoogleAuthProvider googleAuthProvider;
  final FacebookAuthProvider facebookAuthProvider;
  final UserCubit userCubit;

  AppGateCubit({
    required this.onboardingRepository,
    required this.logoutUseCase,
    required this.authLocal,
    required this.googleAuthProvider,
    required this.facebookAuthProvider,
    required this.userCubit,
  }) : super(AppGateLoading());

  Future<void> start() async {
    final isFirstTime = await onboardingRepository.isFirstTime();

    if (isFirstTime) {
      emit(AppGateOnboarding());
      return;
    }

    final token = await authLocal.getAccessToken();

    if (token != null && token.isNotEmpty) {
      // Token exists — fetch user data from API to validate session.
      await userCubit.loadUser();

      if (userCubit.state.status == UserStatus.loaded) {
        emit(AppGateAuthenticated());
        print('token == > $token');
      } else {
        // Token is invalid / expired and refresh also failed.
        await authLocal.clear();
        emit(AppGateUnauthenticated());
      }
    } else {
      emit(AppGateUnauthenticated());
    }
  }

  /// Called after a successful login — sets the user and navigates to home.
  void loginSuccess(UserEntity user) {
    userCubit.setUser(user);
    emit(AppGateAuthenticated());
  }

  Future<void> logout() async {
    emit(AppGateLoading());
    final result = await logoutUseCase();
    await googleAuthProvider.signOut();
    await facebookAuthProvider.signOut();
    userCubit.clear();
    result.when(
      success: (_) {
        emit(AppGateUnauthenticated());
      },
      failure: (error) {
        // Log the user out locally anyway.
        emit(AppGateUnauthenticated());
      },
    );
  }
}
