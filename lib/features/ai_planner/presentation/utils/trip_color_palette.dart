import 'package:flutter/material.dart';

class TripColors {
  final Color edge;
  final Color fill;
  const TripColors({required this.edge, required this.fill});
}

class TripColorPalette {
  static const List<TripColors> _palette = [
    // Peach
    TripColors(edge: Color(0xFFFAC9AF), fill: Color(0xFFFCE8D1)),
    // Lavender
    TripColors(edge: Color(0xFFD8C6FA), fill: Color(0xFFF0E8FF)),
    // Mint
    TripColors(edge: Color(0xFFB8EDC5), fill: Color(0xFFE5F8EA)),
    // Sky
    TripColors(edge: Color(0xFFC9E2FA), fill: Color(0xFFEAF4FD)),
    // Rose
    TripColors(edge: Color(0xFFF6CCD5), fill: Color(0xFFFCEAF0)),
    // Butter
    TripColors(edge: Color(0xFFF8E0A6), fill: Color(0xFFFCF2D8)),
    // Sage
    TripColors(edge: Color(0xFFC9DFC7), fill: Color(0xFFEEF6EC)),
    // Aqua
    TripColors(edge: Color(0xFFC5ECEB), fill: Color(0xFFE8F8F8)),
  ];

  static TripColors getColorsForId(String id) {
    int hash = 0;
    for (int i = 0; i < id.length; i++) {
      hash = id.codeUnitAt(i) + ((hash << 5) - hash);
    }
    return _palette[hash.abs() % _palette.length];
  }

  static Color getColorForId(String id) => getColorsForId(id).edge;

  static Color blendColors(List<Color> colors) {
    if (colors.isEmpty) return Colors.transparent;
    if (colors.length == 1) return colors.first;
    Color result = colors.first;
    for (int i = 1; i < colors.length; i++) {
      result = Color.alphaBlend(colors[i].withValues(alpha: 0.5), result);
    }
    return result;
  }
}
