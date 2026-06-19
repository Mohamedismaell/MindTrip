import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/utils/extension.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final Widget prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;
  final bool? autocorrect;

  const AppTextField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.textInputAction,
    this.onEditingComplete,
    this.focusNode,
    this.autofillHints,
    this.autocorrect,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _hasTyped = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      enableIMEPersonalizedLearning: false,
      autocorrect: widget.autocorrect ?? false,
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: widget.obscureText,
      autofillHints: widget.autofillHints,
      keyboardType: widget.keyboardType,
      cursorColor: context.colorTheme.primary,
      textInputAction: widget.textInputAction,
      onEditingComplete: widget.onEditingComplete,
      autovalidateMode: _hasTyped
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      validator: widget.validator,
      onChanged: (value) {
        if (!_hasTyped && value.isNotEmpty) {
          setState(() {
            _hasTyped = true;
          });
        }
      },
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorTheme.outline,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 10.w),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: IconButton(
                  onPressed: widget.onToggleVisibility,
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 24.sp,
                    color: context.colorTheme.outline,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
