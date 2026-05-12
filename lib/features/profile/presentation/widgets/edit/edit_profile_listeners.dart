import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_cubit.dart';
import 'package:mindtrip/features/profile/presentation/manager/edit_profile_state.dart';

class EditProfileListeners extends StatelessWidget {
  const EditProfileListeners({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EditProfileCubit, EditProfileState>(
          listenWhen: (prev, curr) => prev.saveStatus != curr.saveStatus,
          listener: (context, state) {
            if (state.saveStatus == EditSaveStatus.success) {
              AppSnackBar.showSuccess(context, message: 'Profile updated!');
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(AppRoutes.profile);
              }
            } else if (state.saveStatus == EditSaveStatus.failed) {
              AppSnackBar.showError(
                context,
                message: 'Failed to save changes. Please try again.',
              );
              context.read<EditProfileCubit>().dismissError();
            }
          },
        ),

        BlocListener<EditProfileCubit, EditProfileState>(
          listenWhen: (prev, curr) => prev.deleteStatus != curr.deleteStatus,
          listener: (context, state) {
            if (state.deleteStatus == DeleteAccountStatus.deleted &&
                context.mounted) {
              context.read<AppGateCubit>().accountDeleted();
            } else if (state.deleteStatus == DeleteAccountStatus.failed &&
                context.mounted) {
              AppSnackBar.showError(
                context,
                message: 'Failed to delete account, please try again.',
              );
              context.read<EditProfileCubit>().dismissError();
            }
          },
        ),
      ],
      child: child,
    );
  }
}
// AppDialog.show(
//   context: context,
//   title: "Error",
//   description: "Failed to delete account. Please try again.",
//   primaryText: "Cancel",
//   onPrimary: () {
//     context.pop();
//   },
//   secondaryText: "Delete",
//   onSecondary: () async {
//     context.pop();
//     await context.read<EditProfileCubit>().deleteAccount();
//   },
// );