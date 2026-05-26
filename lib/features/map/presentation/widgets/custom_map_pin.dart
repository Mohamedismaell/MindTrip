import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';

class CustomMapPin {
  static Future<Uint8List> createCustomMarkerImage({
    required Color color,
    required IconData iconData,
    double size = 96.0,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final double balloonW = size;
    final double balloonH = size * 0.85;
    final double totalH = balloonH + size * 0.22;
    final double cornerRadius = size * 0.28;
    final double tailWidth = size * 0.22;
    final double tailHeight = size * 0.22;

    final shadowPath = _buildBalloonPath(
      balloonW,
      balloonH,
      totalH,
      cornerRadius,
      tailWidth,
      tailHeight,
    );
    canvas.drawShadow(
      shadowPath.shift(const Offset(0, 3)),
      Colors.black.withOpacity(0.3),
      6.0,
      true,
    );

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final balloonPath = _buildBalloonPath(
      balloonW,
      balloonH,
      totalH,
      cornerRadius,
      tailWidth,
      tailHeight,
    );
    canvas.drawPath(balloonPath, paint);

    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    textPainter.text = TextSpan(
      text: String.fromCharCode(iconData.codePoint),
      style: TextStyle(
        fontSize: size * 0.48,
        fontFamily: iconData.fontFamily,
        package: iconData.fontPackage,
        color: Colors.white,
      ),
    );

    textPainter.layout();

    final Offset iconOffset = Offset(
      (balloonW - textPainter.width) / 2,
      (balloonH - textPainter.height) / 2,
    );

    textPainter.paint(canvas, iconOffset);

    final ui.Picture picture = pictureRecorder.endRecording();
    final ui.Image image = await picture.toImage(
      balloonW.toInt(),
      totalH.toInt(),
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  static Path _buildBalloonPath(
    double w,
    double bH,
    double totalH,
    double r,
    double tailW,
    double tailH,
  ) {
    final cx = w / 2;
    final path = Path();

    path.moveTo(r, 0);
    path.lineTo(w - r, 0);
    path.arcToPoint(Offset(w, r), radius: Radius.circular(r));
    path.lineTo(w, bH - r);
    path.arcToPoint(Offset(w - r, bH), radius: Radius.circular(r));
    path.lineTo(cx + tailW / 2, bH);
    path.lineTo(cx, totalH);
    path.lineTo(cx - tailW / 2, bH);
    path.lineTo(r, bH);
    path.arcToPoint(Offset(0, bH - r), radius: Radius.circular(r));
    path.lineTo(0, r);
    path.arcToPoint(Offset(r, 0), radius: Radius.circular(r));
    path.close();

    return path;
  }

  // static Future<Uint8List> createSearchPin({double size = 96.0}) =>
  //     createCustomMarkerImage(
  //       color: const Color(0xFFE91E63),
  //       iconData: Icons.search_rounded,
  //       size: size,
  //     );

  // static Future<Uint8List> createTransitPin({double size = 96.0}) =>
  //     createCustomMarkerImage(
  //       color: const Color(0xFFE53935),
  //       iconData: Icons.directions_subway_rounded,
  //       size: size,
  //     );

  // static Future<Uint8List> createCafePin({double size = 96.0}) =>
  //     createCustomMarkerImage(
  //       color: const Color(0xFF8B5CF6),
  //       iconData: Icons.local_cafe_rounded,
  //       size: size,
  //     );

  // static Future<Uint8List> createRestaurantPin({double size = 96.0}) =>
  //     createCustomMarkerImage(
  //       color: const Color(0xFFE91E63),
  //       iconData: Icons.search_rounded,
  //       size: size,
  //     );
}
