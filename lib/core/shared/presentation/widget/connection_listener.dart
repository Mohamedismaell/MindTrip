import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/injection/service_locator.dart';
import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_bloc.dart';
import 'package:mindtrip/core/shared/routes/app_router.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';

/// The set of routes where the connection banner should NOT appear.
const _suppressedRoutes = {
  AppRoutes.splash,
  AppRoutes.onBoarding,
  AppRoutes.welcomeAuth,
};

/// Wraps the app shell and shows auto-dismissing snackbars
/// when connectivity changes (offline → online).
/// Banners are suppressed on splash, onboarding, and welcome screens.
class ConnectionListener extends StatelessWidget {
  final Widget child;

  const ConnectionListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppConnectionBloc, AppConnectionState>(
      listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      listener: (context, state) {
        // Suppress on _suppressedRoutes
        final router = sl<AppRouter>().appRouter;
        final location =
            router.routerDelegate.currentConfiguration.last.matchedLocation;

        final isSuppressed = _suppressedRoutes.any(
          (route) => location.startsWith(route),
        );
        if (isSuppressed) return;

        if (state is Disconnected) {
          AppSnackBar.showError(
            context: context,
            message: 'No internet connection',
          );
        } else if (state is Connected) {
          AppSnackBar.showSuccess(context: context, message: 'Back online');
        }
      },
      child: child,
    );
  }
}
