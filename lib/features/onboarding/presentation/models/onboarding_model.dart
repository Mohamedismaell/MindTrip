class OnboardingModel {
  final String firstTitle;
  final String secondTitle;
  final String quote;
  // final String nextAction;
  final String imagePath;

  const OnboardingModel({
    required this.firstTitle,
    required this.secondTitle,
    required this.quote,
    // required this.nextAction,
    required this.imagePath,
  });
  static List<OnboardingModel> onboardingList = [
    OnboardingModel(
      firstTitle: 'Discover ',
      secondTitle: 'Egypt',
      quote: 'Start your greatest exploration where legends began.',
      // nextAction: 'Start Searching',
      imagePath: 'assets/images/onboarding/Pyramids.jpg',
    ),
    OnboardingModel(
      firstTitle: 'AI',
      secondTitle: 'Planner ',
      quote: 'Let AI create your dream trip across Egypt',
      // nextAction: 'Start Searching',
      imagePath: 'assets/images/onboarding/Ai_Planner.png',
    ),
    OnboardingModel(
      firstTitle: 'Budget ',
      secondTitle: 'Optimizer',
      quote: 'Smart AI matches your budget to your trip',
      // nextAction: 'Start Searching',
      imagePath: 'assets/images/onboarding/Budget_Optimizer.png',
    ),
    OnboardingModel(
      firstTitle: 'Hidden ',
      secondTitle: 'Gems',
      quote:
          'Discover secret cafes, cozy restaurants, and fun spots across Egypt.',
      // nextAction: 'Start Searching',
      imagePath: 'assets/images/onboarding/Hidden_Gems.png',
    ),
  ];
}
