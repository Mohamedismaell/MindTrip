import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';
import 'package:mindtrip/core/shared/presentation/bloc/safe_cubit.dart';
import 'package:mindtrip/features/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/core/shared/presentation/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindtrip/core/shared/presentation/manager/trip_favorite_cubit/trip_favorite_cubit.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';
part 'app_gate_state.dart';

class AppGateCubit extends SafeCubit<AppGateState> {
  final OnboardingRepository onboardingRepository;
  final LogoutUseCase logoutUseCase;
  final AuthLocalDataSource authLocal;
  final TokenManager tokenManager;
  final GoogleAuthProvider googleAuthProvider;
  final FacebookAuthProvider facebookAuthProvider;
  final UserCubit userCubit;
  final FavoriteCubit favoriteCubit;
  final TripFavoriteCubit tripFavoriteCubit;
  final FavoritesRepository favoritesRepository;

  bool _isLoggingOut = false;

  AppGateCubit({
    required this.onboardingRepository,
    required this.logoutUseCase,
    required this.authLocal,
    required this.tokenManager,
    required this.googleAuthProvider,
    required this.facebookAuthProvider,
    required this.userCubit,
    required this.favoriteCubit,
    required this.tripFavoriteCubit,
    required this.favoritesRepository,
  }) : super(AppGateLoading());

  Future<void> start() async {
    if (_isLoggingOut) return;
    final isFirstTime = await onboardingRepository.isFirstTime();

    if (isFirstTime) {
      emitSafe(AppGateOnboarding());
      return;
    }

    // Check if we have either token — a refresh token is enough to restore a session.
    final accessToken = await authLocal.getAccessToken();
    final refreshToken = await authLocal.getRefreshToken();

    if ((accessToken == null || accessToken.isEmpty) &&
        (refreshToken == null || refreshToken.isEmpty)) {
      emitSafe(AppGateUnauthenticated());
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
    emitSafe(AppGateUnauthenticated());
  }

  void _navigateAfterLoad() {
    if (userCubit.state.user?.interests == null ||
        userCubit.state.user!.interests!.isEmpty) {
      emitSafe(AppGateInterestsRequired());
    } else {
      favoriteCubit.loadFavorites();
      tripFavoriteCubit.loadFavoriteTrips();
      emitSafe(AppGateAuthenticated());
    }
  }

  Future<void> loginSuccess() async {
    emitSafe(AppGateLoading());

    await userCubit.loadUser();

    if (userCubit.state.userStatus != UserStatus.loaded) {
      emitSafe(AppGateUnauthenticated());
      return;
    }

    final user = userCubit.state.user;
    favoriteCubit.loadFavorites();
    tripFavoriteCubit.loadFavoriteTrips();

    if (user == null || user.interests == null || user.interests!.isEmpty) {
      emitSafe(AppGateInterestsRequired());
    } else {
      emitSafe(AppGateAuthenticated());
    }
  }

  void interestsComplete() {
    emitSafe(AppGateAuthenticated());
  }

  void proceedToAuth() {
    emitSafe(AppGateUnauthenticated());
  }

  Future<void> logout() async {
    // Guard against multiple logout
    if (state is AppGateUnauthenticated || _isLoggingOut) return;

    _isLoggingOut = true;
    final refreshToken = await authLocal.getRefreshToken();

    // 1. Emit loading to show the Splash screen while waiting for remote APIs
    emitSafe(AppGateLoading());

    if (refreshToken == null || refreshToken.isEmpty) {
      await _performLocalLogout();
      return;
    }

    final result = await logoutUseCase(refreshToken: refreshToken);

    result.when(
      success: (_) async {
        await _performLocalLogout();
      },
      failure: (error) async {
        await _performLocalLogout();
      },
      cancelled: () async {
        await _performLocalLogout();
      },
    );
  }

  Future<void> _performLocalLogout() async {
    await googleAuthProvider.signOut();
    await facebookAuthProvider.signOut();
    await authLocal.clear();
    userCubit.clear();
    favoriteCubit.clear();
    tripFavoriteCubit.clear();
    await favoritesRepository.clearAll();

    emitSafe(AppGateUnauthenticated());
    _isLoggingOut = false;
  }

  Future<void> accountDeleted() async {
    if (state is AppGateUnauthenticated || _isLoggingOut) return;

    _isLoggingOut = true;
    emitSafe(AppGateLoading());

    await _performLocalLogout();
  }
}
