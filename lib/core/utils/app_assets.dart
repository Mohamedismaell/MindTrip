class AppAssets {
  AppAssets._();

  static const String _imagesPath = 'assets/images';
  static const String _authImagesPath = '$_imagesPath/authentication';
  static const String _onboardingImagesPath = '$_imagesPath/onboarding';
  static const String _splashImagesPath = '$_imagesPath/splash';
  static const String _animationImagesPath = '$_imagesPath/animation';
  static const String _iconsPath = 'assets/icons';

  // Splash
  static const String splashPattern = '$_splashImagesPath/Pattern.jpg';
  static const String splashLogo = '$_splashImagesPath/logo.png';
  static const String loadingAnimation = '$_animationImagesPath/Loading.json';

  // Onboarding Images
  static const String pyramidsImage = '$_onboardingImagesPath/Pyramids.jpg';
  static const String aiPlannerImage = '$_onboardingImagesPath/Ai_Planner.png';
  static const String budgetOptimizerImage =
      '$_onboardingImagesPath/Budget_Optimizer.png';
  static const String hiddenGemsImage =
      '$_onboardingImagesPath/Hidden_Gems.png';

  // Auth Images & SVGs
  static const String emailCampaignSvg =
      '$_authImagesPath/Email campaign-cuate 1(1).svg';
  static const String otpSvg = '$_authImagesPath/Email campaign-cuate 1(2).svg';
  static const String resetePasswordSvg =
      '$_authImagesPath/Email campaign-cuate 1(3).svg';
  static const String completeSvg =
      '$_authImagesPath/undraw_well-done_kqud 1.svg';

  // Icons
  static const String emailIcon = '$_iconsPath/email.svg';
  static const String lockIcon = '$_iconsPath/lock.svg';
  static const String personIcon = '$_iconsPath/person.svg';
}

class HomeAssets {
  HomeAssets._();

  static const String _iconPath = 'assets/icons/home';

  // Splash
  static const String notificaitonIcon =
      '$_iconPath/carbon_notification-new.svg';
  static const String notificaitonWithoutDotIcon =
      '$_iconPath/notification_without_dot.svg';
  static const String locationIcon = '$_iconPath/location.svg';
  static const String drawerIcon = '$_iconPath/drawer.svg';
  static const String personIcon = '$_iconPath/person.svg';
  static const String redDotIcon = '$_iconPath/red_dot.svg';
  static const String filterIcon = '$_iconPath/filter1.svg';
  static const String blackHeartIcon = '$_iconPath/black_heart.svg';
  static const String upTRightArrowtIcon = '$_iconPath/up_t_right_arrow.svg';
  static const String homeIcon = '$_iconPath/home.svg';
  static const String exploreHeartIcon = '$_iconPath/explore.svg';
  static const String whiteHeartIcon = '$_iconPath/white_heart.svg';
  static const String aiStars = '$_iconPath/ai_stars.svg';
}
