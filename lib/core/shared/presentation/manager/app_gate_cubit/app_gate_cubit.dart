import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends Cubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final LogoutUseCase logoutUseCase;
  final AuthLocalDataSource authLocal;
  final TokenManager tokenManager;
  final GoogleAuthProvider googleAuthProvider;
  final FacebookAuthProvider facebookAuthProvider;
  final UserCubit userCubit;
  final FavoriteCubit favoriteCubit;
  final FavoritesRepository favoritesRepository;

  AppGateCubit({
    required this.onboardingRepository,
    required this.logoutUseCase,
    required this.authLocal,
    required this.tokenManager,
    required this.googleAuthProvider,
    required this.facebookAuthProvider,
    required this.userCubit,
    required this.favoriteCubit,
    required this.favoritesRepository,
  }) : super(AppGateLoading());

  Future<void> start() async {
    final isFirstTime = await onboardingRepository.isFirstTime();

    if (isFirstTime) {
      emit(AppGateOnboarding());
      return;
    }

    // Check if we have either token — a refresh token is enough to restore a session.
    final accessToken = await authLocal.getAccessToken();
    final refreshToken = await authLocal.getRefreshToken();

    if ((accessToken == null || accessToken.isEmpty) &&
        (refreshToken == null || refreshToken.isEmpty)) {
      emit(AppGateUnauthenticated());
      return;
    }

    // Try loading the user. The AuthInterceptor will transparently handle a
    // 401 by refreshing the access token and retrying the request.
    await userCubit.loadUser();

    if (userCubit.state.userStatus == UserStatus.loaded) {
      _navigateAfterLoad();
      return;
    }

    // loadUser() failed (e.g. the interceptor refresh also failed, or there
    // was no access token at all). Try an explicit token refresh as a last
    // resort before giving up.
    if (refreshToken != null && refreshToken.isNotEmpty) {
      final newTokens = await tokenManager.refreshIfNeeded();
      if (newTokens != null) {
        // Refresh succeeded — retry loading the user with the new tokens.
        await userCubit.loadUser();
        if (userCubit.state.userStatus == UserStatus.loaded) {
          _navigateAfterLoad();
          return;
        }
      }
    }

    // Both attempts failed — the session is truly expired. Clear credentials
    // and send the user to the auth screen.
    await authLocal.clear();
    emit(AppGateUnauthenticated());
  }

  void _navigateAfterLoad() {
    if (userCubit.state.user?.interests == null ||
        userCubit.state.user!.interests!.isEmpty) {
      emit(AppGateInterestsRequired());
    } else {
      emit(AppGateAuthenticated());
    }
  }

  Future<void> loginSuccess() async {
    emit(AppGateLoading());

    await userCubit.loadUser();

    if (userCubit.state.userStatus != UserStatus.loaded) {
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

  void proceedToAuth() {
    emit(AppGateUnauthenticated());
  }

  Future<void> logout() async {
    emit(AppGateLoading());
    final refreshToken = await authLocal.getRefreshToken();

    await googleAuthProvider.signOut();
    await facebookAuthProvider.signOut();
    userCubit.clear();
    favoriteCubit.clear();
    await favoritesRepository.clearAll();
    if (refreshToken == null || refreshToken.isEmpty) {
      emit(AppGateUnauthenticated());
      return;
    }

    final result = await logoutUseCase(refreshToken: refreshToken);

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

  Future<void> accountDeleted() async {
    emit(AppGateLoading());
    await googleAuthProvider.signOut();
    await facebookAuthProvider.signOut();
    userCubit.clear();
    favoriteCubit.clear();
    await favoritesRepository.clearAll();
    await authLocal.clear();
    emit(AppGateUnauthenticated());
  }
}
