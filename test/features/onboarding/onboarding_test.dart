import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/test/shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnboardingCubit', () {
    late OnboardingCubit cubit;
    late OnboardingRepository repository;

    setUp(() {
      repository = FakeOnboardingRepository(isFirstTime: true);
      cubit = OnboardingCubit(
        completeOnboarding: CompleteOnboardingUseCase(repository),
      );
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state has currentIndex 0 and isLastPage false', () {
      expect(cubit.state.currentIndex, 0);
      expect(cubit.state.isLastPage, false);
      expect(cubit.state.selectedCategories, isEmpty);
    });

    test('updateIndex changes currentIndex and isLastPage correctly', () {
      cubit.updateIndex(0);
      expect(cubit.state.currentIndex, 0);
      expect(cubit.state.isLastPage, false);

      cubit.updateIndex(1);
      expect(cubit.state.currentIndex, 1);
      expect(cubit.state.isLastPage, false);

      cubit.updateIndex(2);
      expect(cubit.state.currentIndex, 2);
      expect(cubit.state.isLastPage, true);
    });

    test('editSelectedCategory toggles category selection', () {
      cubit.editSelectedCategory('Beaches');
      expect(cubit.state.selectedCategories, contains('Beaches'));

      cubit.editSelectedCategory('Adventure');
      expect(cubit.state.selectedCategories, contains('Adventure'));
      expect(cubit.state.selectedCategories!.length, 2);

      cubit.editSelectedCategory('Beaches');
      expect(cubit.state.selectedCategories, isNot(contains('Beaches')));
      expect(cubit.state.selectedCategories!.length, 1);
    });

    test('finishOnboarding calls repository', () async {
      await cubit.finishOnboarding();
      expect(await repository.isFirstTime(), false);
    });
  });

  group('Onboarding Screen Navigation', () {
    testWidgets('navigates from onboarding to interests on last page', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('onboarding-screen')), findsOneWidget);

      await tester.tap(find.byKey(const Key('onboarding-next-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('interests-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('skip button navigates to welcome auth', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('onboarding-screen')), findsOneWidget);

      await tester.tap(find.byKey(const Key('onboarding-skip-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('welcome-auth-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('onboarding state updates when tapping next multiple times', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Onboarding 0'), findsOneWidget);
      expect(find.text('Is Last: false'), findsOneWidget);

      await tester.tap(find.byKey(const Key('onboarding-next-btn')));
      await tester.pumpAndSettle();

      expect(find.text('Onboarding 1'), findsOneWidget);

      await tester.tap(find.byKey(const Key('onboarding-next-btn')));
      await tester.pumpAndSettle();

      expect(find.text('Onboarding 2'), findsOneWidget);
      expect(find.text('Is Last: true'), findsOneWidget);

      harness.dispose();
    });
  });

  group('Interests Screen', () {
    testWidgets('renders interests screen with category buttons', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.interests);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('interests-screen')), findsOneWidget);
      expect(find.text('Select Interests'), findsOneWidget);
      expect(find.text('Selected: none'), findsOneWidget);
      expect(find.byKey(const Key('interest-Beaches')), findsOneWidget);
      expect(find.byKey(const Key('interest-Adventure')), findsOneWidget);
      expect(find.byKey(const Key('interest-Culture')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('tapping interest buttons updates selected categories', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.interests);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('interest-Beaches')));
      await tester.pumpAndSettle();
      expect(find.textContaining('Beaches'), findsOneWidget);

      await tester.tap(find.byKey(const Key('interest-Adventure')));
      await tester.pumpAndSettle();
      expect(find.textContaining('Adventure'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('save button is disabled when no interests selected', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.interests);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final saveButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('interests-save-btn')),
      );
      expect(saveButton.onPressed, isNull);

      harness.dispose();
    });

    testWidgets('save button is enabled when at least one interest selected', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.interests);

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

    testWidgets('save button calls finishOnboarding', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.interests,
        onboardingRepository: FakeOnboardingRepository(isFirstTime: true),
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('interest-Beaches')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('interests-save-btn')));
      await tester.pumpAndSettle();

      harness.dispose();
    });
  });

  group('Welcome Auth Screen', () {
    testWidgets('renders welcome auth screen with buttons', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.welcomeAuth);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('welcome-auth-screen')), findsOneWidget);
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.byKey(const Key('welcome-signup-btn')), findsOneWidget);
      expect(find.byKey(const Key('welcome-login-btn')), findsOneWidget);
    });

    testWidgets('sign up button navigates to signup', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.welcomeAuth);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('welcome-signup-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signup-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('login button navigates to signin', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.welcomeAuth);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('welcome-login-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-screen')), findsOneWidget);

      harness.dispose();
    });
  });

  group('Onboarding Flow Integration', () {
    testWidgets('complete onboarding flow: onboarding -> interests', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('onboarding-screen')), findsOneWidget);

      for (int i = 0; i < 3; i++) {
        await tester.tap(find.byKey(const Key('onboarding-next-btn')));
        await tester.pumpAndSettle();
      }

      expect(find.byKey(const Key('interests-screen')), findsOneWidget);

      await tester.tap(find.byKey(const Key('interest-Beaches')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('interests-save-btn')));
      await tester.pumpAndSettle();

      harness.dispose();
    });

    testWidgets('onboarding flow: onboarding -> skip -> welcome -> signup', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.onBoarding);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboarding-skip-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('welcome-auth-screen')), findsOneWidget);

      await tester.tap(find.byKey(const Key('welcome-signup-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signup-screen')), findsOneWidget);

      harness.dispose();
    });
  });
}
