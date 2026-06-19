//ToDo Later link it with the real Data and edoit the icon or image Value
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
  //Todo check it
  static String stripEmoji(String interest) {
    // Strips any non-alphanumeric characters from the start of the string (like emojis and spaces)
    return interest.replaceFirst(RegExp(r'^[^a-zA-Z0-9]+'), '').trim();
  }

  static List<String> get apiCategories => categories.map(stripEmoji).toList();
}
