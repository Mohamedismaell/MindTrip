import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _password;
  late final FocusNode _confirmPassword;
  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _password = FocusNode();
    _confirmPassword = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      authCubit.resetPassword(
        email: authCubit.state.email!,
        resetToken: authCubit.state.resetToken!,
        newPassword: _passwordController.text.trim(),
        confirmNewPassword: _confirmController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final isLoading = state.status == AuthStatus.loading;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  focusNode: _password,
                  autofillHints: const [AutofillHints.newPassword],
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_confirmPassword),
                  textInputAction: TextInputAction.next,
                  hint: AppStrings.enterYourPassword,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.lockIcon,
                    width: 20.w,
                    height: 20.h,
                  ),
                  controller: _passwordController,
                  isPassword: true,
                  obscureText: state.obscurePassword,
                  onToggleVisibility: cubit.togglePassword,
                  validator: AppValidator.password,
                ),
                SizedBox(height: 28.h),

                //  Confirm Password Field
                AppTextField(
                  autocorrect: false,
                  focusNode: _confirmPassword,
                  autofillHints: const [AutofillHints.newPassword],
                  onEditingComplete: () => _confirmPassword.unfocus(),
                  textInputAction: TextInputAction.done,
                  hint: AppStrings.confirmPassword,
                  prefixIcon: SvgPicture.asset(
                    AppAssets.lockIcon,
                    width: 20.w,
                    height: 20.h,
                  ),
                  controller: _confirmController,
                  isPassword: true,
                  obscureText: state.obscureConfirm,
                  onToggleVisibility: cubit.toggleConfirmPassword,
                  validator: (value) => AppValidator.confirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),
                SizedBox(height: 34.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: CustomGradientButton(
                    width: double.infinity,
                    text: isLoading
                        ? AppStrings.resetting
                        : AppStrings.resetTitle,
                    onTap: isLoading ? null : () => _submit(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
