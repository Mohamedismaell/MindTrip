import 'package:flutter/material.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';

class TripColors {
  final Color edge;
  final Color fill;
  const TripColors({required this.edge, required this.fill});
}

class TripColorPalette {
  static const List<TripColors> _palette = [
    TripColors(edge: Color(0xFFFAC9AF), fill: Color(0xFFFCE8D1)),
    TripColors(edge: Color(0xFFD8C6FA), fill: Color(0xFFF0E8FF)),
    TripColors(edge: Color(0xFFB8EDC5), fill: Color(0xFFE5F8EA)),
    TripColors(edge: Color(0xFFC9E2FA), fill: Color(0xFFEAF4FD)),
    TripColors(edge: Color(0xFFF6CCD5), fill: Color(0xFFFCEAF0)),
    TripColors(edge: Color(0xFFF8E0A6), fill: Color(0xFFFCF2D8)),
    TripColors(edge: Color(0xFFC9DFC7), fill: Color(0xFFEEF6EC)),
    TripColors(edge: Color(0xFFC5ECEB), fill: Color(0xFFE8F8F8)),
  ];

  static const TripColors morningColors = TripColors(
    edge: Color(0xFFF59E0B),
    fill: Color(0xFFFEF3C7),
  );

  static const TripColors afternoonColors = TripColors(
    edge: Color(0xFF3B82F6),
    fill: Color(0xFFDBEAFE),
  );

  static const TripColors eveningColors = TripColors(
    edge: Color(0xFF8B5CF6),
    fill: Color(0xFFEDE9FE),
  );

  static TripColors getPeriodColors(PlaceDayPeriod period) {
    switch (period) {
      case PlaceDayPeriod.morning:
        return morningColors;
      case PlaceDayPeriod.afternoon:
        return afternoonColors;
      case PlaceDayPeriod.evening:
        return eveningColors;
    }
  }

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
