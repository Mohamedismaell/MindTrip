import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenshotUtils {
  static Future<Uint8List?> captureWidget({
    required BuildContext context,
    required Widget widget,
    Duration delay = const Duration(milliseconds: 500),
    double pixelRatio = 5.0,
  }) async {
    final GlobalKey repaintKey = GlobalKey();

    // Wrap the widget in a RepaintBoundary and hide it off-screen
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: -9999, // Render out of view
        top: -9999,
        child: Material(
          color: Colors.transparent,
          child: RepaintBoundary(key: repaintKey, child: widget),
        ),
      ),
    );

    // Insert the overlay
    Overlay.of(context).insert(overlayEntry);

    // Wait for the widget to render (allowing time for images to load if needed)
    await Future.delayed(delay);

    try {
      final boundary =
          repaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return null;

      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      return byteData?.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error capturing widget screenshot: $e');
      return null;
    } finally {
      // Clean up the overlay immediately
      overlayEntry.remove();
    }
  }
}
