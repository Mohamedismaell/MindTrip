import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Composites a category PNG with a white numbered badge overlay.
/// Returns Uint8List (raw PNG) suitable for PointAnnotationOptions.image.
Future<Uint8List> buildMarkerImage({
  required String assetPath,
  required int sequenceNumber,
}) async {
  // 1. Load asset PNG -> ui.Image
  final ByteData data = await rootBundle.load(assetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(data.buffer.asUint8List(), (ui.Image img) {
    return completer.complete(img);
  });
  final ui.Image image = await completer.future;

  // 2. Create ui.PictureRecorder canvas at 56x64 px
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  const double width = 56.0;
  const double height = 64.0;
  final Rect canvasRect = Rect.fromLTWH(0, 0, width, height);

  // 3. Draw category icon (48x48) centered horizontally
  // Image rect is usually centered horizontally, placed at the top or bottom.
  // We'll put it at the bottom leaving space for the badge at top right.
  final Rect imageRect = Rect.fromLTWH(4.0, 16.0, 48.0, 48.0);
  
  // We use paintSource and paintDest to scale the image
  final Rect srcRect = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
  canvas.drawImageRect(image, srcRect, imageRect, Paint());

  // If the image is a 1x1 placeholder, let's draw a fallback circle so we can see the marker!
  if (image.width <= 1 && image.height <= 1) {
    final Paint fallbackPaint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(28.0, 40.0), 20.0, fallbackPaint);
  }

  // 4. Draw circle badge (20x20, white fill + brand colour stroke) at top-right
  final double badgeRadius = 10.0;
  final Offset badgeCenter = Offset(width - badgeRadius - 2.0, badgeRadius + 2.0);

  final Paint badgeFillPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.fill;
  final Paint badgeStrokePaint = Paint()
    ..color = const Color(0xFF4264FB) // Brand color (Mapbox blue)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  canvas.drawCircle(badgeCenter, badgeRadius, badgeFillPaint);
  canvas.drawCircle(badgeCenter, badgeRadius, badgeStrokePaint);

  // 5. Draw sequence number text inside badge
  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  textPainter.text = TextSpan(
    text: sequenceNumber.toString(),
    style: const TextStyle(
      fontSize: 12.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );

  textPainter.layout();
  final Offset textOffset = Offset(
    badgeCenter.dx - (textPainter.width / 2),
    badgeCenter.dy - (textPainter.height / 2),
  );
  textPainter.paint(canvas, textOffset);

  // 6. Export as PNG Uint8List
  final ui.Picture picture = pictureRecorder.endRecording();
  final ui.Image finalImage = await picture.toImage(width.toInt(), height.toInt());
  final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
