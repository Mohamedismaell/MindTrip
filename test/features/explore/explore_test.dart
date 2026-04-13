import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import '../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExploreScreen Widget Tests', () {
    testWidgets('explore header renders', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-header')), findsOneWidget);
      expect(find.text('Explore'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders search bar', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-search-bar')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders category chips', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-category-chips')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders tab bar', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-tab-bar')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders results bar', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-results-bar')), findsOneWidget);

      harness.dispose();
    });
  });

  group('Explore Navigation', () {
    testWidgets('explore tab shows explore screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explore-header')), findsOneWidget);

      harness.dispose();
    });
  });
}
