import 'package:flutter/material.dart';

class CustomOtlinedButton extends StatelessWidget {
  const CustomOtlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
