class TripCoverAssets {
  // Add placeholder assets for popular cities. User can update these paths later.
  static const _cityAssets = <String, String>{
    'Cairo': 'assets/images/trips/cairo.png',
    'Dahab': 'assets/images/trips/dahab.png',
    'Luxor': 'assets/images/trips/luxor.png',
    'Aswan': 'assets/images/trips/aswan.png',
    'Siwa': 'assets/images/trips/siwa.png',
  };

  // Fallback for unknown cities
  static const _defaultAsset = 'assets/images/trips/default_trip.png';

  static String getForCity(String city) {
    // Basic match: if the city name contains any of the known keys, return that asset
    final lowercaseCity = city.toLowerCase();
    for (final entry in _cityAssets.entries) {
      if (lowercaseCity.contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }
    return _defaultAsset;
  }
}
