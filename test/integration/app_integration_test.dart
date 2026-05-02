import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import '../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('App Gate Cubit', () {
    late TestHarness harness;

    setUp(() {
      harness = TestHarness(user: testUser, accessToken: 'valid-token');
    });

    tearDown(() {
      harness.dispose();
    });

    test('initial state can be set to authenticated', () {
      harness.appGateCubit.loginSuccess(testUser);
      expect(harness.appGateCubit.state, isA<AppGateAuthenticated>());
    });

    test(
      'loginSuccess sets user and emits authenticated when interests exist',
      () {
        harness.appGateCubit.loginSuccess(testUser);
        expect(harness.userCubit.state.user, testUser);
      },
    );

    test('loginSuccess emits interests required when no interests', () {
      const userWithoutInterests = UserEntity(
        userId: 'test-no-interests',
        displayName: 'No Interests User',
        email: 'nointerests@example.com',
        interests: [],
      );
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

  group('Navigation Flow Tests', () {
    testWidgets('onboarding screen renders with test harness', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('onboarding-screen')), findsOneWidget);
      expect(find.text('Onboarding 0'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('interests screen renders with test harness', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.onboardingInterests,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('interests-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('sign in screen renders with test harness', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('sign up screen renders with test harness', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.signup);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signup-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('navigates from onboarding to interests', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

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

    testWidgets('skip onboarding navigates to welcome', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboarding-skip-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('welcome-auth-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('sign in error handling', (tester) async {
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

    testWidgets('empty interests selection disables save button', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.onboardingInterests,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final saveButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('interests-save-btn')),
      );
      expect(saveButton.onPressed, isNull);

      harness.dispose();
    });

    testWidgets('selecting interest enables save button', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.onboardingInterests,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('interest-Beaches')));
      await tester.pumpAndSettle();

      final saveButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('interests-save-btn')),
      );
      expect(saveButton.onPressed, isNotNull);

      harness.dispose();
    });
  });
}
