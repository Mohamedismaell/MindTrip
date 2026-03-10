import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

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
                hint: "Enter your name",
                prefixIcon: Icons.person_outline,
                controller: _nameController,
                validator: AppValidator.name,
              ),
              SizedBox(height: 28.h),

              //  Email Field
              AppTextField(
                hint: "Enter your email",
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 28.h),

              //  Password Field
              AppTextField(
                hint: "Enter your password",
                prefixIcon: Icons.lock_outline,
                controller: _passwordController,
                isPassword: true,
                obscureText: state.obscurePassword,
                onToggleVisibility: cubit.togglePassword,
                validator: AppValidator.password,
              ),
              SizedBox(height: 28.h),

              //  Confirm Password Field
              AppTextField(
                hint: "Confirm your password",
                prefixIcon: Icons.lock_outline,
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
                    "Remember me",
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
                text: isLoading ? "Signing Up..." : "Sign Up",
                onTap: isLoading ? null : () => _submit(),
              ),
            ],
          ),
        );
      },
    );
  }
}
