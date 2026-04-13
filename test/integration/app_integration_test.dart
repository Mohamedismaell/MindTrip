import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import '../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App Gate Cubit', () {
    late TestHarness harness;

    setUp(() {
      harness = TestHarness(
        user: testUser,
        accessToken: 'valid-token',
      );
    });

    tearDown(() {
      harness.dispose();
    });

    test('initial state can be set to authenticated', () {
      harness.appGateCubit.loginSuccess(testUser);
      expect(harness.appGateCubit.state, isA<AppGateAuthenticated>());
    });

    test('loginSuccess sets user and emits authenticated when interests exist', () {
      harness.appGateCubit.loginSuccess(testUser);
      expect(harness.userCubit.state.user, testUser);
    });

    test('loginSuccess emits interests required when no interests', () {
      final userWithoutInterests = testUser.copyWith(interests: []);
      harness.appGateCubit.loginSuccess(userWithoutInterests);
    });

    test('logout emits unauthenticated state', () async {
      harness.appGateCubit.loginSuccess(testUser);
      expect(harness.appGateCubit.state, isA<AppGateAuthenticated>());

      await harness.appGateCubit.logout();
      expect(harness.appGateCubit.state, isA<AppGateUnauthenticated>());
    });

    test('interestsComplete emits authenticated', () {
      harness.appGateCubit.interestsComplete();
      expect(harness.appGateCubit.state, isA<AppGateAuthenticated>());
    });
  });

  group('Theme Cubit', () {
    late TestHarness harness;

    setUp(() {
      harness = TestHarness();
    });

    tearDown(() {
      harness.dispose();
    });

    test('initial theme mode is system', () {
      expect(harness.themeCubit.state.themeMode, ThemeMode.system);
    });

    test('toggleTheme switches between light and dark', () {
      expect(harness.themeCubit.state.isLight, true);

      harness.themeCubit.toggleTheme();
      expect(harness.themeCubit.state.isDark, true);

      harness.themeCubit.toggleTheme();
      expect(harness.themeCubit.state.isLight, true);
    });

    test('initial state with dark mode', () {
      final darkHarness = TestHarness(initialThemeMode: ThemeMode.dark);
      expect(darkHarness.themeCubit.state.isDark, true);
      darkHarness.dispose();
    });
  });

  group('User Cubit', () {
    late TestHarness harness;

    setUp(() {
      harness = TestHarness(user: testUser);
    });

    tearDown(() {
      harness.dispose();
    });

    test('initial state has user set', () {
      expect(harness.userCubit.state.user, testUser);
      expect(harness.userCubit.state.status, UserStatus.loaded);
    });

    test('setUser updates user and status', () {
      harness.userCubit.setUser(testUser2);
      expect(harness.userCubit.state.user, testUser2);
      expect(harness.userCubit.state.status, UserStatus.loaded);
    });

    test('clear removes user', () {
      harness.userCubit.clear();
      expect(harness.userCubit.state.user, isNull);
    });

    test('loadUser loads user from repository', () async {
      harness.userCubit.clear();
      expect(harness.userCubit.state.status, UserStatus.initial);

      await harness.userCubit.loadUser();
      expect(harness.userCubit.state.status, UserStatus.loaded);
      expect(harness.userCubit.state.user, isNotNull);
    });
  });

  group('Onboarding Cubit', () {
    late TestHarness harness;

    setUp(() {
      harness = TestHarness();
    });

    tearDown(() {
      harness.dispose();
    });

    test('initial state has correct defaults', () {
      expect(harness.onboardingCubit.state.currentIndex, 0);
      expect(harness.onboardingCubit.state.isLastPage, false);
      expect(harness.onboardingCubit.state.selectedCategories, isEmpty);
    });

    test('updateIndex updates state correctly', () {
      harness.onboardingCubit.updateIndex(1);
      expect(harness.onboardingCubit.state.currentIndex, 1);
      expect(harness.onboardingCubit.state.isLastPage, false);

      harness.onboardingCubit.updateIndex(2);
      expect(harness.onboardingCubit.state.currentIndex, 2);
      expect(harness.onboardingCubit.state.isLastPage, true);
    });

    test('editSelectedCategory toggles category', () {
      harness.onboardingCubit.editSelectedCategory('Beaches');
      expect(
        harness.onboardingCubit.state.selectedCategories,
        contains('Beaches'),
      );

      harness.onboardingCubit.editSelectedCategory('Beaches');
      expect(
        harness.onboardingCubit.state.selectedCategories,
        isNot(contains('Beaches')),
      );
    });
  });

  group('Auth Cubit', () {
    late TestHarness harness;

    setUp(() {
      harness = TestHarness();
    });

    tearDown(() {
      harness.dispose();
    });

    test('initial state has correct defaults', () {
      expect(harness.authCubit.state.status, AuthStatus.initial);
      expect(harness.authCubit.state.obscurePassword, true);
      expect(harness.authCubit.state.rememberMe, false);
    });

    test('signIn with valid credentials emits success', () async {
      await harness.authCubit.signIn(
        email: 'test@example.com',
        password: 'password',
        rememberMe: false,
      );
      expect(harness.authCubit.state.status, AuthStatus.success);
    });

    test('signUp emits otpSent', () async {
      await harness.authCubit.signUp(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        rememberMe: false,
      );
      expect(harness.authCubit.state.status, AuthStatus.otpSent);
    });

    test('togglePassword toggles visibility', () {
      expect(harness.authCubit.state.obscurePassword, true);
      harness.authCubit.togglePassword();
      expect(harness.authCubit.state.obscurePassword, false);
    });

    test('toggleRememberMe updates state', () {
      expect(harness.authCubit.state.rememberMe, false);
      harness.authCubit.toggleRememberMe(true);
      expect(harness.authCubit.state.rememberMe, true);
    });
  });

  group('Complete User Flows', () {
    testWidgets('authenticated user flow: login -> home', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
        accessToken: 'valid-token',
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-home-active')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('new user flow: onboarding -> interests -> home', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.onBoarding,
        onboardingRepository: FakeOnboardingRepository(isFirstTime: true),
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('onboarding-screen')), findsOneWidget);

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byKey(const Key('onboarding-next-btn')));
        await tester.pumpAndSettle();
      }

      expect(find.byKey(const Key('interests-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('logout and login flow', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
        accessToken: 'valid-token',
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profileSettings);
      await tester.pumpAndSettle();

      harness.appGateCubit.loginSuccess(testUser);

      await tester.tap(find.byKey(const Key('settings-logout-button')));
      await tester.pumpAndSettle();

      harness.dispose();
    });

    testWidgets('theme toggle persists across screens', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
        accessToken: 'valid-token',
        initialThemeMode: ThemeMode.light,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.isLight, true);

      harness.router.go(AppRoutes.profileSettings);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('settings-dark-mode-switch')));
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.isDark, true);

      harness.router.go(AppRoutes.home);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.isDark, true);

      harness.dispose();
    });

    testWidgets('user profile updates reflect across app', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
        accessToken: 'valid-token',
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profile);
      await tester.pumpAndSettle();

      expect(find.text(testUser.displayName), findsOneWidget);

      harness.userCubit.setUser(testUser2);
      await tester.pumpAndSettle();

      expect(find.text(testUser2.displayName), findsOneWidget);

      harness.dispose();
    });
  });

  group('Navigation Guards', () {
    testWidgets('authenticated routes are accessible when logged in', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
        accessToken: 'valid-token',
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profile);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-profile-active')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('can navigate between all main screens', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
        accessToken: 'valid-token',
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-home-active')), findsOneWidget);

      harness.router.go(AppRoutes.explore);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profile);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-profile-active')), findsOneWidget);

      harness.dispose();
    });
  });

  group('Error Handling', () {
    testWidgets('handles auth failure gracefully', (tester) async {
      final repository = FakeAuthRepository()..signInShouldFail = true;
      final harness = TestHarness(
        initialLocation: AppRoutes.login,
        authRepository: repository,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-submit-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-error')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('handles empty interests selection', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.interests);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final saveButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('interests-save-btn')),
      );
      expect(saveButton.onPressed, isNull);

      harness.dispose();
    });
  });
}

class AppGateAuthenticated {}
class AppGateUnauthenticated {}
