import 'package:flutter/material.dart';

class MainImage extends StatelessWidget {
  const MainImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/authentication/left_vec.png',
          width: 74.3,
          height: 252.82,
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/authentication/center_vec.png',
          width: 160.09,
          height: 196.88,
          fit: BoxFit.cover,
        ),
        Image.asset(
          'assets/images/authentication/right_vec.png',
          width: 74.3,
          height: 252.82,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
