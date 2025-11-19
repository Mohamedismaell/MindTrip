import 'package:flutter/material.dart';
import 'package:ttproj/core/theme/app_colors.dart';
import 'package:ttproj/core/widget/app_button.dart';
import 'package:ttproj/core/widget/gradient_border_button.dart';
import 'package:ttproj/utility.dart';
import '../../widget/main_image.dart';

class AutheticationScreen extends StatelessWidget {
  const AutheticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 220,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainImage(),
            addVertical(70),
            AppButton(
              width: 361,
              button: TextButton(
                onPressed: () {},
                child: Text('Create account'),
              ),
            ),
            addVertical(33),
            AppGradientBorderButton(
              text: 'Login',
              onPressed: () {},
              gradient: AppColors.blueLightGradient,
              width: 361,
            ),
          ],
        ),
      ),
    );
  }
}
