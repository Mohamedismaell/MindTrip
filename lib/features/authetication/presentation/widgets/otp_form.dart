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
import 'package:mindtrip/features/authetication/presentation/cubit/auth_state.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  String _otp = "";
  bool _isSubmittingOtp = false;
  int _clearOtpTrigger = 0;

  void _submit() {
    if (_isSubmittingOtp) return;

    if (_otp.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter complete code")));
      return;
    }

    _isSubmittingOtp = true;

    final cubit = context.read<AuthCubit>();
    final email = cubit.state.email ?? '';

    if (cubit.state.otpFlow == OtpFlow.signUp ||
        cubit.state.otpFlow == OtpFlow.signInVerify) {
      cubit.verifyEmail(email: email, otp: _otp);
    } else {
      cubit.verifyPasswordOtp(email: email, otp: _otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          setState(() {
            _isSubmittingOtp = false;
            _otp = "";
            _clearOtpTrigger++;
          });
        } else if (state.status != AuthStatus.loading) {
          _isSubmittingOtp = false;
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          final isLoading = state.status == AuthStatus.loading;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: _OtpInput(
                    clearTrigger: _clearOtpTrigger,
                    onChanged: (value) {
                      _otp = value;
                    },
                    onCompleted: (value) {
                      _otp = value;
                      _submit();
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
                  onTap: isLoading ? null : _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OtpInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;
  final int clearTrigger;

  const _OtpInput({
    required this.onCompleted,
    required this.onChanged,
    required this.clearTrigger,
  });

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
              controllers[index - 1].clear();
              focusNodes[index - 1].requestFocus();
              _selectAll(index - 1);
              _emitOtp();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
      ),
    );

    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() {
        if (focusNodes[i].hasFocus && controllers[i].text.isNotEmpty) {
          _selectAll(i);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant _OtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.clearTrigger != widget.clearTrigger) {
      _clearAll();
    }
  }

  void _clearAll() {
    for (final controller in controllers) {
      controller.clear();
    }

    widget.onChanged("");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        focusNodes.first.requestFocus();
      }
    });
  }

  void _selectAll(int index) {
    controllers[index].selection = TextSelection(
      baseOffset: 0,
      extentOffset: controllers[index].text.length,
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
    // Editing an already-filled single box, example "1" -> type "9" => "19"
    if (value.length > 1 && value.length < 6) {
      controllers[index].text = value.characters.last;
      controllers[index].selection = const TextSelection.collapsed(offset: 1);

      _emitOtp();

      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      } else {
        final currentOtp = controllers.map((e) => e.text).join();
        if (currentOtp.length == 6) {
          FocusScope.of(context).unfocus();
          TextInput.finishAutofillContext();
          widget.onCompleted(currentOtp);
        }
      }
      return;
    }

    // Full paste / autofill
    if (value.length >= 6) {
      for (int i = 0; i < 6; i++) {
        controllers[i].text = value[i];
        controllers[i].selection = const TextSelection.collapsed(offset: 1);
      }

      _emitOtp();
      FocusScope.of(context).unfocus();
      TextInput.finishAutofillContext();
      widget.onCompleted(controllers.map((e) => e.text).join());
      return;
    }

    // Delete
    if (value.isEmpty) {
      _emitOtp();

      if (index > 0) {
        focusNodes[index - 1].requestFocus();
        _selectAll(index - 1);
      }
      return;
    }

    // Normal single digit typing
    _emitOtp();

    if (index < 5) {
      focusNodes[index + 1].requestFocus();
    } else {
      final currentOtp = controllers.map((e) => e.text).join();
      if (currentOtp.length == 6) {
        FocusScope.of(context).unfocus();
        TextInput.finishAutofillContext();
        widget.onCompleted(currentOtp);
      }
    }
  }

  void _emitOtp() {
    final otp = controllers.map((e) => e.text).join();
    widget.onChanged(otp);
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 42.w,
            child: TextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              autofillHints: const [AutofillHints.oneTimeCode],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              style: AppTextStyles.h5Medium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Colors.black, width: 1.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Colors.black, width: 1.2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Colors.black, width: 1.2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Colors.black, width: 1.2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: Colors.black, width: 1.2),
                ),
              ),
              onTap: () {
                if (controllers[index].text.isNotEmpty) {
                  _selectAll(index);
                }
              },
              onChanged: (value) => _onChanged(index, value),
            ),
          );
        }),
      ),
    );
  }
}
