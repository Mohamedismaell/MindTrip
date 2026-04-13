import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/enums/otp_flow.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/domain/usecases/facebook_auth_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/forget_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/googel_auth.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resete_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resend_email_otp_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_email_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_password_otp_use_case.dart';
import '../../shared/test_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthCubit', () {
    late AuthCubit cubit;
    late FakeAuthRepository repository;

    setUp(() {
      repository = FakeAuthRepository();
      cubit = TestHarness._buildAuthCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state has correct default values', () {
      expect(cubit.state.status, AuthStatus.initial);
      expect(cubit.state.user, isNull);
      expect(cubit.state.errorMessage, isNull);
      expect(cubit.state.obscurePassword, true);
      expect(cubit.state.obscureConfirm, true);
      expect(cubit.state.rememberMe, false);
      expect(cubit.state.otpFlow, OtpFlow.forgetPassword);
    });

    group('togglePassword', () {
      test('toggles obscurePassword from true to false', () {
        expect(cubit.state.obscurePassword, true);
        cubit.togglePassword();
        expect(cubit.state.obscurePassword, false);
      });

      test('toggles obscurePassword from false to true', () {
        cubit.togglePassword();
        expect(cubit.state.obscurePassword, false);
        cubit.togglePassword();
        expect(cubit.state.obscurePassword, true);
      });
    });

    group('toggleConfirmPassword', () {
      test('toggles obscureConfirm from true to false', () {
        expect(cubit.state.obscureConfirm, true);
        cubit.toggleConfirmPassword();
        expect(cubit.state.obscureConfirm, false);
      });
    });

    group('toggleRememberMe', () {
      test('sets rememberMe to true', () {
        expect(cubit.state.rememberMe, false);
        cubit.toggleRememberMe(true);
        expect(cubit.state.rememberMe, true);
      });

      test('sets rememberMe to false', () {
        cubit.toggleRememberMe(true);
        expect(cubit.state.rememberMe, true);
        cubit.toggleRememberMe(false);
        expect(cubit.state.rememberMe, false);
      });
    });

    group('signIn', () {
      test('emits loading then success on valid credentials', () async {
        final future = cubit.signIn(
          email: 'test@example.com',
          password: 'password123',
          rememberMe: false,
        );

        expect(cubit.state.status, AuthStatus.loading);

        await future;

        expect(cubit.state.status, AuthStatus.success);
        expect(cubit.state.user, isNotNull);
        expect(cubit.state.user!.email, 'test@example.com');
        expect(cubit.state.errorMessage, isNull);
      });

      test('emits loading then failure on invalid credentials', () async {
        repository.signInShouldFail = true;

        await cubit.signIn(
          email: 'invalid@example.com',
          password: 'wrongpassword',
          rememberMe: false,
        );

        expect(cubit.state.status, AuthStatus.failure);
        expect(cubit.state.errorMessage, 'Invalid credentials');
      });

      test('clears error message on new signIn attempt', () async {
        repository.signInShouldFail = true;
        await cubit.signIn(
          email: 'invalid@example.com',
          password: 'wrongpassword',
          rememberMe: false,
        );
        expect(cubit.state.errorMessage, 'Invalid credentials');

        repository.signInShouldFail = false;
        await cubit.signIn(
          email: 'test@example.com',
          password: 'password123',
          rememberMe: false,
        );
        expect(cubit.state.errorMessage, isNull);
      });
    });

    group('signUp', () {
      test('emits loading then otpSent on successful signup', () async {
        await cubit.signUp(
          name: 'New User',
          email: 'newuser@example.com',
          password: 'password123',
          rememberMe: false,
        );

        expect(cubit.state.status, AuthStatus.otpSent);
        expect(cubit.state.otpFlow, OtpFlow.signUp);
        expect(cubit.state.email, 'newuser@example.com');
      });

      test('emits failure when signup fails', () async {
        repository.signUpShouldFail = true;

        await cubit.signUp(
          name: 'New User',
          email: 'existing@example.com',
          password: 'password123',
          rememberMe: false,
        );

        expect(cubit.state.status, AuthStatus.failure);
        expect(cubit.state.errorMessage, 'Email already exists');
      });
    });

    group('loginWithGoogle', () {
      test('emits loading then success on valid google auth', () async {
        await cubit.loginWithGoogle();

        expect(cubit.state.status, AuthStatus.success);
        expect(cubit.state.user, isNotNull);
      });

      test('emits failure when google auth fails', () async {
        repository.signInShouldFail = true;

        await cubit.loginWithGoogle();

        expect(cubit.state.status, AuthStatus.failure);
      });
    });

    group('loginWithFacebook', () {
      test('emits loading then success on valid facebook auth', () async {
        await cubit.loginWithFacebook();

        expect(cubit.state.status, AuthStatus.success);
        expect(cubit.state.user, isNotNull);
      });

      test('emits failure when facebook auth fails', () async {
        repository.signInShouldFail = true;

        await cubit.loginWithFacebook();

        expect(cubit.state.status, AuthStatus.failure);
      });
    });

    group('forgetPassword', () {
      test('emits loading then otpSent on valid email', () async {
        await cubit.forgetPassword(email: 'test@example.com');

        expect(cubit.state.status, AuthStatus.otpSent);
        expect(cubit.state.otpFlow, OtpFlow.forgetPassword);
        expect(cubit.state.email, 'test@example.com');
      });

      test('emits failure when email not found', () async {
        repository.forgetPasswordShouldFail = true;

        await cubit.forgetPassword(email: 'nonexistent@example.com');

        expect(cubit.state.status, AuthStatus.failure);
        expect(cubit.state.errorMessage, 'Email not found');
      });
    });

    group('verifyPasswordOtp', () {
      test('emits loading then otpVerified on valid otp', () async {
        await cubit.verifyPasswordOtp(
          email: 'test@example.com',
          otp: '123456',
        );

        expect(cubit.state.status, AuthStatus.otpVerified);
        expect(cubit.state.resetToken, 'fake-reset-token');
      });

      test('emits failure on invalid otp', () async {
        repository.verifyOtpShouldFail = true;

        await cubit.verifyPasswordOtp(
          email: 'test@example.com',
          otp: '000000',
        );

        expect(cubit.state.status, AuthStatus.failure);
        expect(cubit.state.errorMessage, 'Invalid OTP');
      });
    });

    group('resetPassword', () {
      test('emits loading then passwordResetSuccess on valid reset', () async {
        cubit.emit(cubit.state.copyWith(resetToken: 'fake-reset-token'));

        await cubit.resetPassword(
          email: 'test@example.com',
          resetToken: 'fake-reset-token',
          newPassword: 'newPassword123',
          confirmNewPassword: 'newPassword123',
        );

        expect(cubit.state.status, AuthStatus.passwordResetSuccess);
      });

      test('emits failure on reset error', () async {
        repository.resetPasswordShouldFail = true;

        await cubit.resetPassword(
          email: 'test@example.com',
          resetToken: 'invalid-token',
          newPassword: 'newPassword123',
          confirmNewPassword: 'newPassword123',
        );

        expect(cubit.state.status, AuthStatus.failure);
      });
    });

    group('verifyEmail', () {
      test('emits loading then otpVerified on valid email otp', () async {
        await cubit.verifyEmail(
          email: 'test@example.com',
          otp: '123456',
        );

        expect(cubit.state.status, AuthStatus.otpVerified);
      });

      test('emits failure on invalid email otp', () async {
        repository.verifyOtpShouldFail = true;

        await cubit.verifyEmail(
          email: 'test@example.com',
          otp: '000000',
        );

        expect(cubit.state.status, AuthStatus.failure);
      });
    });

    group('resendOtp', () {
      test('emits otpSent when resend succeeds', () async {
        cubit.emit(cubit.state.copyWith(email: 'test@example.com'));

        await cubit.resendOtp();

        expect(cubit.state.status, AuthStatus.otpSent);
      });

      test('does nothing when email is null', () async {
        final initialState = cubit.state;
        await cubit.resendOtp();
        expect(cubit.state, initialState);
      });
    });
  });

  group('Sign In Screen', () {
    testWidgets('renders sign in screen with all elements', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-screen')), findsOneWidget);
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.byKey(const Key('signin-email-field')), findsOneWidget);
      expect(find.byKey(const Key('signin-password-field')), findsOneWidget);
      expect(find.byKey(const Key('signin-remember-me')), findsOneWidget);
      expect(find.byKey(const Key('signin-submit-btn')), findsOneWidget);
      expect(find.byKey(const Key('signin-forgot-password-btn')), findsOneWidget);
      expect(find.byKey(const Key('signin-google-btn')), findsOneWidget);
      expect(find.byKey(const Key('signin-signup-link')), findsOneWidget);
    });

    testWidgets('toggling remember me checkbox updates cubit state', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.rememberMe, false);

      await tester.tap(find.byKey(const Key('signin-remember-me')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.rememberMe, true);

      harness.dispose();
    });

    testWidgets('tapping submit initiates sign in', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-submit-btn')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.status, AuthStatus.success);

      harness.dispose();
    });

    testWidgets('tapping forgot password navigates to forgot password screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-forgot-password-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('forget-password-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('tapping signup link navigates to signup screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-signup-link')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signup-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('displays error message on sign in failure', (tester) async {
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
      expect(find.text('Invalid credentials'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('shows loading state during sign in', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-submit-btn')));

      expect(find.text('Loading...'), findsOneWidget);

      await tester.pumpAndSettle();

      harness.dispose();
    });
  });

  group('Sign Up Screen', () {
    testWidgets('renders signup screen with all elements', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.signup);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signup-screen')), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.byKey(const Key('signup-name-field')), findsOneWidget);
      expect(find.byKey(const Key('signup-email-field')), findsOneWidget);
      expect(find.byKey(const Key('signup-password-field')), findsOneWidget);
      expect(find.byKey(const Key('signup-confirm-field')), findsOneWidget);
      expect(find.byKey(const Key('signup-submit-btn')), findsOneWidget);
      expect(find.byKey(const Key('signup-login-link')), findsOneWidget);
    });

    testWidgets('tapping submit initiates sign up', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.signup);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signup-submit-btn')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.status, AuthStatus.otpSent);
      expect(harness.authCubit.state.otpFlow, OtpFlow.signUp);

      harness.dispose();
    });

    testWidgets('tapping login link navigates to login screen', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.signup);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signup-login-link')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-screen')), findsOneWidget);

      harness.dispose();
    });
  });

  group('Forget Password Screen', () {
    testWidgets('renders forget password screen with all elements', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.forgetPassword);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('forget-password-screen')), findsOneWidget);
      expect(find.text('Forget Password'), findsOneWidget);
      expect(find.byKey(const Key('forget-email-field')), findsOneWidget);
      expect(find.byKey(const Key('forget-submit-btn')), findsOneWidget);
    });

    testWidgets('tapping submit sends forget password request', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.forgetPassword);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('forget-submit-btn')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.status, AuthStatus.otpSent);
      expect(harness.authCubit.state.otpFlow, OtpFlow.forgetPassword);

      harness.dispose();
    });

    testWidgets('displays error on forget password failure', (tester) async {
      final repository = FakeAuthRepository()..forgetPasswordShouldFail = true;
      final harness = TestHarness(
        initialLocation: AppRoutes.forgetPassword,
        authRepository: repository,
      );

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('forget-submit-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('forget-error')), findsOneWidget);

      harness.dispose();
    });
  });

  group('OTP Screen', () {
    testWidgets('renders otp screen with all elements', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.otpVerification);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('otp-screen')), findsOneWidget);
      expect(find.text('OTP Verification'), findsOneWidget);
      expect(find.byKey(const Key('otp-code-field')), findsOneWidget);
      expect(find.byKey(const Key('otp-verify-btn')), findsOneWidget);
      expect(find.byKey(const Key('otp-resend-btn')), findsOneWidget);
    });

    testWidgets('displays email when set in state', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.otpVerification);
      harness.authCubit.emit(harness.authCubit.state.copyWith(email: 'test@example.com'));

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.textContaining('test@example.com'), findsOneWidget);

      harness.dispose();
    });

    testWidgets('verify button calls verifyPasswordOtp', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.otpVerification);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.authCubit.emit(harness.authCubit.state.copyWith(email: 'test@example.com'));

      await tester.tap(find.byKey(const Key('otp-verify-btn')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.status, AuthStatus.otpVerified);

      harness.dispose();
    });

    testWidgets('resend button calls resendOtp', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.otpVerification);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.authCubit.emit(harness.authCubit.state.copyWith(email: 'test@example.com'));

      await tester.tap(find.byKey(const Key('otp-resend-btn')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.status, AuthStatus.otpSent);

      harness.dispose();
    });
  });

  group('Reset Password Screen', () {
    testWidgets('renders reset password screen with all elements', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.resetPassword);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('reset-password-screen')), findsOneWidget);
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.byKey(const Key('reset-new-password-field')), findsOneWidget);
      expect(find.byKey(const Key('reset-confirm-password-field')), findsOneWidget);
      expect(find.byKey(const Key('reset-submit-btn')), findsOneWidget);
    });

    testWidgets('submit button calls resetPassword', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.resetPassword);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      harness.authCubit.emit(harness.authCubit.state.copyWith(
        email: 'test@example.com',
        resetToken: 'test-token',
      ));

      await tester.tap(find.byKey(const Key('reset-submit-btn')));
      await tester.pumpAndSettle();

      expect(harness.authCubit.state.status, AuthStatus.passwordResetSuccess);

      harness.dispose();
    });
  });

  group('Complete Screens', () {
    testWidgets('complete signup screen renders and navigates', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.completeSignUpScreen);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('complete-signup-screen')), findsOneWidget);
      expect(find.text('Sign Up Complete'), findsOneWidget);
      expect(find.byKey(const Key('complete-signup-continue-btn')), findsOneWidget);

      await tester.tap(find.byKey(const Key('complete-signup-continue-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('interests-screen')), findsOneWidget);

      harness.dispose();
    });

    testWidgets('complete reset password screen renders and navigates', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.completeResetPasswordScreen);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('complete-reset-password-screen')), findsOneWidget);
      expect(find.text('Password Reset Complete'), findsOneWidget);
      expect(find.byKey(const Key('complete-reset-login-btn')), findsOneWidget);

      await tester.tap(find.byKey(const Key('complete-reset-login-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-screen')), findsOneWidget);

      harness.dispose();
    });
  });

  group('Auth Flow Integration', () {
    testWidgets('complete sign up flow: signup -> otp -> complete', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.signup);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signup-submit-btn')));
      await tester.pumpAndSettle();

      harness.dispose();
    });

    testWidgets('complete password reset flow: forget -> otp -> reset -> complete', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.forgetPassword);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('forget-submit-btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('otp-screen')), findsOneWidget);

      harness.dispose();
    });
  });

  group('Edge Cases', () {
    testWidgets('sign in button disabled during loading', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-submit-btn')));

      final button = tester.widget<ElevatedButton>(
        find.byKey(const Key('signin-submit-btn')),
      );
      expect(button.onPressed, isNull);

      await tester.pumpAndSettle();

      harness.dispose();
    });

    testWidgets('multiple rapid taps do not trigger multiple sign ins', (tester) async {
      final harness = TestHarness(initialLocation: AppRoutes.login);

      await pumpAppWithHarness(tester, harness);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signin-submit-btn')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('signin-submit-btn')));
      await tester.pump();

      expect(harness.authCubit.state.status, AuthStatus.loading);

      await tester.pumpAndSettle();

      harness.dispose();
    });

    testWidgets('error message clears when navigating away', (tester) async {
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

      await tester.tap(find.byKey(const Key('signin-signup-link')));
      await tester.pumpAndSettle();

      repository.signInShouldFail = false;
      harness.router.go(AppRoutes.login);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('signin-error')), findsNothing);

      harness.dispose();
    });
  });
}
