import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/core/shared/auth/providers/facebook_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/providers/google_auth_provider.dart';
import 'package:mindtrip/core/shared/auth/secure_token_storage.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/get_current_user.dart';
import 'package:mindtrip/core/shared/user/domain/usecases/update_user_interests_use_case.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/theme/cubit/theme_cubit.dart';
import 'package:mindtrip/core/theme/theme_data_/dark_theme_data.dart';
import 'package:mindtrip/core/theme/theme_data_/light_theme_data.dart';
import 'package:mindtrip/features/authetication/data/datasources/auth_local_data_source.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';
import 'package:mindtrip/features/authetication/domain/entities/verify_password_otp_entity.dart';
import 'package:mindtrip/features/authetication/domain/repositories/auth_repository.dart';
import 'package:mindtrip/features/authetication/domain/usecases/facebook_auth_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/forget_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/googel_auth.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resete_password_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/resend_email_otp_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_in_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/sign_up_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_email_use_case.dart';
import 'package:mindtrip/features/authetication/domain/usecases/verify_password_otp_use_case.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mindtrip/features/onboarding/domain/usecases/complete_onboarding_use_case.dart';
import 'package:mindtrip/features/onboarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:mindtrip/features/home/routes/home_routes.dart';
import 'package:mindtrip/features/explore/routes/explore_routes.dart';
import 'package:mindtrip/features/profile/routes/profile_routes.dart';

const testUser = UserEntity(
  userId: 'test-user-1',
  displayName: 'Test User',
  email: 'test@example.com',
  profilePhotoUrl: 'https://example.com/avatar.png',
  languagePreference: 'English',
  interests: ['Beaches', 'Adventure'],
);

const testUser2 = UserEntity(
  userId: 'test-user-2',
  displayName: 'Mina Adel',
  email: 'mina@example.com',
  profilePhotoUrl: 'https://example.com/mina.png',
  languagePreference: 'Arabic',
  interests: ['History', 'Culture'],
);

class TestHarness {
  TestHarness({
    UserEntity? user,
    String initialLocation = AppRoutes.home,
    ThemeMode initialThemeMode = ThemeMode.system,
    bool isFirstTime = false,
    String? accessToken,
    AuthRepository? authRepository,
    UserRepository? userRepository,
    OnboardingRepository? onboardingRepository,
  })  : themeCubit = ThemeCubit(),
        userCubit = _buildUserCubit(user ?? testUser, userRepository),
        onboardingCubit = OnboardingCubit(
          completeOnboarding: CompleteOnboardingUseCase(
            onboardingRepository ?? FakeOnboardingRepository(isFirstTime: isFirstTime),
          ),
        ),
        authCubit = _buildAuthCubit(authRepository ?? FakeAuthRepository()),
        appGateCubit = _buildAppGateCubit(
          userCubit,
          onboardingRepository ?? FakeOnboardingRepository(isFirstTime: isFirstTime),
          authRepository ?? FakeAuthRepository(),
          accessToken: accessToken,
        ),
        router = _buildRouter(
          initialLocation,
          themeCubit,
          userCubit,
          appGateCubit,
          onboardingCubit,
          authCubit,
        );

  final ThemeCubit themeCubit;
  final UserCubit userCubit;
  final OnboardingCubit onboardingCubit;
  final AuthCubit authCubit;
  final AppGateCubit appGateCubit;
  final GoRouter router;

  static UserCubit _buildUserCubit(UserEntity user, UserRepository? repository) {
    final repo = repository ?? FakeUserRepository(user);
    final cubit = UserCubit(
      getCurrentUser: GetCurrentUser(repository: repo),
      updateUserInterests: UpdateUserInterestsUseCase(repo),
    );
    cubit.setUser(user);
    return cubit;
  }

  static AuthCubit _buildAuthCubit(AuthRepository repository) {
    return AuthCubit(
      signInUseCase: SignInUseCase(repository: repository),
      signUpUseCase: SignUpUseCase(repository: repository),
      googleAuthProvider: FakeGoogleAuthProvider(),
      googleAuthUseCase: GoogleAuthUseCase(
        repository: repository,
        provider: FakeGoogleAuthProvider(),
      ),
      facebookAuthProvider: FakeFacebookAuthProvider(),
      facebookAuthUseCase: FacebookAuthUseCase(
        repository: repository,
        provider: FakeFacebookAuthProvider(),
      ),
      forgetPasswordUseCase: ForgetPasswordUseCase(repository: repository),
      verifyPasswordOtpUseCase: VerifyPsswordOtpUseCase(repository: repository),
      resetPasswordUseCase: ResetePasswordUseCase(repository: repository),
      verifyEmailUseCase: VerifyEmailUseCase(repository: repository),
      resendEmailOtpUseCase: ResendEmailOtpUseCase(repository: repository),
    );
  }

  static AppGateCubit _buildAppGateCubit(
    UserCubit userCubit,
    OnboardingRepository onboardingRepository,
    AuthRepository authRepository, {
    String? accessToken,
  }) {
    final storage = FakeSecureTokenStorage(accessToken: accessToken);
    return AppGateCubit(
      onboardingRepository: onboardingRepository,
      logoutUseCase: LogoutUseCase(repository: authRepository),
      authLocal: AuthLocalDataSource(storage: storage),
      googleAuthProvider: FakeGoogleAuthProvider(),
      facebookAuthProvider: FakeFacebookAuthProvider(),
      userCubit: userCubit,
    );
  }

  static GoRouter _buildRouter(
    String initialLocation,
    ThemeCubit themeCubit,
    UserCubit userCubit,
    AppGateCubit appGateCubit,
    OnboardingCubit onboardingCubit,
    AuthCubit authCubit,
  ) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        ...HomeRoutes.routes,
        ...ExploreRoutes.routes,
        ...ProfileRoutes.routes,
        ShellRoute(
          builder: (context, state, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider<OnboardingCubit>.value(value: onboardingCubit),
              ],
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: AppRoutes.onBoarding,
              builder: (context, state) => const _TestOnboardingScreen(),
            ),
            GoRoute(
              path: AppRoutes.interests,
              builder: (context, state) => const _TestInterestsScreen(),
            ),
            GoRoute(
              path: AppRoutes.welcomeAuth,
              builder: (context, state) => const _TestWelcomeAuthScreen(),
            ),
            GoRoute(
              path: AppRoutes.login,
              builder: (context, state) => const _TestSignInScreen(),
            ),
            GoRoute(
              path: AppRoutes.signup,
              builder: (context, state) => const _TestSignUpScreen(),
            ),
            GoRoute(
              path: AppRoutes.forgetPassword,
              builder: (context, state) => const _TestForgetPasswordScreen(),
            ),
            GoRoute(
              path: AppRoutes.otpVerification,
              builder: (context, state) => const _TestOtpScreen(),
            ),
            GoRoute(
              path: AppRoutes.resetPassword,
              builder: (context, state) => const _TestResetPasswordScreen(),
            ),
            GoRoute(
              path: AppRoutes.completeSignUpScreen,
              builder: (context, state) => const _TestCompleteSignUpScreen(),
            ),
            GoRoute(
              path: AppRoutes.completeResetPasswordScreen,
              builder: (context, state) => const _TestCompleteResetPasswordScreen(),
            ),
          ],
        ),
      ],
    );
  }

  void dispose() {
    themeCubit.close();
    userCubit.close();
    onboardingCubit.close();
    authCubit.close();
    appGateCubit.close();
  }
}

class _TestOnboardingScreen extends StatelessWidget {
  const _TestOnboardingScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('onboarding-screen'),
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Onboarding ${state.currentIndex}'),
              Text('Is Last: ${state.isLastPage}'),
              ElevatedButton(
                key: const Key('onboarding-next-btn'),
                onPressed: () {
                  if (state.isLastPage) {
                    context.go(AppRoutes.interests);
                  } else {
                    context.read<OnboardingCubit>().updateIndex(state.currentIndex + 1);
                  }
                },
                child: const Text('Next'),
              ),
              ElevatedButton(
                key: const Key('onboarding-skip-btn'),
                onPressed: () => context.go(AppRoutes.welcomeAuth),
                child: const Text('Skip'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TestInterestsScreen extends StatelessWidget {
  const _TestInterestsScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('interests-screen'),
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Select Interests'),
              Text('Selected: ${state.selectedCategories?.join(", ") ?? "none"}'),
              ...['Beaches', 'Adventure', 'Culture', 'History', 'Food'].map(
                (cat) => ElevatedButton(
                  key: Key('interest-$cat'),
                  onPressed: () => context.read<OnboardingCubit>().editSelectedCategory(cat),
                  child: Text(cat),
                ),
              ),
              ElevatedButton(
                key: const Key('interests-save-btn'),
                onPressed: state.selectedCategories?.isNotEmpty == true
                    ? () => context.read<OnboardingCubit>().finishOnboarding()
                    : null,
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TestWelcomeAuthScreen extends StatelessWidget {
  const _TestWelcomeAuthScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('welcome-auth-screen'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Welcome'),
          ElevatedButton(
            key: const Key('welcome-signup-btn'),
            onPressed: () => context.push(AppRoutes.signup),
            child: const Text('Sign Up'),
          ),
          ElevatedButton(
            key: const Key('welcome-login-btn'),
            onPressed: () => context.push(AppRoutes.login),
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}

class _TestSignInScreen extends StatelessWidget {
  const _TestSignInScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('signin-screen'),
      body: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sign In'),
                TextField(
                  key: const Key('signin-email-field'),
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (_) {},
                ),
                TextField(
                  key: const Key('signin-password-field'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: state.obscurePassword,
                ),
                Row(
                  children: [
                    Checkbox(
                      key: const Key('signin-remember-me'),
                      value: state.rememberMe,
                      onChanged: (v) => context.read<AuthCubit>().toggleRememberMe(v ?? false),
                    ),
                    const Text('Remember me'),
                  ],
                ),
                if (state.errorMessage != null)
                  Text(
                    key: const Key('signin-error'),
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  key: const Key('signin-submit-btn'),
                  onPressed: state.status == AuthStatus.loading
                      ? null
                      : () => context.read<AuthCubit>().signIn(
                            email: 'test@example.com',
                            password: 'password123',
                            rememberMe: state.rememberMe,
                          ),
                  child: Text(state.status == AuthStatus.loading ? 'Loading...' : 'Sign In'),
                ),
                ElevatedButton(
                  key: const Key('signin-forgot-password-btn'),
                  onPressed: () => context.push(AppRoutes.forgetPassword),
                  child: const Text('Forgot Password'),
                ),
                ElevatedButton(
                  key: const Key('signin-google-btn'),
                  onPressed: () => context.read<AuthCubit>().loginWithGoogle(),
                  child: const Text('Google'),
                ),
                ElevatedButton(
                  key: const Key('signin-signup-link'),
                  onPressed: () => context.pushReplacement(AppRoutes.signup),
                  child: const Text('Create Account'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TestSignUpScreen extends StatelessWidget {
  const _TestSignUpScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('signup-screen'),
      body: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sign Up'),
                TextField(
                  key: const Key('signup-name-field'),
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  key: const Key('signup-email-field'),
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  key: const Key('signup-password-field'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: state.obscurePassword,
                ),
                TextField(
                  key: const Key('signup-confirm-field'),
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: state.obscureConfirm,
                ),
                if (state.errorMessage != null)
                  Text(
                    key: const Key('signup-error'),
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  key: const Key('signup-submit-btn'),
                  onPressed: state.status == AuthStatus.loading
                      ? null
                      : () => context.read<AuthCubit>().signUp(
                            name: 'Test User',
                            email: 'test@example.com',
                            password: 'password123',
                            rememberMe: state.rememberMe,
                          ),
                  child: Text(state.status == AuthStatus.loading ? 'Loading...' : 'Sign Up'),
                ),
                ElevatedButton(
                  key: const Key('signup-login-link'),
                  onPressed: () => context.pushReplacement(AppRoutes.login),
                  child: const Text('Already have account'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TestForgetPasswordScreen extends StatelessWidget {
  const _TestForgetPasswordScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('forget-password-screen'),
      body: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Forget Password'),
                TextField(
                  key: const Key('forget-email-field'),
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                if (state.errorMessage != null)
                  Text(
                    key: const Key('forget-error'),
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  key: const Key('forget-submit-btn'),
                  onPressed: state.status == AuthStatus.loading
                      ? null
                      : () => context.read<AuthCubit>().forgetPassword(email: 'test@example.com'),
                  child: Text(state.status == AuthStatus.loading ? 'Loading...' : 'Send'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TestOtpScreen extends StatelessWidget {
  const _TestOtpScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('otp-screen'),
      body: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('OTP Verification'),
                Text('Email: ${state.email ?? "none"}'),
                Text('OTP Flow: ${state.otpFlow}'),
                TextField(
                  key: const Key('otp-code-field'),
                  decoration: const InputDecoration(labelText: 'OTP Code'),
                ),
                if (state.errorMessage != null)
                  Text(
                    key: const Key('otp-error'),
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  key: const Key('otp-verify-btn'),
                  onPressed: () => context.read<AuthCubit>().verifyPasswordOtp(
                        email: state.email ?? '',
                        otp: '123456',
                      ),
                  child: const Text('Verify'),
                ),
                ElevatedButton(
                  key: const Key('otp-resend-btn'),
                  onPressed: () => context.read<AuthCubit>().resendOtp(),
                  child: const Text('Resend OTP'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TestResetPasswordScreen extends StatelessWidget {
  const _TestResetPasswordScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('reset-password-screen'),
      body: BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Reset Password'),
                TextField(
                  key: const Key('reset-new-password-field'),
                  decoration: const InputDecoration(labelText: 'New Password'),
                  obscureText: state.obscurePassword,
                ),
                TextField(
                  key: const Key('reset-confirm-password-field'),
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: state.obscureConfirm,
                ),
                if (state.errorMessage != null)
                  Text(
                    key: const Key('reset-error'),
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  key: const Key('reset-submit-btn'),
                  onPressed: () => context.read<AuthCubit>().resetPassword(
                        email: state.email ?? '',
                        resetToken: state.resetToken ?? '',
                        newPassword: 'newPassword123',
                        confirmNewPassword: 'newPassword123',
                      ),
                  child: const Text('Reset'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TestCompleteSignUpScreen extends StatelessWidget {
  const _TestCompleteSignUpScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('complete-signup-screen'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign Up Complete'),
          ElevatedButton(
            key: const Key('complete-signup-continue-btn'),
            onPressed: () => context.go(AppRoutes.interests),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}

class _TestCompleteResetPasswordScreen extends StatelessWidget {
  const _TestCompleteResetPasswordScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('complete-reset-password-screen'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Password Reset Complete'),
          ElevatedButton(
            key: const Key('complete-reset-login-btn'),
            onPressed: () => context.go(AppRoutes.login),
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}

Future<void> pumpApp(
  WidgetTester tester, {
  required GoRouter router,
  required ThemeCubit themeCubit,
  required UserCubit userCubit,
  required AppGateCubit appGateCubit,
  OnboardingCubit? onboardingCubit,
  AuthCubit? authCubit,
}) async {
  tester.view.physicalSize = const Size(393, 852);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final providers = [
    BlocProvider<ThemeCubit>.value(value: themeCubit),
    BlocProvider<UserCubit>.value(value: userCubit),
    BlocProvider<AppGateCubit>.value(value: appGateCubit),
  ];

  if (onboardingCubit != null) {
    providers.add(BlocProvider<OnboardingCubit>.value(value: onboardingCubit));
  }

  if (authCubit != null) {
    providers.add(BlocProvider<AuthCubit>.value(value: authCubit));
  }

  await tester.pumpWidget(
    MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        bloc: themeCubit,
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                theme: getLightTheme(),
                darkTheme: getDarkTheme(),
                themeMode: state.themeMode,
                routerConfig: router,
              );
            },
          );
        },
      ),
    ),
  );

  await tester.pumpAndSettle();
}

Future<void> pumpAppWithHarness(WidgetTester tester, TestHarness harness) async {
  await pumpApp(
    tester,
    router: harness.router,
    themeCubit: harness.themeCubit,
    userCubit: harness.userCubit,
    appGateCubit: harness.appGateCubit,
    onboardingCubit: harness.onboardingCubit,
    authCubit: harness.authCubit,
  );
}

class MemoryStorage implements Storage {
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

class FakeOnboardingRepository implements OnboardingRepository {
  FakeOnboardingRepository({this.isFirstTime = false});

  final bool isFirstTime;

  @override
  Future<bool> isFirstTime() async => isFirstTime;

  @override
  Future<void> setNotFirstTime() async {}
}

class FakeSecureTokenStorage extends SecureTokenStorage {
  FakeSecureTokenStorage({this.accessToken});

  final String? accessToken;
  final Map<String, String?> _tokens = <String, String?>{};

  @override
  Future<void> clearTokens() async => _tokens.clear();

  @override
  Future<String?> getAccessToken() async => accessToken ?? _tokens['access_token'];

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

class FakeGoogleAuthProvider extends GoogleAuthProvider {
  @override
  Future<String?> signIn() async => 'fake-google-token';

  @override
  Future<void> signOut() async {}
}

class FakeFacebookAuthProvider extends FacebookAuthProvider {
  @override
  Future<String?> signIn() async => 'fake-facebook-token';

  @override
  Future<void> signOut() async {}
}

class FakeUserRepository implements UserRepository {
  FakeUserRepository(this.user);

  final UserEntity user;

  @override
  Future<Result<UserEntity>> getCurrentUser() async => Result.ok(user);

  @override
  Future<Result<void>> updateInterests(List<String> interests) async => const Result.ok(null);
}

class FakeAuthRepository implements AuthRepository {
  UserEntity? mockUser;
  bool signInShouldFail = false;
  bool signUpShouldFail = false;
  bool forgetPasswordShouldFail = false;
  bool verifyOtpShouldFail = false;
  bool resetPasswordShouldFail = false;

  @override
  Future<Result<UserEntity>> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (signInShouldFail) {
      return Result.fail(_TestFailure('Invalid credentials'));
    }
    mockUser ??= testUser;
    return Result.ok(mockUser!);
  }

  @override
  Future<Result<void>> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (signUpShouldFail) {
      return Result.fail(_TestFailure('Email already exists'));
    }
    return const Result.ok(null);
  }

  @override
  Future<Result<UserEntity>> googleAuth({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (signInShouldFail) {
      return Result.fail(_TestFailure('Google auth failed'));
    }
    return Result.ok(testUser);
  }

  @override
  Future<Result<UserEntity>> facebookAuth({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (signInShouldFail) {
      return Result.fail(_TestFailure('Facebook auth failed'));
    }
    return Result.ok(testUser);
  }

  @override
  Future<Result<void>> forgetPassword({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (forgetPasswordShouldFail) {
      return Result.fail(_TestFailure('Email not found'));
    }
    return const Result.ok(null);
  }

  @override
  Future<Result<VerifyPasswordOtpEntity>> verifyPasswordOtp({
    required String email,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (verifyOtpShouldFail) {
      return Result.fail(_TestFailure('Invalid OTP'));
    }
    return Result.ok(VerifyPasswordOtpEntity(resetToken: 'fake-reset-token'));
  }

  @override
  Future<Result<void>> resetPassword({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (resetPasswordShouldFail) {
      return Result.fail(_TestFailure('Password reset failed'));
    }
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> resendPasswordOtp({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> verifyEmail({
    required String email,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (verifyOtpShouldFail) {
      return Result.fail(_TestFailure('Invalid OTP'));
    }
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> resendEmailOtp({required String email}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> logout() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return const Result.ok(null);
  }

  @override
  Future<Result<UserEntity>> refreshToken() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Result.ok(testUser);
  }
}

class _TestFailure {
  _TestFailure(this.message);
  final String message;
}

extension FailureExtension on Result<dynamic> {
  bool get isFailure {
    return this is _Failure;
  }
}

class _Failure {
  _Failure(this.message);
  final String message;
}
