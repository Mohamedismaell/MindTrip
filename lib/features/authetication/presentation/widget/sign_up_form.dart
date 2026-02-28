import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/shared/validators/auth_validator.dart';
import 'package:mindtrip/core/widget/app_text_field.dart';
import 'package:mindtrip/features/authetication/manager/cubit/auth_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
                hint: "Enter your name",
                prefixIcon: Icons.person_outline,
                controller: nameController,
                validator: AppValidator.name,
              ),
              SizedBox(height: 16.h),

              AppTextField(
                hint: "Enter your email",
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 16.h),

              AppTextField(
                hint: "Enter your password",
                prefixIcon: Icons.lock_outline,
                controller: passwordController,
                isPassword: true,
                obscureText: cubit.obscurePassword,
                onToggleVisibility: cubit.togglePassword,
                validator: AppValidator.password,
              ),
              SizedBox(height: 16.h),

              AppTextField(
                hint: "Confirm your password",
                prefixIcon: Icons.lock_outline,
                controller: confirmController,
                isPassword: true,
                obscureText: cubit.obscureConfirm,
                onToggleVisibility: cubit.toggleConfirmPassword,
                validator: (value) => AppValidator.confirmPassword(
                  value,
                  passwordController.text,
                ),
              ),
              SizedBox(height: 24.h),

              ElevatedButton(
                onPressed: state is AuthLoading ? null : _submit,
                child: state is AuthLoading
                    ? const CircularProgressIndicator()
                    : const Text("Sign Up"),
              ),
            ],
          ),
        );
      },
    );
  }
}
