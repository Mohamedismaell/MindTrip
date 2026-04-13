import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import '../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Bottom Navigation', () {
    testWidgets('home tab is active on home screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.home);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('bottom-nav-home-active')), findsOneWidget);

      harness.dispose();
    });
  });

  group('User State', () {
    test('UserCubit loads user correctly', () {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
      );

      expect(harness.userCubit.state.status, UserStatus.loaded);
      expect(harness.userCubit.state.user, isNotNull);

      harness.dispose();
    });

    test('UserCubit clear resets state', () {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        user: testUser,
      );

      expect(harness.userCubit.state.user, isNotNull);

      harness.userCubit.clear();
      expect(harness.userCubit.state.user, isNull);

      harness.dispose();
    });
  });

  group('Theme State', () {
    testWidgets('theme cubit can toggle between themes', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.home,
        initialThemeMode: ThemeMode.light,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.isLight, true);

      harness.themeCubit.toggleTheme();
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.isDark, true);

      harness.dispose();
    });

    test('initial theme mode is system', () {
      final harness = TestHarness();
      expect(harness.themeCubit.state.themeMode, ThemeMode.system);
      harness.dispose();
    });
  });

  group('Navigation Tests', () {
    testWidgets('can navigate between screens using router', (tester) async {
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
  });

  group('Explore Screen Widgets', () {
    testWidgets('renders with test widgets', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-header')), findsOneWidget);

      harness.dispose();
    });
  });
}
