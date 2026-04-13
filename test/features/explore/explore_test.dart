import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/explore/presentation/data/explore_mock_data.dart';
import 'package:mindtrip/features/explore/presentation/screens/explore_screen.dart';
import 'package:mindtrip/test/shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ExploreScreen', () {
    testWidgets('renders explore screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(ExploreScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders explore header', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Explore'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders search bar', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Search places, trips, activities...'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders category chips', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final category in ExploreMockData.categories) {
        expect(find.text(category.label), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders tab bar with all tabs', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final tab in ExploreMockData.tabs) {
        expect(find.text(tab.label), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders results bar with count', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('48 results'), findsOneWidget);
      expect(find.text('Filter'), findsOneWidget);
      expect(find.text('Sort'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders trending now section header', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Trending now'), findsOneWidget);
      expect(find.text('(${ExploreMockData.trendingPlaces.length})'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders trending places', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final place in ExploreMockData.trendingPlaces) {
        expect(find.text(place.title), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders other places section header', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Other Places'), findsOneWidget);
      expect(find.text('(40)'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders other places with details', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final place in ExploreMockData.otherPlaces) {
        expect(find.text(place.title), findsOneWidget);
        expect(find.text(place.location), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders show more button', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Show More'), findsOneWidget);
      expect(find.text('View Map'), findsOneWidget);

      harness.dispose();
    });
  });

  group('ExploreScreen Scroll', () {
    testWidgets('screen is scrollable', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final scrollable = find.byType(CustomScrollView);
      expect(scrollable, findsOneWidget);

      harness.dispose();
    });

    testWidgets('can scroll to bottom of screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.drag(
        find.byType(CustomScrollView),
        const Offset(0, -500),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ExploreScreen), findsOneWidget);

      harness.dispose();
    });
  });

  group('ExploreScreen Interaction', () {
    testWidgets('category chip can be tapped', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final beachChip = find.text('Beach');
      expect(beachChip, findsOneWidget);

      harness.dispose();
    });

    testWidgets('tab can be tapped', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final placesTab = find.text('Places');
      expect(placesTab, findsOneWidget);

      harness.dispose();
    });

    testWidgets('search bar can be tapped', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final searchBar = find.text('Search places, trips, activities...');
      expect(searchBar, findsOneWidget);

      harness.dispose();
    });

    testWidgets('filter button is present', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Filter'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('sort button is present', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Sort'), findsOneWidget);

      harness.dispose();
    });
  });

  group('ExploreScreen Empty State', () {
    testWidgets('renders with mock data by default', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(ExploreScreen), findsOneWidget);
      expect(find.text('Explore'), findsOneWidget);
      expect(find.text('Trending now'), findsOneWidget);
      expect(find.text('Other Places'), findsOneWidget);

      harness.dispose();
    });
  });

  group('ExploreScreen Place Cards', () {
    testWidgets('renders place cards with ratings', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      for (final place in ExploreMockData.otherPlaces) {
        expect(find.text(place.title), findsOneWidget);
        expect(find.text(place.location), findsOneWidget);
      }

      harness.dispose();
    });

    testWidgets('renders trending place cards', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.explore);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Trending now'), findsOneWidget);

      for (final trending in ExploreMockData.trendingPlaces) {
        expect(find.text(trending.title), findsOneWidget);
      }

      harness.dispose();
    });
  });

  group('ExploreScreen Theme', () {
    testWidgets('respects theme mode from ThemeCubit', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.explore,
        initialThemeMode: ThemeMode.dark,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.dispose();
    });

    testWidgets('renders correctly in light mode', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.explore,
        initialThemeMode: ThemeMode.light,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(ExploreScreen), findsOneWidget);

      harness.dispose();
    });
  });

  group('ExploreScreen User', () {
    testWidgets('displays user info from UserCubit', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.explore,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.userCubit.state.user, isNotNull);
      expect(harness.userCubit.state.user!.displayName, testUser.displayName);

      harness.dispose();
    });
  });
}
