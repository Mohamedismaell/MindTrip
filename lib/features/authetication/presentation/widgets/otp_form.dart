import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/enums/otp_flow.dart';
import 'package:mindtrip/core/theme/app_text_styles.dart';
import 'package:mindtrip/core/utils/extension.dart';
import 'package:mindtrip/core/utils/app_strings.dart';
import 'package:mindtrip/core/widget/custom_gradient_button.dart';
import 'package:mindtrip/features/authetication/presentation/cubit/auth_cubit.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  String _otp = "";

  void _submit() {
    if (_otp.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter complete code")));
      return;
    }

    final cubit = context.read<AuthCubit>();
    final email = cubit.state.email ?? '';

    if (cubit.state.otpFlow == OtpFlow.signUp) {
      cubit.verifyEmail(email: email, otp: _otp);
    } else {
      cubit.verifyPasswordOtp(email: email, otp: _otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    final isLoading = state.status == AuthStatus.loading;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 34.w),
            child: _OtpInput(
              onCompleted: (value) {
                _otp = value;
              },
            ),
          ),
          SizedBox(height: 10.h),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                AppStrings.ifYouDontReceiveCode,
                style: AppTextStyles.h8SemiBold.copyWith(
                  color: context.colorTheme.outline,
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: isLoading
                    ? null
                    : () => context.read<AuthCubit>().resendOtp(),
                child: Text(
                  AppStrings.resendCode,
                  style: AppTextStyles.h8SemiBold.copyWith(
                    color: context.colorTheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          CustomGradientButton(
            width: double.infinity,
            text: isLoading ? AppStrings.verifying : AppStrings.verify,
            onTap: isLoading ? null : () => _submit(),
          ),
        ],
      ),
    );
  }
}

class _OtpInput extends StatefulWidget {
  final Function(String) onCompleted;

  const _OtpInput({required this.onCompleted});

  @override
  State<_OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<_OtpInput> {
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  late final List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();

    focusNodes = List.generate(
      6,
      (index) => FocusNode(
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace) {
            if (controllers[index].text.isEmpty && index > 0) {
              controllers[index - 1].text = '';
              focusNodes[index - 1].requestFocus();
              _emitOtp();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    // paste or rapid typing
    if (value.length > 1) {
      int focusIndex = index;
      for (int i = 0; i < value.length && index + i < 6; i++) {
        controllers[index + i].text = value[i];
        focusIndex = index + i;
      }

      if (focusIndex < 5) {
        focusNodes[focusIndex + 1].requestFocus();
      } else {
        focusNodes[5].requestFocus();
        controllers[5].selection = const TextSelection.collapsed(offset: 1);
        FocusScope.of(context).unfocus();
      }
    }
    // normal
    else if (value.length == 1) {
      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    }
    //  delete
    else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }

    _emitOtp();
  }

  void _emitOtp() {
    final otp = controllers.map((e) => e.text).join();

    if (otp.length == 6) {
      widget.onCompleted(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 42.w,
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            // Removed maxLength to allow pasting full code natively
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: AppTextStyles.h5Medium,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              counterText: "",
              //* Default Border
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.black, width: 1.2),
              ),

              //* Enabled
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.black, width: 1.2),
              ),

              //* Focused
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.black, width: 1.2),
              ),

              //* Error
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.black, width: 1.2),
              ),

              //* Focused Error
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: Colors.black, width: 1.2),
              ),
            ),
            onChanged: (value) => _onChanged(index, value),
          ),
        );
      }),
    );
  }
}
