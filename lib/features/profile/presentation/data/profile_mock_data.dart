class ProfileStatData {
  const ProfileStatData({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;
}

class ProfileTripData {
  const ProfileTripData({
    required this.title,
    required this.subtitle,
    required this.badge,
  });

  final String title;
  final String subtitle;
  final String badge;
}

class ProfileReviewData {
  const ProfileReviewData({
    required this.title,
    required this.subtitle,
    required this.dateLabel,
  });

  final String title;
  final String subtitle;
  final String dateLabel;
}

class ProfileMockData {
  const ProfileMockData._();

  static const String username = '@mindtrip.traveler';
  static const String phoneNumber = '+20 109 555 0184';

  static const List<ProfileStatData> stats = [
    ProfileStatData(label: 'Trips', value: '12'),
    ProfileStatData(label: 'Saved', value: '28'),
    ProfileStatData(label: 'Reviews', value: '08'),
  ];

  static const List<String> interests = [
    'Adventure',
    'Culture',
    'Food',
    'Nature',
    'Weekend escapes',
  ];

  static const List<ProfileTripData> savedTrips = [
    ProfileTripData(
      title: 'Santorini Sunset Escape',
      subtitle: '4 days • Ocean views • Saved for summer',
      badge: 'Saved',
    ),
    ProfileTripData(
      title: 'Cairo Old Town Walk',
      subtitle: '2 days • Local food • History stops',
      badge: 'Popular',
    ),
  ];

  static const List<ProfileTripData> myTrips = [
    ProfileTripData(
      title: 'Alexandria Weekend',
      subtitle: 'Planned for next month',
      badge: 'Upcoming',
    ),
    ProfileTripData(
      title: 'Nile Cruise Notes',
      subtitle: 'Private draft itinerary',
      badge: 'Draft',
    ),
  ];

  static const List<ProfileReviewData> reviews = [
    ProfileReviewData(
      title: 'Blue Lagoon Stay',
      subtitle: '“Beautiful spot, easy booking, and worth the early start.”',
      dateLabel: '2 weeks ago',
    ),
    ProfileReviewData(
      title: 'Old Cairo Market Tour',
      subtitle: '“Great guide and a very relaxed pace for first-timers.”',
      dateLabel: '1 month ago',
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
