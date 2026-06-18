//ToDo Later link it with the real Data and edoit the icon or image Value
class InterestCategories {
  InterestCategories._();
  static final List<String> categories = [
    "🍽️ Restaurants",
    "☕ Cafe",
    "🥐 Bakery",
    "🦞 Seafood",
    "🌮 Street Food",
    "🏺 History & Antiquities",
    "🏛️ Mosques & Churches",
    "🧳 Tourism",
    "🏖️ Beaches & Water",
    "🌊 Waterfront",
    "🌿 Nature",
    "🎭 Entertainment",
    "🌃 Nightlife",
    "🎵 Music",
    "🚶 Outdoor",
    "🌳 Park",
    "🛍️ Shopping",
    "🎨 Arts & Crafts",
  ];
  //Todo check it
  static String stripEmoji(String interest) {
    return interest
        .replaceAll(
          RegExp(
            r'[\p{Emoji_Presentation}\p{Emoji}\uFE0F\u200D]+',
            unicode: true,
          ),
          '',
        )
        .trim();
  }

  static List<String> get apiCategories => categories.map(stripEmoji).toList();
}
