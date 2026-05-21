import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/routes/app_routes.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      authCubit.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        rememberMe: authCubit.state.rememberMe,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final isLoading = state.status == AuthStatus.loading;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                hint: AppStrings.enterYourEmail,
                prefixIcon: SvgPicture.asset(
                  AppAssets.emailIcon,
                  width: 17.sp,
                  height: 17.sp,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 28.h),

              AppTextField(
                hint: AppStrings.enterYourPassword,
                prefixIcon: SvgPicture.asset(
                  AppAssets.lockIcon,
                  width: 17.w,
                  height: 17.h,
                ),
                controller: _passwordController,
                isPassword: true,
                obscureText: state.obscurePassword,
                onToggleVisibility: cubit.togglePassword,
                validator: AppValidator.password,
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Checkbox(
                    value: state.rememberMe,
                    onChanged: (value) =>
                        cubit.toggleRememberMe(value ?? false),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  Text(
                    AppStrings.rememberMe,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.forgetPassword),
                    child: Text(
                      AppStrings.forgotPassword,
                      style: context.textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              CustomGradientButton(
                width: double.infinity,
                text: isLoading ? AppStrings.signingIn : AppStrings.signIn,
                onTap: isLoading ? null : () => _submit(),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
