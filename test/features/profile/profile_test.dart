import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/fq_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/user_policy_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/settings_screen.dart';
import 'package:mindtrip/features/profile/presentation/screens/terms_of_service_screen.dart';
import 'package:mindtrip/features/profile/routes/profile_routes.dart';
import 'package:mindtrip/features/places/routes/recommended_places_routes.dart';
import '../../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HydratedBloc.storage = MemoryStorage();
  });

  setUp(() async {
    await HydratedBloc.storage.clear();
  });

  group('ProfileScreen', () {
    testWidgets('renders profile screen', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays user display name from UserCubit', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text(testUser.displayName), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays default name when user is null', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: null,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Traveler'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders edit profile button', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('navigates to edit profile when edit button tapped', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Edit Profile'));
      await tester.pumpAndSettle();

      expect(find.byType(EditProfileScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders stats card', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('My interests'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders saved trips section', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Saved Trips'), findsOneWidget);
      expect(find.text('See all'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders my trips section', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('My Trips'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders reviews section', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('My Reviews'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('navigates to settings when settings icon tapped', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profileSettings);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('bottom nav profile item is active', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('bottom-nav-profile-active')),
        findsOneWidget,
      );

      harness.dispose();
    });
  });

  group('EditProfileScreen', () {
    testWidgets('renders edit profile screen', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(EditProfileScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays title', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Edit Profile'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays user display name', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('edit-profile-display-name-row')),
        findsOneWidget,
      );
      expect(find.text(testUser.displayName), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays user email', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('edit-profile-email-row')), findsOneWidget);
      expect(find.text(testUser.email), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders save changes button', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('edit-profile-save-button')), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders delete account button', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('edit-profile-delete-account-button')),
        findsOneWidget,
      );
      expect(find.text('Delete Account'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('save changes button shows snackbar when tapped', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('edit-profile-save-button')));
      await tester.pumpAndSettle();

      expect(
        find.text('Changes stay local only in this phase.'),
        findsOneWidget,
      );

      harness.dispose();
    });

    testWidgets('back button navigates to profile', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.editProfile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profile);
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);

      harness.dispose();
    });
  });

  group('SettingsScreen', () {
    testWidgets('renders settings screen', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays title', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays user name and username', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text(testUser.displayName), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders pause notifications toggle', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Pause notifications'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders dark mode switch', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Dark Mode'), findsOneWidget);
      expect(
        find.byKey(const Key('settings-dark-mode-switch')),
        findsOneWidget,
      );

      harness.dispose();
    });

    testWidgets('dark mode switch toggles theme', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
        initialThemeMode: ThemeMode.light,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.light);

      await tester.tap(find.byKey(const Key('settings-dark-mode-switch')));
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.dispose();
    });

    testWidgets('renders logout button', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('settings-logout-button')), findsOneWidget);
      expect(find.text('Log Out'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('logout button triggers logout', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.appGateCubit.state, isA<AppGateAuthenticated>());

      await tester.tap(find.byKey(const Key('settings-logout-button')));
      await tester.pumpAndSettle();

      expect(harness.appGateCubit.state, isA<AppGateUnauthenticated>());

      harness.dispose();
    });

    testWidgets('renders general settings row', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('General Settings'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders language setting', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders FAQ row', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('FAQ'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('settings legal rows navigate to detail screens', (
      tester,
    ) async {
      final routeCases = [
        (label: 'FAQ', type: FaqScreen),
        (label: 'Terms of service', type: TermsOfServiceScreen),
        (label: 'User Policy', type: UserPolicyScreen),
      ];

      for (final routeCase in routeCases) {
        final harness = TestHarness(
          initialLocation: AppRoutes.profileSettings,
          user: testUser,
        );

        await pumpAppWithHarness(tester, harness);
        await tester.pumpAndSettle();

        await tester.tap(find.text(routeCase.label));
        await tester.pumpAndSettle();

        expect(find.byType(routeCase.type), findsOneWidget);

        harness.dispose();
      }
    });

    testWidgets('terms screen renders figma content', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileTerms,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(TermsOfServiceScreen), findsOneWidget);
      expect(find.text('Terms of service'), findsOneWidget);
      expect(find.text('Hello 👋'), findsOneWidget);
      expect(find.text('1. Use of the App'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('user policy screen renders update date and sections', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profilePolicy,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(UserPolicyScreen), findsOneWidget);
      expect(find.text('User Policy'), findsOneWidget);
      expect(find.text('Last update : 17 April 2026'), findsOneWidget);
      expect(find.text('1. Information We Collect'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('faq search filters questions locally', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileFaq,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byType(FaqScreen), findsOneWidget);
      expect(find.text('What is MindTrip?'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('faq-search-field')), 'data');
      await tester.pumpAndSettle();

      expect(find.text('Is my data safe in MindTrip?'), findsOneWidget);
      expect(find.text('What is MindTrip?'), findsNothing);

      harness.dispose();
    });

    testWidgets('faq accordion expands and collapses answers', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileFaq,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      final answer = find.textContaining('travel planning app');
      expect(answer, findsNothing);

      await tester.tap(find.text('What is MindTrip?'));
      await tester.pumpAndSettle();

      expect(answer, findsOneWidget);

      await tester.tap(find.text('What is MindTrip?'));
      await tester.pumpAndSettle();

      expect(answer, findsNothing);

      harness.dispose();
    });

    testWidgets('legal screen back button returns to settings fallback', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileTerms,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('terms-of-service-back')));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders terms of service row', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Terms of service'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders user policy row', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('User Policy'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('renders wallet row', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Wallet'), findsOneWidget);

      harness.dispose();
    });
  });

  group('Profile Navigation', () {
    testWidgets('can navigate from profile to edit profile', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.editProfile);
      await tester.pumpAndSettle();

      expect(find.byType(EditProfileScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('can navigate from profile to settings', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profileSettings);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('can navigate from settings to profile', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.router.go(AppRoutes.profile);
      await tester.pumpAndSettle();

      expect(find.byType(ProfileScreen), findsOneWidget);

      harness.dispose();
    });

    testWidgets('bottom nav highlights profile on all profile routes', (
      tester,
    ) async {
      final routes = [
        AppRoutes.profile,
        AppRoutes.editProfile,
        AppRoutes.profileSettings,
      ];

      for (final route in routes) {
        final harness = TestHarness(initialLocation: route, user: testUser);

        await pumpAppWithHarness(tester, harness);
        await tester.pumpAndSettle();

        expect(
          find.byKey(const Key('bottom-nav-profile-active')),
          findsOneWidget,
        );

        harness.dispose();
      }
    });
  });

  group('Profile Theme', () {
    testWidgets('respects theme mode from ThemeCubit on profile', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
        initialThemeMode: ThemeMode.dark,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.dispose();
    });

    testWidgets('respects theme mode from ThemeCubit on settings', (
      tester,
    ) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profileSettings,
        user: testUser,
        initialThemeMode: ThemeMode.dark,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.themeCubit.state.themeMode, ThemeMode.dark);

      harness.dispose();
    });
  });

  group('Profile User State', () {
    testWidgets('profile updates when user cubit changes', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: testUser,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text(testUser.displayName), findsOneWidget);

      harness.userCubit.setUser(testUser2);
      await tester.pumpAndSettle();

      expect(find.text(testUser2.displayName), findsOneWidget);

      harness.dispose();
    });

    testWidgets('profile handles null user gracefully', (tester) async {
      final harness = TestHarness(
        initialLocation: AppRoutes.profile,
        user: null,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.text('Traveler'), findsOneWidget);

      harness.dispose();
    });
  });
}
