import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/shared/presentation/manager/app_gate_cubit/app_gate_cubit.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/user/manager/cubit/user_cubit.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/widget/app_snackbar.dart';
import 'package:mindtrip/features/interests/presentation/widgets/interests_buttons.dart';
import 'package:mindtrip/features/interests/presentation/widgets/interests_header.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key, required this.isEdit});
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listenWhen: (prev, curr) => prev.interestStatus != curr.interestStatus,
      listener: (context, state) {
        if (isEdit && state.interestStatus == InterestStatus.saved) {
          context.read<AppGateCubit>().interestsComplete();
          AppSnackBar.showSuccess(
            context,
            message: 'Interests updated successfully',
          );
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.profile);
          }
        } else if (state.interestStatus == InterestStatus.failed) {
          AppSnackBar.showError(
            context,
            message: 'Failed to save interests. Please try again.',
          );
          context.read<UserCubit>().dismissInterestError();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.5.w, vertical: 46.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const InterestsHeader(),
                const Expanded(child: InterestsButtons()),
                SizedBox(height: 34.h),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    final isLoading =
                        state.interestStatus == InterestStatus.saving;
                    return Center(
                      child: CustomGradientButton(
                        text: isEdit ? AppStrings.save : 'Get Start',
                        isLoading: isLoading,
                        onTap: (isLoading || !state.hasChanges)
                            ? null
                            : () async {
                                await context
                                    .read<UserCubit>()
                                    .updateUserInterests();
                              },
                      ),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
