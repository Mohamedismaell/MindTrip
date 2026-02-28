import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mindtrip/core/theme/extensions/theme_extension.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

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
  });
  //TODO  Extract the Icons
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      cursorColor: context.colorTheme.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorTheme.outline,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 10.w),
          child: Icon(
            prefixIcon,
            size: 20.sp,
            color: context.colorTheme.outline,
          ),
        ),
        suffixIcon: isPassword
            ? Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: IconButton(
                  onPressed: onToggleVisibility,
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 17.sp,
                    color: context.colorTheme.outline,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
