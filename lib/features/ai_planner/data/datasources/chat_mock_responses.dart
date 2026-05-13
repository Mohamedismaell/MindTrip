/// Static mock response data for the AI chatbot.
///
/// Organized by travel topic categories with keyword matching.
class ChatMockResponses {
  ChatMockResponses._();

  /// Default suggestion chips shown with greeting.
  static const List<String> defaultSuggestions = [
    '🗺️ Plan a trip',
    '🏨 Find hotels',
    '🍽️ Food recommendations',
    '🎯 Things to do',
  ];

  /// Retry suggestions shown when plan generation fails.
  static const List<String> retrySuggestions = [
    '🔄 Try again',
    '✏️ Modify my plan',
    '💬 Talk to support',
  ];

  /// Keyword → category mapping for response matching.
  static const Map<String, List<String>> keywordMap = {
    'destination': [
      'destination',
      'where',
      'place',
      'visit',
      'go',
      'trip',
      'plan',
    ],
    'hotel': ['hotel', 'stay', 'accommodation', 'resort', 'hostel', 'room'],
    'food': [
      'food',
      'eat',
      'restaurant',
      'cuisine',
      'meal',
      'dinner',
      'lunch',
      'breakfast',
    ],
    'activity': [
      'do',
      'activity',
      'activities',
      'things',
      'attraction',
      'explore',
      'see',
      'tour',
    ],
    'budget': [
      'budget',
      'cost',
      'price',
      'cheap',
      'expensive',
      'money',
      'afford',
    ],
    'transport': [
      'transport',
      'travel',
      'bus',
      'taxi',
      'uber',
      'flight',
      'train',
      'car',
    ],
    'weather': [
      'weather',
      'climate',
      'temperature',
      'hot',
      'cold',
      'rain',
      'sun',
    ],
  };

  /// Responses grouped by category.
  static const Map<String, List<String>> responses = {
    'greeting': [
      "Hi! I'm Mindy, your AI travel assistant 🌍 I can help you plan your perfect trip in Egypt. What would you like to do today?",
    ],
    'destination': [
      "Egypt has amazing destinations! 🏛️ Here are some popular picks:\n\n"
          "• **Cairo** — The bustling capital with the Pyramids of Giza & Egyptian Museum\n"
          "• **Luxor** — The world's greatest open-air museum with Valley of the Kings\n"
          "• **Aswan** — Serene Nile views, Philae Temple & Nubian villages\n"
          "• **Hurghada** — Crystal-clear Red Sea for diving & snorkeling\n"
          "• **Sharm El-Sheikh** — Beach paradise with coral reefs\n\n"
          "Would you like me to plan a trip to any of these? 🗺️",
      "Great question! Here are some hidden gems in Egypt you might love:\n\n"
          "• **Siwa Oasis** — A remote desert oasis with natural hot springs\n"
          "• **Fayoum** — Beautiful lakes and whale fossils in Wadi El-Hitan\n"
          "• **Dahab** — Laid-back Red Sea town, perfect for diving\n"
          "• **Alexandria** — Mediterranean vibes with historic sites\n\n"
          "Tell me more about what kind of experience you're looking for! ✨",
    ],
    'hotel': [
      "I'd be happy to help you find the perfect stay! 🏨\n\n"
          "Here are some recommendations by budget:\n\n"
          "**💰 Budget-Friendly:**\n"
          "• Hostels starting from \$10/night in Cairo & Luxor\n\n"
          "**💵 Mid-Range:**\n"
          "• 4-star hotels from \$50-100/night with great Nile views\n\n"
          "**💎 Luxury:**\n"
          "• 5-star resorts from \$150+/night — Marriott, Hilton, Sofitel\n\n"
          "Which city and budget range are you looking at?",
      "Looking for a place to stay? Here are my top picks:\n\n"
          "• **Cairo** — Kempinski Nile Hotel for luxury, Cairo Marriott for mid-range\n"
          "• **Luxor** — Winter Palace for a historic experience\n"
          "• **Hurghada** — Steigenberger Al Dau Beach for all-inclusive fun\n\n"
          "Want me to help you narrow it down? 😊",
    ],
    'food': [
      "Egyptian cuisine is incredible! 🍽️ Here's what you must try:\n\n"
          "• **Koshari** — Egypt's national dish (rice, lentils, pasta, tomato sauce)\n"
          "• **Ful Medames** — Fava beans, a breakfast staple\n"
          "• **Shawarma** — Juicy grilled meat wraps\n"
          "• **Molokhia** — Green soup with rice, a local favorite\n"
          "• **Um Ali** — Delicious bread pudding dessert\n\n"
          "For the best food experience, I recommend trying local street food in downtown Cairo! 🌯",
      "Hungry for recommendations? 😋\n\n"
          "**Best Restaurants:**\n"
          "• **Abou El Sid** (Cairo) — Authentic Egyptian fine dining\n"
          "• **Zooba** (Cairo) — Modern Egyptian street food\n"
          "• **Sofra** (Luxor) — Traditional Upper Egyptian cuisine\n\n"
          "**Street Food Must-Tries:**\n"
          "• Falafel (ta'ameya) from any local stand\n"
          "• Fresh sugarcane juice\n"
          "• Hawawshi — Egyptian meat pie\n\n"
          "Would you like restaurant suggestions for a specific city?",
    ],
    'activity': [
      "There's so much to do in Egypt! 🎯 Here are top activities:\n\n"
          "**🏛️ Historical:**\n"
          "• Visit the Pyramids & Sphinx\n"
          "• Explore Valley of the Kings in Luxor\n"
          "• Tour the Egyptian Museum\n\n"
          "**🏖️ Adventure:**\n"
          "• Scuba diving in the Red Sea\n"
          "• Desert safari in the Western Desert\n"
          "• Hot air balloon ride over Luxor\n\n"
          "**🎨 Cultural:**\n"
          "• Felucca ride on the Nile\n"
          "• Visit a Nubian village in Aswan\n"
          "• Shop at Khan El Khalili bazaar\n\n"
          "What type of activities interest you most?",
    ],
    'budget': [
      "Let me help you plan your budget! 💰\n\n"
          "**Typical daily costs in Egypt:**\n\n"
          "🙂 **Budget traveler:** \$20-40/day\n"
          "• Hostel + street food + public transport\n\n"
          "💵 **Mid-range:** \$60-120/day\n"
          "• 3-4 star hotel + restaurants + guided tours\n\n"
          "💎 **Luxury:** \$200+/day\n"
          "• 5-star hotel + private tours + fine dining\n\n"
          "💡 **Tip:** Prices are very negotiable at markets and for taxis!\n\n"
          "What budget range works best for you?",
    ],
    'transport': [
      "Getting around Egypt is easy! 🚗\n\n"
          "**Between cities:**\n"
          "• ✈️ Domestic flights (Cairo → Luxor ~1hr, from \$40)\n"
          "• 🚂 Sleeper trains (Cairo → Aswan, overnight)\n"
          "• 🚌 GO Bus — comfortable, affordable\n\n"
          "**Within cities:**\n"
          "• 🚇 Cairo Metro — cheapest option\n"
          "• 🚕 Uber/Careem — reliable and metered\n"
          "• White taxis — negotiate price first!\n\n"
          "💡 **Pro tip:** Book trains early for sleeper cabins.\n\n"
          "Need help planning transportation for your trip?",
    ],
    'weather': [
      "Here's what to expect weather-wise! ☀️\n\n"
          "**🌸 Spring (Mar-May):** Perfect — 25-30°C, great for sightseeing\n"
          "**☀️ Summer (Jun-Aug):** Very hot — 35-45°C, best for Red Sea/beach\n"
          "**🍂 Autumn (Sep-Nov):** Pleasant — 25-30°C, ideal for most activities\n"
          "**❄️ Winter (Dec-Feb):** Mild — 15-20°C, perfect for desert trips\n\n"
          "💡 **Best time to visit:** October to April\n\n"
          "When are you planning to travel?",
    ],
    'general': [
      "That's a great question! 🤔 Let me think about that...\n\n"
          "I'm your AI travel assistant and I can help you with:\n"
          "• 🗺️ Destination recommendations\n"
          "• 🏨 Hotel & accommodation tips\n"
          "• 🍽️ Food & restaurant suggestions\n"
          "• 🎯 Activities & attractions\n"
          "• 💰 Budget planning\n"
          "• 🚗 Transportation advice\n\n"
          "What would you like to know more about?",
      "I'd love to help with that! ✨ Could you tell me a bit more about what you're looking for?\n\n"
          "For example:\n"
          "• What destination interests you?\n"
          "• When do you plan to travel?\n"
          "• What's your budget range?\n"
          "• Any specific activities you enjoy?\n\n"
          "The more details you share, the better I can assist! 😊",
    ],
  };

  /// Trip summary template.
  static String tripSummary({
    required String destination,
    required String startDate,
    required String endDate,
    required int adults,
    required int children,
    required int pets,
    required String budget,
    required List<String> interests,
  }) {
    final travelers = StringBuffer();
    travelers.write('$adults adult${adults > 1 ? 's' : ''}');
    if (children > 0) {
      travelers.write(', $children child${children > 1 ? 'ren' : ''}');
    }
    if (pets > 0) {
      travelers.write(', $pets pet${pets > 1 ? 's' : ''}');
    }

    final interestList = interests.map((i) => '• $i').join('\n');

    return "✨ **Here's your trip plan summary!** ✨\n\n"
        "📍 **Destination:** $destination\n"
        "📅 **Dates:** $startDate — $endDate\n"
        "👥 **Travelers:** $travelers\n"
        "💰 **Budget:** $budget\n\n"
        "**🎯 Interests:**\n$interestList\n\n"
        "I'm now generating a personalized itinerary based on your preferences. "
        "This might take a moment... 🔄";
  }

  static const String retryMessage =
      "Oops! Something went wrong while generating your plan 😔\n\n"
      "Don't worry — this happens sometimes. You can:\n"
      "• **Try again** with the same preferences\n"
      "• **Modify your plan** to adjust your selections\n"
      "• **Talk to support** if the issue persists\n\n"
      "What would you like to do?";
}
