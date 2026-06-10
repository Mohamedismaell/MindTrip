import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScreenshotUtils {
  static Future<Uint8List?> captureWidget({
    required BuildContext context,
    required Widget widget,
    double pixelRatio = 6.0,
  }) async {
    final GlobalKey repaintKey = GlobalKey();

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // Render out of view
        left: -9999,
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
    await WidgetsBinding.instance.endOfFrame;

    try {
      final boundary =
          repaintKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return null;

      print('Boundary size: ${boundary.size.width} x ${boundary.size.height}');
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
