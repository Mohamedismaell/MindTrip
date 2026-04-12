import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/core/theme/theme_data_/dark_theme_data.dart';
import 'package:mindtrip/core/theme/theme_data_/light_theme_data.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';
import 'package:mindtrip/features/authetication/domain/usecases/logout_use_case.dart';
import 'package:mindtrip/features/home/routes/home_routes.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/features/profile/presentation/data/profile_mock_data.dart';
import 'package:mindtrip/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/settings_screen.dart';
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
      final themeCubit = ThemeCubit();
      final userCubit = _buildUserCubit(sampleUser);
      final appGateCubit = _buildAppGateCubit(userCubit)..loginSuccess(sampleUser);
      final router = AppRouter(appGateCubit: appGateCubit).appRouter;

      await _pumpRouterApp(
        tester,
        router: router,
        userCubit: userCubit,
        themeCubit: themeCubit,
        appGateCubit: appGateCubit,
      );

      router.go(AppRoutes.profile);
      await tester.pumpAndSettle();
      expect(find.byType(ProfileScreen), findsOneWidget);

      router.go(AppRoutes.editProfile);
      await tester.pumpAndSettle();
      expect(find.byType(EditProfileScreen), findsOneWidget);

      router.go(AppRoutes.profileSettings);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });

  group('profile widgets', () {
    testWidgets('profile screen renders user data from UserCubit', (
      tester,
    ) async {
      final harness = _buildHarness(sampleUser, initialLocation: AppRoutes.profile);

      await _pumpRouterApp(
        tester,
        router: harness.router,
        userCubit: harness.userCubit,
        themeCubit: harness.themeCubit,
        appGateCubit: harness.appGateCubit,
      );

      expect(find.byKey(const Key('profile-avatar')), findsOneWidget);
      expect(find.text(sampleUser.displayName), findsOneWidget);
      expect(find.text(ProfileMockData.username), findsOneWidget);
      expect(find.text(ProfileMockData.location), findsOneWidget);
    });

    testWidgets('edit profile screen renders initial user values', (
      tester,
    ) async {
      final harness = _buildHarness(
        sampleUser,
        initialLocation: AppRoutes.editProfile,
      );

      await _pumpRouterApp(
        tester,
        router: harness.router,
        userCubit: harness.userCubit,
        themeCubit: harness.themeCubit,
        appGateCubit: harness.appGateCubit,
      );

      final displayNameField = tester.widget<TextFormField>(
        find
            .descendant(
              of: find.byKey(const Key('edit-profile-display-name-field')),
              matching: find.byType(TextFormField),
            )
            .first,
      );
      final emailField = tester.widget<TextFormField>(
        find
            .descendant(
              of: find.byKey(const Key('edit-profile-email-field')),
              matching: find.byType(TextFormField),
            )
            .first,
      );

      expect(displayNameField.controller?.text, sampleUser.displayName);
      expect(emailField.controller?.text, sampleUser.email);
      expect(find.text('Arabic'), findsOneWidget);
    });

    testWidgets('settings dark mode switch updates ThemeCubit', (
      tester,
    ) async {
      final harness = _buildHarness(
        sampleUser,
        initialLocation: AppRoutes.profileSettings,
      );

      await _pumpRouterApp(
        tester,
        router: harness.router,
        userCubit: harness.userCubit,
        themeCubit: harness.themeCubit,
        appGateCubit: harness.appGateCubit,
      );

      expect(harness.themeCubit.state.themeMode, ThemeMode.system);

      await tester.tap(find.byKey(const Key('settings-dark-mode-switch')));
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);
    });

    testWidgets('settings logout button triggers logout flow', (tester) async {
      final harness = _buildHarness(
        sampleUser,
        initialLocation: AppRoutes.profileSettings,
      );
      harness.appGateCubit.loginSuccess(sampleUser);

      await _pumpRouterApp(
        tester,
        router: harness.router,
        userCubit: harness.userCubit,
        themeCubit: harness.themeCubit,
        appGateCubit: harness.appGateCubit,
      );

      await tester.tap(find.byKey(const Key('settings-logout-button')));
      await tester.pumpAndSettle();

      expect(harness.appGateCubit.state, isA<AppGateUnauthenticated>());
    });

    testWidgets('bottom nav highlights profile on all profile routes', (
      tester,
    ) async {
      for (final route in [
        AppRoutes.profile,
        AppRoutes.editProfile,
        AppRoutes.profileSettings,
      ]) {
        final harness = _buildHarness(sampleUser, initialLocation: route);

        await _pumpRouterApp(
          tester,
          router: harness.router,
          userCubit: harness.userCubit,
          themeCubit: harness.themeCubit,
          appGateCubit: harness.appGateCubit,
        );

        expect(
          find.byKey(const Key('bottom-nav-profile-active')),
          findsOneWidget,
        );

        await tester.pumpWidget(const SizedBox.shrink());
      }
    });
  });
}

class _Harness {
  const _Harness({
    required this.router,
    required this.userCubit,
    required this.themeCubit,
    required this.appGateCubit,
  });

  final GoRouter router;
  final UserCubit userCubit;
  final ThemeCubit themeCubit;
  final AppGateCubit appGateCubit;
}

_Harness _buildHarness(UserEntity user, {required String initialLocation}) {
  final themeCubit = ThemeCubit();
  final userCubit = _buildUserCubit(user);
  final appGateCubit = _buildAppGateCubit(userCubit);

  return _Harness(
    router: GoRouter(
      initialLocation: initialLocation,
      routes: [
        ...HomeRoutes.routes,
        ...ProfileRoutes.routes,
      ],
    ),
    userCubit: userCubit,
    themeCubit: themeCubit,
    appGateCubit: appGateCubit,
  );
}

UserCubit _buildUserCubit(UserEntity user) {
  final cubit = UserCubit(
    getCurrentUser: GetCurrentUser(repository: _FakeUserRepository(user)),
  );
  cubit.setUser(user);
  return cubit;
}

AppGateCubit _buildAppGateCubit(UserCubit userCubit) {
  return AppGateCubit(
    onboardingRepository: _FakeOnboardingRepository(),
    logoutUseCase: LogoutUseCase(repository: _FakeAuthRepository()),
    authLocal: AuthLocalDataSource(storage: _FakeSecureTokenStorage()),
    googleAuthProvider: _FakeGoogleAuthProvider(),
    facebookAuthProvider: _FakeFacebookAuthProvider(),
    userCubit: userCubit,
  );
}

Future<void> _pumpRouterApp(
  WidgetTester tester, {
  required GoRouter router,
  required UserCubit userCubit,
  required ThemeCubit themeCubit,
  required AppGateCubit appGateCubit,
}) async {
  tester.view.physicalSize = const Size(393, 852);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>.value(value: userCubit),
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<AppGateCubit>.value(value: appGateCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: themeCubit,
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp.router(
              theme: getLightTheme(),
              darkTheme: getDarkTheme(),
              themeMode: state.themeMode,
              routerConfig: router,
            ),
          );
        },
      ),
    ),
  );

  await tester.pumpAndSettle();
}

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
  Future<void> saveSelectedCategories(List<String> categories) async {}

  @override
  Future<void> setNotFirstTime() async {}
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
}

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<UserEntity>> facebookAuth({required String token}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> forgetPassword({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity>> googleAuth({required String token}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> logout() async => const Result<void>.ok(null);

  @override
  Future<Result<UserEntity>> refreshToken() {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> resendEmailOtp({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> resendPasswordOtp({required String email}) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> verifyEmail({
    required String email,
    required String otp,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<VerifyPasswordOtpEntity>> verifyPasswordOtp({
    required String email,
    required String otp,
  }) {
    throw UnimplementedError();
  }
}
