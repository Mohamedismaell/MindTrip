import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      context.read<AuthCubit>().signUp(
        name: _nameController.text.trim(),
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
              //  Name Field
              AppTextField(
                hint: AppStrings.enterYourName,
                prefixIcon: SvgPicture.asset(
                  AppAssets.personIcon,
                  width: 20.w,
                  height: 20.h,
                ),

                controller: _nameController,
                validator: AppValidator.name,
              ),
              SizedBox(height: 28.h),

              //  Email Field
              AppTextField(
                hint: AppStrings.enterYourEmail,
                prefixIcon: SvgPicture.asset(
                  AppAssets.emailIcon,
                  width: 20.w,
                  height: 20.h,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 28.h),

              //  Password Field
              AppTextField(
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
                hint: AppStrings.confirmYourPassword,
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
              SizedBox(height: 20.h),
              //  Remember Me Checkbox
              Row(
                children: [
                  Checkbox(
                    value: state.rememberMe,
                    onChanged: (value) =>
                        cubit.toggleRememberMe(value ?? false),
                  ),
                  Text(
                    AppStrings.rememberMe,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              //  Submit Button
              CustomGradientButton(
                width: double.infinity,
                text: isLoading ? AppStrings.signingUp : AppStrings.signUp,
                onTap: isLoading ? null : () => _submit(),
              ),
            ],
          ),
        );
      },
    );
  }
}
