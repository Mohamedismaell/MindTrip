import 'package:mindtrip/core/utils/app_assets.dart';
import 'package:mindtrip/core/utils/app_strings.dart';

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
      firstTitle: AppStrings.discover,
      secondTitle: AppStrings.egypt,
      quote: AppStrings.discoverQuote,
      // nextAction: 'Start Searching',
      imagePath: AppAssets.pyramidsImage,
    ),
    OnboardingModel(
      firstTitle: AppStrings.ai,
      secondTitle: AppStrings.planner,
      quote: AppStrings.aiQuote,
      // nextAction: 'Start Searching',
      imagePath: AppAssets.aiPlannerImage,
    ),
    OnboardingModel(
      firstTitle: AppStrings.budget,
      secondTitle: AppStrings.optimizer,
      quote: AppStrings.budgetQuote,
      // nextAction: 'Start Searching',
      imagePath: AppAssets.budgetOptimizerImage,
    ),
    OnboardingModel(
      firstTitle: AppStrings.hidden,
      secondTitle: AppStrings.gems,
      quote: AppStrings.hiddenQuote,
      // nextAction: 'Start Searching',
      imagePath: AppAssets.hiddenGemsImage,
    ),
  ];
}
