import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/authetication/manager/cubit/auth_cubit.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();

    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();

        return Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                hint: "Enter your email",
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 28.h),

              AppTextField(
                hint: "Enter your password",
                prefixIcon: Icons.lock_outline,
                controller: passwordController,
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
                    onChanged: (value) {
                      print(value);
                      context.read<AuthCubit>().toggleRememberMe(
                        value ?? false,
                      );
                    },
                  ),
                  Text(
                    "Remember me",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Forgot Password?",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorTheme.outline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CustomGradientButton(
                width: double.infinity,
                text: "Sign In",
                onTap: () {
                  _submit();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
