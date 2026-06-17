import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/domain/entities/place_entity.dart';
import 'package:mindtrip/core/shared/domain/repositories/favorites_repository.dart';
import 'package:mindtrip/core/shared/domain/usecases/get_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/sync_favorites_use_case.dart';
import 'package:mindtrip/core/shared/domain/usecases/toggle_favorite_use_case.dart';
import 'package:mindtrip/core/shared/favorite/cubit/favorite_cubit.dart';
import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/shared/auth/token_manager.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_user_interests_use_case.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/upload_profile_photo_use_case.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/core/theme/theme_data_/dark_theme_data.dart';
import 'package:mindtrip/core/theme/theme_data_/light_theme_data.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_remote_data_source.dart';
import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/places/routes/recommended_places_routes.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/fq_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/user_policy_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/settings_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/terms_of_service_screen.dart';
import 'package:mindtrip/features/profile/routes/profile_routes.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const sampleUser = UserEntity(
    userId: 'u-1',
    displayName: 'Mina Adel',
    email: 'mina@example.com',
    profilePhotoUrl: 'https://example.com/avatar.png',
    languagePreference: 'Arabic',
  );

  setUpAll(() {
    HydratedBloc.storage = _MemoryStorage();
  });

  setUp(() async {
    await HydratedBloc.storage.clear();
  });

  group('router', () {
    testWidgets('authenticated user can navigate to profile routes', (
      tester,
    ) async {
      final harness = _ProfileTestHarness(
        user: sampleUser,
        initialLocation: AppRoutes.home,
      );
      await harness.appGateCubit.loginSuccess();

      await _pumpApp(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profile);
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);

      harness.router.go(AppRoutes.editProfile);
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsOneWidget);

      harness.router.go(AppRoutes.profileSettings);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);

      harness.router.go(AppRoutes.profileTerms);
      await tester.pumpAndSettle();
      expect(find.byType(TermsOfServiceScreen), findsOneWidget);

      harness.router.go(AppRoutes.profilePolicy);
      await tester.pumpAndSettle();
      expect(find.byType(UserPolicyScreen), findsOneWidget);

      harness.router.go(AppRoutes.profileFaq);
      await tester.pumpAndSettle();
      expect(find.byType(FaqScreen), findsOneWidget);

      harness.dispose();
    });
  });

  group('profile widgets', () {
    testWidgets('profile screen renders user data from UserCubit', (
      tester,
    ) async {
      final harness = _ProfileTestHarness(
        user: sampleUser,
        initialLocation: AppRoutes.profile,
      );

      await _pumpApp(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('profile-avatar')), findsOneWidget);
      expect(find.text(sampleUser.displayName), findsOneWidget);
      expect(find.text(ProfileMockData.username), findsOneWidget);
      expect(find.text(ProfileMockData.location), findsOneWidget);

      harness.dispose();
    });

    testWidgets('edit profile screen renders initial user values', (
      tester,
    ) async {
      final harness = _ProfileTestHarness(
        user: sampleUser,
        initialLocation: AppRoutes.editProfile,
      );

      await _pumpApp(tester, harness);
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('edit-profile-display-name-row')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('edit-profile-email-row')), findsOneWidget);
      expect(find.text(sampleUser.displayName), findsOneWidget);
      expect(find.text(sampleUser.email), findsOneWidget);
      expect(find.text(ProfileMockData.phoneNumber), findsOneWidget);
      expect(find.text(ProfileMockData.username), findsWidgets);

      harness.dispose();
    });

    testWidgets('settings dark mode switch updates ThemeCubit', (tester) async {
      final harness = _ProfileTestHarness(
        user: sampleUser,
        initialLocation: AppRoutes.profileSettings,
      );

      await _pumpApp(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.system);

      await tester.tap(find.byKey(const Key('settings-dark-mode-switch')));
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.dispose();
    });

    testWidgets('settings logout button triggers logout flow', (tester) async {
      final harness = _ProfileTestHarness(
        user: sampleUser,
        initialLocation: AppRoutes.profileSettings,
      );
      await harness.appGateCubit.loginSuccess();

      await _pumpApp(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('settings-logout-button')));
      await tester.pumpAndSettle();

      expect(harness.appGateCubit.state, isA<AppGateUnauthenticated>());

      harness.dispose();
    });

    testWidgets('bottom nav highlights profile on all profile routes', (
      tester,
    ) async {
      for (final route in [
        AppRoutes.profile,
        AppRoutes.editProfile,
        AppRoutes.profileSettings,
      ]) {
        final harness = _ProfileTestHarness(
          user: sampleUser,
          initialLocation: route,
        );

        await _pumpApp(tester, harness);
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key('bottom-nav-profile-active')),
          findsOneWidget,
        );

        harness.dispose();
      }
    });
  });
}

class _ProfileTestHarness {
  _ProfileTestHarness({
    UserEntity? user,
    String initialLocation = AppRoutes.home,
  }) : user = user ?? sampleUser,
       themeCubit = ThemeCubit(),
       userCubit = _buildUserCubit(user ?? sampleUser),
       onboardingCubit = OnboardingCubit(
         completeOnboarding: CompleteOnboardingUseCase(
           _FakeOnboardingRepository(),
         ),
       ),
       appGateCubit = _buildAppGateCubit(_buildUserCubit(user ?? sampleUser)),
       router = _buildRouter(initialLocation);

  final UserEntity user;
  final ThemeCubit themeCubit;
  final UserCubit userCubit;
  final OnboardingCubit onboardingCubit;
  final AppGateCubit appGateCubit;
  final GoRouter router;

  static UserCubit _buildUserCubit(UserEntity user) {
    final fakeRepo = _FakeUserRepository(user);
    final cubit = UserCubit(
      getCurrentUser: GetCurrentUser(repository: fakeRepo),
      updateUserInterests: UpdateUserInterestsUseCase(fakeRepo),
      uploadProfilePhoto: UploadProfilePhotoUseCase(repository: fakeRepo),
    );
    cubit.setUser(user);
    return cubit;
  }

  static AppGateCubit _buildAppGateCubit(UserCubit userCubit) {
    final favoritesRepository = _FakeFavoritesRepository();
    return AppGateCubit(
      onboardingRepository: _FakeOnboardingRepository(),
      logoutUseCase: LogoutUseCase(repository: _FakeAuthRepository()),
      authLocal: AuthLocalDataSource(storage: _FakeSecureTokenStorage()),
      tokenManager: _FakeTokenManager(),
      googleAuthProvider: _FakeGoogleAuthProvider(),
      facebookAuthProvider: _FakeFacebookAuthProvider(),
      userCubit: userCubit,
      favoriteCubit: FavoriteCubit(
        toggleFavoriteUseCase: ToggleFavoriteUseCase(
          repository: favoritesRepository,
        ),
        getFavoritesUseCase: GetFavoritesUseCase(
          repository: favoritesRepository,
        ),
        syncFavoritesUseCase: SyncFavoritesUseCase(
          repository: favoritesRepository,
        ),
      ),
      favoritesRepository: favoritesRepository,
    );
  }

  static GoRouter _buildRouter(String initialLocation) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        HomeRoutes.homeRoute,
        ProfileRoutes.profileRoute,
        ...ProfileRoutes.routes,
      ],
    );
  }

  void dispose() {
    themeCubit.close();
    userCubit.close();
    onboardingCubit.close();
    appGateCubit.close();
  }
}

Future<void> _pumpApp(WidgetTester tester, _ProfileTestHarness harness) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>.value(value: harness.themeCubit),
            BlocProvider<UserCubit>.value(value: harness.userCubit),
            BlocProvider<AppGateCubit>.value(value: harness.appGateCubit),
            BlocProvider<OnboardingCubit>.value(value: harness.onboardingCubit),
          ],
          child: BlocBuilder<ThemeCubit, ThemeState>(
            bloc: harness.themeCubit,
            builder: (context, state) {
              return MaterialApp.router(
                theme: getLightTheme(),
                darkTheme: getDarkTheme(),
                themeMode: state.themeMode,
                routerConfig: harness.router,
              );
            },
          ),
        );
      },
    ),
  );

  await tester.pumpAndSettle();
}

const sampleUser = UserEntity(
  userId: 'default-user',
  displayName: 'Default User',
  email: 'default@example.com',
  profilePhotoUrl: 'https://example.com/default.png',
  languagePreference: 'English',
);

class _MemoryStorage implements Storage {
  final Map<String, dynamic> _store = <String, dynamic>{};

  @override
  Future<void> clear() async => _store.clear();

  @override
  Future<void> close() async {}

  @override
  Future<void> delete(String key) async => _store.remove(key);

  @override
  dynamic read(String key) => _store[key];

  @override
  Future<void> write(String key, dynamic value) async => _store[key] = value;
}

class _FakeOnboardingRepository implements OnboardingRepository {
  @override
  Future<bool> isFirstTime() async => false;

  @override
  Future<void> setNotFirstTime() async {}
}

class _FakeFavoritesRepository implements FavoritesRepository {
  final Set<String> _favoriteIds = <String>{};

  @override
  Future<Result<void>> clearAll() async {
    _favoriteIds.clear();
    return const Result.ok(null);
  }

  @override
  Future<Result<Set<String>>> getFavoriteIds() async => Result.ok(_favoriteIds);

  @override
  Future<Result<List<PlaceEntity>>> getFavoritePlaces({
    required Set<String> placeIds,
  }) async {
    return const Result.ok([]);
  }

  @override
  Future<Result<void>> syncPendingFavorites() async => const Result.ok(null);

  @override
  Future<Result<void>> toggleFavorite({
    required String placeId,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      _favoriteIds.add(placeId);
    } else {
      _favoriteIds.remove(placeId);
    }
    return const Result.ok(null);
  }
}

class _FakeSecureTokenStorage extends SecureTokenStorage {
  final Map<String, String?> _tokens = <String, String?>{};

  @override
  Future<void> clearTokens() async => _tokens.clear();

  @override
  Future<String?> getAccessToken() async => _tokens['access_token'];

  @override
  Future<String?> getRefreshToken() async => _tokens['refresh_token'];

  @override
  Future<void> saveAccessToken(String token) async {
    _tokens['access_token'] = token;
  }

  @override
  Future<void> saveRefreshToken(String token) async {
    _tokens['refresh_token'] = token;
  }
}

class _FakeGoogleAuthProvider extends GoogleAuthProvider {
  @override
  Future<String?> signIn() async => null;

  @override
  Future<void> signOut() async {}
}

class _FakeFacebookAuthProvider extends FacebookAuthProvider {
  @override
  Future<String?> signIn() async => null;

  @override
  Future<void> signOut() async {}
}

class _FakeUserRepository implements UserRepository {
  const _FakeUserRepository(this.user);

  final UserEntity user;

  @override
  Future<Result<UserEntity>> getCurrentUser() async => Result.ok(user);

  @override
  Future<Result<void>> updateInterests(List<String> interests) async =>
      const Result.ok(null);

  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async =>
      const Result.ok('https://cdn.example.com/uploaded_photo.jpg');

  @override
  Future<Result<void>> updateProfile({
    String? displayName,
    String? phoneNumber,
  }) async => const Result.ok(null);
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<UserEntity>> facebookAuth({required String token}) async {
    return Result.ok(sampleUser);
  }

  @override
  Future<Result<void>> forgetPassword({required String email}) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<UserEntity>> googleAuth({required String token}) async {
    return Result.ok(sampleUser);
  }

  @override
  Future<Result<void>> logout({required String refreshToken}) async =>
      const Result.ok(null);

  @override
  Future<Result<UserEntity>> refreshToken() async => Result.ok(sampleUser);

  @override
  Future<Result<void>> resendEmailOtp({required String email}) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> resendPasswordOtp({required String email}) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return Result.ok(sampleUser);
  }

  @override
  Future<Result<void>> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    return const Result.ok(null);
  }

  @override
  Future<Result<VerifyPasswordOtpEntity>> verifyPasswordOtp({
    required String email,
    required String otp,
  }) async {
    return Result.ok(VerifyPasswordOtpEntity(resetToken: 'test-token'));
  }
}

class _FakeTokenManager extends TokenManager {
  _FakeTokenManager()
    : super(
        authRemoteDataSource: AuthRemoteDataSource(api: _NullApiConsumer()),
        authLocalDataSource: AuthLocalDataSource(
          storage: _FakeSecureTokenStorage(),
        ),
      );

  @override
  Future<AuthResponseModel?> refreshIfNeeded() async => null;
}

class _NullApiConsumer implements ApiConsumer {
  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) => throw UnimplementedError();

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) => throw UnimplementedError();

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) => throw UnimplementedError();

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) => throw UnimplementedError();

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    CancelToken? cancelToken,
  }) => throw UnimplementedError();
}
