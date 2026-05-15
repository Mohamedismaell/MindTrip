class TripCoverAssets {
  //Todo Change them later
  static const _cityAssets = <String, String>{
    'Cairo': 'assets/images/onboarding/Pyramids.jpg',
    'Dahab': 'assets/images/onboarding/Pyramids.jpg',
    'Luxor': 'assets/images/onboarding/Pyramids.jpg',
    'Aswan': 'assets/images/onboarding/Pyramids.jpg',
    'Siwa': 'assets/images/onboarding/Pyramids.jpg',
  };

  static const _defaultAsset = 'assets/images/onboarding/Pyramids.jpg';

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
