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

class SmoothWavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Adjusted waveHeight slightly for a more pronounced effect like the image
    double waveHeight = 25.0;

    path.lineTo(0, size.height - waveHeight);

    // First curve (dips down)
    path.quadraticBezierTo(
      size.width / 4,
      size.height,
      size.width / 2,
      size.height - waveHeight,
    );

    // Second curve (goes up)
    path.quadraticBezierTo(
      size.width * 3 / 4,
      size.height - (waveHeight * 2),
      size.width,
      size.height - waveHeight,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false; // Set to true if wave needs to animate
}
// class SmoothWavyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     double waveHeight = 15;

//     path.lineTo(0, size.height - waveHeight);

//     // Single smooth wave across the middle
//     path.quadraticBezierTo(
//       size.width / 4,
//       size.height,
//       size.width / 2,
//       size.height - waveHeight,
//     );

//     path.quadraticBezierTo(
//       size.width * 3 / 4,
//       size.height - waveHeight * 2,
//       size.width,
//       size.height - waveHeight,
//     );

//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
