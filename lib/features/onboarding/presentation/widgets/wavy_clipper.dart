import 'package:flutter/material.dart';

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double waveHeight = 30;

    path.lineTo(0, size.height - waveHeight);

    // Wave 1
    path.quadraticBezierTo(
      size.width * (1 / 6),
      size.height,
      size.width * (2 / 6),
      size.height - waveHeight,
    );

    // Wave 2
    path.quadraticBezierTo(
      size.width * (3 / 6),
      size.height - waveHeight * 2,
      size.width * (4 / 6),
      size.height - waveHeight,
    );

    // Wave 3
    path.quadraticBezierTo(
      size.width * (5 / 6),
      size.height,
      size.width,
      size.height - waveHeight,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
