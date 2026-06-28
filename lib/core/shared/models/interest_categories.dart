class InterestCategories {
  InterestCategories._();
  static final List<String> categories = [
    "🍽️ Restaurants",
    "☕ Cafe",
    "🥐 Bakery",
    "🦞 Seafood",
    "🌮 Street Food",
    "🧳 Tourism",
    "🌊 Waterfront",
    "🌿 Nature",
    "🌃 Nightlife",
    "🎵 Music",
    "🚶 Outdoor",
    "🌳 Park",
    "🛍️ Shopping",
    "🎭 Entertainment",
    "🏖️ Beaches & Water",
    "🎨 Arts & Crafts",
    "🏺 History & Antiquities",
    "🏛️ Mosques & Churches",
  ];
  static String stripEmoji(String interest) {
    return interest.replaceFirst(RegExp(r'^[^a-zA-Z0-9]+'), '').trim();
  }

  static List<String> get apiCategories => categories.map(stripEmoji).toList();

  static String withEmoji(String interest) {
    return categories.firstWhere(
      (category) =>
          stripEmoji(category).toLowerCase() == interest.trim().toLowerCase(),
      orElse: () => interest,
    );
  }
}
