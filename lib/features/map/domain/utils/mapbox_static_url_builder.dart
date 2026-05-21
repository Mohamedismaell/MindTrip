class MapboxStaticUrlBuilder {
  static const String _baseUrl = 'https://api.mapbox.com/styles/v1';
  static const String _styleId = 'xmohamedx/cmpc4uw4g00a901s75avq3q3a';

  static String buildStaticMapUrl({
    required List<PlaceMarker> markers,
    int width = 600,
    int height = 400,
  }) {
    const token = String.fromEnvironment("ACCESS_TOKEN");

    if (markers.isEmpty) {
      return '$_baseUrl/$_styleId/static/auto/${width}x$height?access_token=$token';
    }

    // Group markers by color to draw a path for each day
    final paths = <String>[];
    final colorGroups = <String, List<PlaceMarker>>{};
    for (final m in markers) {
      if (!colorGroups.containsKey(m.colorHex)) {
        colorGroups[m.colorHex] = [];
      }
      colorGroups[m.colorHex]!.add(m);
    }

    for (final color in colorGroups.keys) {
      final group = colorGroups[color]!;
      if (group.length > 1) {
        final pathCoords = group.map((m) => '${m.lng},${m.lat}').join('|');
        paths.add('path-3+${color.replaceAll('#', '')}-0.7($pathCoords)');
      }
    }

    final markerStrings = markers
        .map((m) {
          final colorHex = m.colorHex.replaceAll('#', '');
          final label = m.label.isNotEmpty ? '-${m.label.toLowerCase()}' : '';
          return 'pin-s$label+$colorHex(${m.lng},${m.lat})';
        })
        .join(',');

    final allOverlays = [
      if (paths.isNotEmpty) paths.join(','),
      markerStrings,
    ].join(',');

    return '$_baseUrl/$_styleId/static/'
        '$allOverlays/'
        'auto/${width}x$height'
        '?access_token=$token';
  }
}

class PlaceMarker {
  final double lat;
  final double lng;
  final String colorHex;
  final String label;

  PlaceMarker({
    required this.lat,
    required this.lng,
    required this.colorHex,
    this.label = '',
  });
}
