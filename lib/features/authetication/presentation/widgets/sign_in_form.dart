import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

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
      context.read<AuthCubit>().signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
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
                hint: "Enter your email",
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 28.h),

              AppTextField(
                hint: "Enter your password",
                prefixIcon: Icons.lock_outline,
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
                  ),
                  Text(
                    "Remember me",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to Forgot Password screen
                    },
                    child: Text(
                      "Forgot Password?",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorTheme.outline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              CustomGradientButton(
                width: double.infinity,
                text: isLoading ? "Signing In..." : "Sign In",
                onTap: isLoading ? null : () => _submit(),
              ),
            ],
          ),
        );
      },
    );
  }
}
