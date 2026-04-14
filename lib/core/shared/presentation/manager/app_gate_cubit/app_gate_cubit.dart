import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
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
      await userCubit.loadUser();

      if (userCubit.state.status == UserStatus.loaded) {
        if (userCubit.state.user?.interests == null ||
            userCubit.state.user!.interests!.isEmpty) {
          emit(AppGateInterestsRequired());
        } else {
          emit(AppGateAuthenticated());
        }
        print('token == > $token');
      } else {
        await authLocal.clear();
        emit(AppGateUnauthenticated());
      }
    } else {
      emit(AppGateUnauthenticated());
    }
  }

  Future<void> loginSuccess() async {
    await userCubit.loadUser();

    if (userCubit.state.status != UserStatus.loaded) {
      emit(AppGateUnauthenticated());
      return;
    }

    final user = userCubit.state.user;
    if (user == null || user.interests == null || user.interests!.isEmpty) {
      emit(AppGateInterestsRequired());
    } else {
      emit(AppGateAuthenticated());
    }
  }

  void interestsComplete() {
    emit(AppGateAuthenticated());
  }

  Future<void> logout() async {
    emit(AppGateLoading());
    final refreshToken = await authLocal.getRefreshToken();
    final result = await logoutUseCase(refreshToken: refreshToken!);
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
