class OnboardingModel {
  final String title;
  final String quote;
  // final String nextAction;
  final List<String> imagePath;

  const OnboardingModel({
    required this.title,
    required this.quote,
    // required this.nextAction,
    required this.imagePath,
  });
  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      title: 'First to know',
      quote: 'All news in one place, be the first to know last news',
      // nextAction: 'Start Searching',
      imagePath: [
        'assets/images/Rectangle 18.png',
        'assets/images/Rectangle 17.png',
        'assets/images/Rectangle 16.png'
      ],
    ),
    OnboardingModel(
      title: 'QuickRead',
      quote: 'All news in one place, be the first to know last news',
      // nextAction: 'Start Searching',
      imagePath: ['assets/images/3d-illustration.png'],
    ),
  ];
}
