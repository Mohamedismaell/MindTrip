class ProfileLegalSection {
  const ProfileLegalSection({required this.title, required this.items});

  final String title;
  final List<String> items;
}

class ProfileFaqItem {
  const ProfileFaqItem({required this.question, required this.answer});

  final String question;
  final String answer;
}

class ProfileLegalContent {
  const ProfileLegalContent._();

  static const termsWebUrl = 'https://mindtrip.example.com/terms';
  static const policyWebUrl = 'https://mindtrip.example.com/policy';
  static const faqWebUrl = 'https://mindtrip.example.com/faq';

  static const termsSections = [
    ProfileLegalSection(
      title: '1. Use of the App',
      items: [
        'MindTrip helps users discover destinations, explore places, and plan trips.',
        'You agree to use the app legally and respectfully.',
        'You must not misuse, copy, hack, or disrupt the app or its services.',
      ],
    ),
    ProfileLegalSection(
      title: '2. User Accounts',
      items: [
        'Some features may require creating an account.',
        'You are responsible for keeping your login information secure.',
        'All activity under your account is your responsibility.',
      ],
    ),
    ProfileLegalSection(
      title: '3. Trip Planning & Recommendations',
      items: [
        'MindTrip provides destination suggestions and travel recommendations for informational purposes only.',
        'We do not guarantee the accuracy, availability, or pricing of destinations, routes, or services.',
        'Travel conditions and information may change at any time.',
      ],
    ),
    ProfileLegalSection(
      title: '4. Location Services',
      items: [
        'Location access may be used to improve nearby recommendations and map experiences.',
        'You can disable location permissions anytime from your device settings.',
      ],
    ),
    ProfileLegalSection(
      title: '5. Saved Trips & Content',
      items: [
        'You can save trips, destinations, and preferences inside the app.',
        'Uploaded content remains your property.',
        'By uploading content, you allow MindTrip to display and use it within the app experience.',
      ],
    ),
    ProfileLegalSection(
      title: '6. Third-Party Services',
      items: [
        'MindTrip may use third-party services such as maps, analytics, authentication, and payment providers.',
        'Third-party services operate under their own terms and privacy policies.',
      ],
    ),
    ProfileLegalSection(
      title: '7. Service Availability',
      items: [
        'We may update, modify, or temporarily stop parts of the service at any time.',
        'We are not responsible for interruptions, outages, or technical issues outside our control.',
      ],
    ),
    ProfileLegalSection(
      title: '8. Limitation of Liability',
      items: [
        'MindTrip is provided “as is” without warranties.',
        'We are not responsible for travel disruptions, inaccurate information, or damages resulting from the use of the app.',
      ],
    ),
    ProfileLegalSection(
      title: '9. Changes to These Terms',
      items: [
        'These terms may be updated from time to time.',
        'Continued use of the app after updates means you accept the revised terms.',
      ],
    ),
  ];

  static const policySections = [
    ProfileLegalSection(
      title: '1. Information We Collect',
      items: [
        'We may collect information such as your name, email address, travel preferences, and account details to improve your experience.',
      ],
    ),
    ProfileLegalSection(
      title: '2. How We Use Your Data',
      items: [
        'Your information is used to personalize recommendations, improve app functionality, and support core features.',
      ],
    ),
    ProfileLegalSection(
      title: '3. Location Data',
      items: [
        'Location data may be used to show nearby destinations, improve recommendations, and support map features.',
      ],
    ),
    ProfileLegalSection(
      title: '4. Data Security',
      items: [
        'We apply reasonable security measures to help protect your information and keep it secure.',
      ],
    ),
    ProfileLegalSection(
      title: '5. Data Sharing',
      items: [
        'MindTrip does not sell your personal information.',
        'Some data may be shared with trusted services required for app functionality such as analytics, maps, or authentication providers.',
      ],
    ),
    ProfileLegalSection(
      title: '6. Your Rights',
      items: [
        'You may request access, updates, or deletion of your personal information at any time.',
      ],
    ),
    ProfileLegalSection(
      title: '7. Changes to This Policy',
      items: [
        'This policy may be updated occasionally.',
        'Continued use of the app means you accept the latest version of the policy.',
      ],
    ),
  ];

  static const faqs = [
    ProfileFaqItem(
      question: 'What is MindTrip?',
      answer:
          'MindTrip is a travel planning app that helps users discover destinations, explore places, and organize trips based on their interests.',
    ),
    ProfileFaqItem(
      question: 'How does MindTrip create recommendations?',
      answer:
          'MindTrip uses your travel preferences, interests, destination context, and app activity to generate personalized recommendations.',
    ),
    ProfileFaqItem(
      question: 'How can I plan a trip in the app?',
      answer:
          'Open the AI Planner, choose your destination, trip duration, interests, travelers, and budget, then review the generated travel plan.',
    ),
    ProfileFaqItem(
      question: 'Can I save favorite destinations?',
      answer:
          'Yes. You can save destinations and trips for easier access later.',
    ),
    ProfileFaqItem(
      question: 'Can I edit a planned trip?',
      answer:
          'Trip editing support will continue improving over time. Current planning flows may vary depending on the feature.',
    ),
    ProfileFaqItem(
      question: 'Why are recommendations different for each user?',
      answer:
          'Recommendations differ because users can have different interests, budgets, locations, and travel goals.',
    ),
    ProfileFaqItem(
      question: 'Does MindTrip require internet access?',
      answer:
          'Most discovery, recommendation, and trip planning features require internet access to load updated travel information.',
    ),
    ProfileFaqItem(
      question: 'Is my information secure?',
      answer:
          'MindTrip uses modern security practices to help protect your information and improve your travel experience safely.',
    ),
  ];
}
