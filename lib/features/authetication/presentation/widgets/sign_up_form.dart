import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/utils/validators/auth_validator.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/shared/presentation/widget/app_text_field.dart';
import 'package:mindtrip/core/shared/presentation/widget/custom_gradient_button.dart';
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
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmController;
  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _confirmFocus;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      print('here ========= ${_formKey.currentState!.validate()}');

      final authCubit = context.read<AuthCubit>();
      TextInput.finishAutofillContext();
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
          // autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            children: [
              //  Name Field
              AppTextField(
                focusNode: _nameFocus,
                hint: AppStrings.enterYourName,
                autofillHints: const [AutofillHints.name],
                prefixIcon: SvgPicture.asset(
                  AppAssets.personIcon,
                  width: 20.w,
                  height: 20.h,
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_emailFocus),

                controller: _nameController,
                validator: AppValidator.name,
              ),
              SizedBox(height: 28.h),

              //  Email Field
              AppTextField(
                focusNode: _emailFocus,
                hint: AppStrings.enterYourEmail,
                autofillHints: const [AutofillHints.newPassword],
                prefixIcon: SvgPicture.asset(
                  AppAssets.emailIcon,
                  width: 20.w,
                  height: 20.h,
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_passwordFocus),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: AppValidator.email,
              ),
              SizedBox(height: 28.h),

              //  Password Field
              AppTextField(
                focusNode: _passwordFocus,
                hint: AppStrings.enterYourPassword,
                autofillHints: const [AutofillHints.newPassword],

                prefixIcon: SvgPicture.asset(
                  AppAssets.lockIcon,
                  width: 20.w,
                  height: 20.h,
                ),
                textInputAction: TextInputAction.next,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_confirmFocus),
                controller: _passwordController,
                isPassword: true,
                obscureText: state.obscurePassword,
                onToggleVisibility: cubit.togglePassword,
                validator: AppValidator.password,
              ),
              SizedBox(height: 28.h),

              //  Confirm Password Field
              AppTextField(
                focusNode: _confirmFocus,
                hint: AppStrings.confirmYourPassword,

                // autofillHints: const [AutofillHints.newPassword],
                prefixIcon: SvgPicture.asset(
                  AppAssets.lockIcon,
                  width: 20.w,
                  height: 20.h,
                ),
                textInputAction: TextInputAction.done,
                onEditingComplete: () => _submit(),
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
                text: AppStrings.signUp,
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
