import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/enums/otp_flow.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

class SignInStatusListener extends StatelessWidget {
  final Widget child;

  const SignInStatusListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          context.read<AppGateCubit>().loginSuccess();
        } else if (state.status == AuthStatus.failure) {
          _showSnackBar(
            context,
            message: state.errorMessage ?? 'Something went wrong',
            backgroundColor: context.colorTheme.error,
          );
        }
      },
      child: child,
    );
  }
}

class OtpRequestStatusListener extends StatelessWidget {
  final Widget child;

  const OtpRequestStatusListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.otpSent) {
          context.pushReplacement(
            AppRoutes.otpVerification,
            extra: state.otpFlow,
          );
        } else if (state.status == AuthStatus.failure) {
          _showSnackBar(
            context,
            message: state.errorMessage ?? 'Something went wrong',
            backgroundColor: Theme.of(context).colorScheme.error,
          );
        }
      },
      child: child,
    );
  }
}

class OtpVerificationStatusListener extends StatelessWidget {
  final Widget child;

  const OtpVerificationStatusListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.otpVerified) {
          if (state.otpFlow == OtpFlow.forgetPassword) {
            context.push(AppRoutes.resetPassword);
          } else {
            context.pushReplacement(AppRoutes.completeSignUpScreen);
          }
        } else if (state.status == AuthStatus.otpSent) {
          _showSnackBar(
            context,
            message: AppStrings.verificationCodeResent,
            backgroundColor: context.colorTheme.primary,
          );
        } else if (state.status == AuthStatus.failure) {
          _showSnackBar(
            context,
            message: state.errorMessage ?? 'Something went wrong',
            backgroundColor: context.colorTheme.error,
          );
        }
      },
      child: child,
    );
  }
}

class ResetPasswordStatusListener extends StatelessWidget {
  final Widget child;

  const ResetPasswordStatusListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.passwordResetSuccess) {
          context.pushReplacement(AppRoutes.completeResetPasswordScreen);
        } else if (state.status == AuthStatus.failure) {
          _showSnackBar(
            context,
            message: state.errorMessage ?? 'Something went wrong',
            backgroundColor: context.colorTheme.error,
          );
        }
      },
      child: child,
    );
  }
}

void _showSnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
