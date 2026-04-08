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

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final authCubit = context.read<AuthCubit>();
      authCubit.forgetPassword(email: _emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
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
            validator: AppValidator.password,
          ),
          SizedBox(height: 24.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              final isLoading = state.status == AuthStatus.loading;
              return CustomGradientButton(
                width: double.infinity,
                text: isLoading ? AppStrings.verifying : AppStrings.verify,
                onTap: isLoading ? null : () => _submit(),
              );
            },
          ),
        ],
      ),
    );
  }
}
