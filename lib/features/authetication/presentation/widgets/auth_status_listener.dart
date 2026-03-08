import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

/// ──────────────────────────────────────────────────────────────────────────────
/// [PRESENTATION LAYER] — Reusable Widget
///
/// [AuthStatusListener] centralises the BlocListener logic shared across
/// [SignInScreen] and [SignUpScreen].
///
/// It listens for [AuthStatus] changes and:
///   • On [AuthStatus.failure]  → shows a [SnackBar] with the error message.
///
/// Navigation on success is handled declaratively by [AppGateCubit] +
/// GoRouter's redirect — no imperative `context.go()` needed here.
/// ──────────────────────────────────────────────────────────────────────────────
class AuthStatusListener extends StatelessWidget {
  /// The child widget tree — typically the screen body.
  final Widget child;

  const AuthStatusListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      child: child,
    );
  }
}
