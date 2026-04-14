class ProfileStatData {
  const ProfileStatData({required this.label, required this.value});

  final String label;
  final String value;
}

class ProfileInterestData {
  const ProfileInterestData({required this.category});

  final String category;
}

class ProfileTripData {
  const ProfileTripData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isFavorite = true,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
  final bool isFavorite;
}

class ProfileReviewData {
  const ProfileReviewData({
    required this.title,
    required this.location,
    required this.body,
    this.rating = 5,
  });

  final String title;
  final String location;
  final String body;
  final int rating;
}

class ProfileMockData {
  const ProfileMockData._();

  // static const String defaultAvatarUrl =
  //     'assets/images/profile/deafult_user_cover.png';
  static const String username = '@UnKnown';
  static const String phoneNumber = '0122 547 9032';
  static const String location = 'Cairo,Egypt';
  static const String bio =
      'Adventure seeker 🌊 | History Lover 🏛️ Always Planning the next trip across Egypt';

  static const List<ProfileStatData> stats = [
    ProfileStatData(label: 'Trips', value: '5'),
    ProfileStatData(label: 'Reviews', value: '3'),
    ProfileStatData(label: 'Saved', value: '10'),
  ];

  // static const List<ProfileInterestData> interests = [
  //   ProfileInterestData(emoji: '🔥', label: 'Camping'),
  //   ProfileInterestData(emoji: '🛶', label: 'Kayaking'),
  //   ProfileInterestData(emoji: '🧺', label: 'Picnic'),
  //   ProfileInterestData(emoji: '⛺', label: 'Adventure'),
  //   ProfileInterestData(emoji: '🎭', label: 'Culture'),
  // ];

  static const List<ProfileTripData> savedTrips = [
    ProfileTripData(
      title: 'Dahab',
      subtitle: 'Saved destination',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/942ac9bb-0a22-4c80-8aaf-e5e8535a1ee0',
    ),
    ProfileTripData(
      title: 'El-Alamein',
      subtitle: 'Saved destination',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/6f6a5481-09ca-4c7a-8b4d-6ccf3c4c7d85',
    ),
  ];

  static const List<ProfileTripData> myTrips = [
    ProfileTripData(
      title: 'The Caves',
      subtitle: 'Dahab | Mar 2026',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/4f6f22df-9ba2-4d55-b473-58c8248bcbf8',
    ),
    ProfileTripData(
      title: 'Lighthouse Reef',
      subtitle: 'Dahab | Mar 2026',
      imageUrl:
          'https://www.figma.com/api/mcp/asset/e455c99a-0618-4fb1-bcf9-7c1680ee019a',
      isFavorite: false,
    ),
  ];

  static const List<ProfileReviewData> reviews = [
    ProfileReviewData(
      title: 'The Blue Hole',
      location: 'Dahab, Sinai',
      body:
          'Absolutely breathtaking! A hidden gem that every diver must '
          'experience. The crystal clear water is beyond words.',
    ),
    ProfileReviewData(
      title: 'Karnak Temple',
      location: 'Luxor,Egypt',
      body:
          'Walking through these ancient pillars feels like stepping back in '
          'time. A must-visit for history lovers! The scale is just '
          'unbelievable.',
    ),
  ];

  static const List<String> settingsPlaceholders = [
    'Language',
    'Wallet',
    'General Settings',
    'FAQ',
    'Terms & Conditions',
    'User Policy',
  ];
}
