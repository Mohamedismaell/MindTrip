import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/features/home/presentation/data/home_mock_data.dart';
import 'package:mindtrip/features/home/presentation/screens/home_screen.dart';
import 'package:mindtrip/features/home/routes/home_routes.dart';
import 'package:mindtrip/test/shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('HomeScreen', () {
    testWidgets('renders home screen with all sections', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-home-active')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders home header with user info', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('HI, Laila'), findsOneWidget);
      expect(find.text('Cairo, Egypt'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders search bar', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Search destinations, places...'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders category list', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final category in HomeMockData.categories) {
        expect(find.text(category.label), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders section headers', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Popular Destinations'), findsOneWidget);
      expect(find.text('Recommended'), findsOneWidget);
      expect(find.text('Tour Packages'), findsOneWidget);
      expect(find.text('AI Planner'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders popular destinations', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final destination in HomeMockData.popularDestinations) {
        expect(find.text(destination.title), findsOneWidget);
        expect(find.text(destination.location), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders recommended destinations with prices', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final destination in HomeMockData.recommendedDestinations) {
        expect(find.text(destination.title), findsOneWidget);
        expect(find.text(destination.location), findsOneWidget);
        expect(find.text(destination.priceTag), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders tour packages', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final package in HomeMockData.tourPackages) {
        expect(find.text(package.title), findsOneWidget);
        expect(find.text(package.location), findsOneWidget);
        expect(find.text(package.price), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders AI planner section', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final plan in HomeMockData.plannerPreviews) {
        expect(find.text(plan.title), findsOneWidget);
        expect(find.text(plan.badge), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders bottom navigation with all items', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-home-active')), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-saved-inactive')), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-explore-inactive')), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-ai-inactive')), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-profile-inactive')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('bottom nav has correct labels', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Saved'), findsOneWidget);
      expect(find.text('Explore'), findsOneWidget);
      expect(find.text('AI'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);

      harness.dispose();
    });
  });

  group('HomeScreen Navigation', () {
    testWidgets('navigates to explore when explore tab tapped', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders correct bottom nav state for home', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-home-active')), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-explore-inactive')), findsOneWidget);
      expect(find.byKey(const Key('bottom-nav-profile-inactive')), findsOneWidget);

      harness.dispose();
    });
  });

  group('HomeScreen Theme', () {
    testWidgets('respects theme mode from ThemeCubit', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        initialThemeMode: ThemeMode.dark,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.dispose();
    });

    testWidgets('theme cubit can toggle between themes', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        initialThemeMode: ThemeMode.light,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.light);

      harness.themeCubit.toggleTheme();
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.themeCubit.toggleTheme();
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.light);

      harness.dispose();
    });
  });

  group('HomeScreen User', () {
    testWidgets('displays user profile image url', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.userCubit.state.user, isNotNull);
      expect(harness.userCubit.state.user!.displayName, testUser.displayName);

      harness.dispose();
    });

    testWidgets('user cubit loads user correctly', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.userCubit.state.status, UserStatus.loaded);
      expect(harness.userCubit.state.user, isNotNull);

      harness.dispose();
    });

    testWidgets('user cubit clear resets state', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.userCubit.state.user, isNotNull);

      harness.userCubit.clear();
      await tester.pumpAndSettle();

      expect(harness.userCubit.state.user, isNull);

      harness.dispose();
    });
  });

  group('HomeScreen Scroll', () {
    testWidgets('screen is scrollable', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final scrollable = find.byType(CustomScrollView);
      expect(scrollable, findsOneWidget);

      harness.dispose();
    });
  });

  group('HomeRoutes', () {
    testWidgets('home route renders HomeScreen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);

      harness.dispose();
    });
  });
}
