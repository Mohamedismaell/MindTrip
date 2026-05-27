import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindtrip/core/shared/presentation/manager/connection_cubit/connection_cubit.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';

/// Wraps the app shell and shows auto-dismissing snackbars
/// when connectivity changes (offline → online).
class ConnectionListener extends StatelessWidget {
  final Widget child;

  const ConnectionListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppConnectionCubit, AppConnectionState>(
      listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      listener: (context, state) {
        if (state is Disconnected) {
          AppSnackBar.showError(
            context: context,
            message: 'No internet connection',
          );
        } else if (state is Connected) {
          AppSnackBar.showSuccess(
            context: context,
            message: 'Back online',
          );
        }
      },
      child: child,
    );
  }
}
