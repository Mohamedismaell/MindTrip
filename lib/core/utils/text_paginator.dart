import 'package:flutter/material.dart';

/// @deprecated Use [TextPaginationService] from domain/services instead.
/// This file is kept for backward compatibility.
///
/// A utility class for paginating text content based on viewport dimensions.
class TextPaginator {
  final String fullText;
  final double width;
  final double height;
  final TextDirection textDirection;

  TextPaginator({
    required this.fullText,
    required this.width,
    required this.height,
    this.textDirection = TextDirection.ltr,
  });

  List<String> paginate({required TextStyle style}) {
    final List<String> pages = [];
    final textPainter = TextPainter(
      textDirection: textDirection,
      maxLines: null,
    );

    int startIndex = 0;

    final bool isTablet = width > 600;

    int currentChunkSize = isTablet ? 8000 : 3000;

    while (startIndex < fullText.length) {
      bool pageFinished = false;

      while (!pageFinished) {
        int guessLimit = startIndex + currentChunkSize;
        if (guessLimit > fullText.length) guessLimit = fullText.length;

        final String textChunk = fullText.substring(startIndex, guessLimit);

        textPainter.text = TextSpan(text: textChunk, style: style);
        textPainter.layout(maxWidth: width);

        final lines = textPainter.computeLineMetrics();

        if (lines.isEmpty) {
          pageFinished = true;
          startIndex = fullText.length;
          break;
        }

        double usedHeight = 0.0;
        bool didFillScreen = false;
        int lastFittingLineIndex = -1;

        for (int i = 0; i < lines.length; i++) {
          if (usedHeight + lines[i].height > height) {
            didFillScreen = true;
            break;
          }
          usedHeight += lines[i].height;
          lastFittingLineIndex = i;
        }

        if (!didFillScreen && guessLimit < fullText.length) {
          currentChunkSize = (currentChunkSize * 1.5).toInt();
          continue;
        }

        if (lastFittingLineIndex == -1) {
          pages.add(fullText[startIndex]);
          startIndex += 1;
          pageFinished = true;
          continue;
        }

        final line = lines[lastFittingLineIndex];
        final endPosition = textPainter.getPositionForOffset(
          Offset(width, line.baseline),
        );

        int chunkEndIndex = endPosition.offset;
        int globalEndIndex = startIndex + chunkEndIndex;

        if (globalEndIndex < fullText.length) {
          final lastSpace = fullText.lastIndexOf(' ', globalEndIndex);
          if (lastSpace > startIndex) {
            globalEndIndex = lastSpace + 1;
          }
        }

        pages.add(fullText.substring(startIndex, globalEndIndex).trimRight());
        startIndex = globalEndIndex;
        pageFinished = true;
      }
    }

    textPainter.dispose();
    return pages;
  }
}
