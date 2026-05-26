class TripCoverAssets {
  //Todo Change them later
  static const _cityAssets = <String, String>{
    'Cairo': 'assets/images/onboarding/Pyramids.webp',
    'Dahab': 'assets/images/onboarding/Pyramids.webp',
    'Luxor': 'assets/images/onboarding/Pyramids.webp',
    'Aswan': 'assets/images/onboarding/Pyramids.webp',
    'Siwa': 'assets/images/onboarding/Pyramids.webp',
  };

  static const _defaultAsset = 'assets/images/onboarding/Pyramids.webp';

  static String getForCity(String city) {
    final lowercaseCity = city.toLowerCase();
    for (final entry in _cityAssets.entries) {
      if (lowercaseCity.contains(entry.key.toLowerCase())) {
        return entry.value;
      }
    }
    return _defaultAsset;
  }
}
