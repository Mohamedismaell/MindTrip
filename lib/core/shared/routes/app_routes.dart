class AppRoutes {
  //! Splash & Onboarding routes
  static const String splash = '/splash';
  static const String onBoarding = '/onboarding';
  static const String welcomeAuth = '/welcomeauth';

  //! Authentication routes
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forgetPassword';
  static const String otpVerification = '/otpVerification';
  static const String resetPassword = '/resetPassword';
  static const String completeSignUpScreen = '/completeSignUpScreen';
  static const String completeResetPasswordScreen =
      '/completeResetPasswordScreen';

  //! home
  static const String home = '/home';
  static const String recommendedPlaces = '/recommendedPlaces';

  //! favorites
  static const String favorites = '/favorites';

  //! explore
  static const String explore = '/explore';

  //! aiPlanner
  static const String aiPlannerIntro = '/ai-planner';
  static const String aiPlannerFlow = '/ai-planner/flow';
  static const String aiPlannerChat = '/ai-planner/flow/chat';
  static const String myTrips = '/ai-planner/my-trips';
  static const String tripCalendar = '/ai-planner/trip-calendar';
  static const String tripDetails = '/ai-planner/trip-details';

  //! profile
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String profileSettings = '/profile/settings';
  static const String profileTerms = '/profile/settings/terms';
  static const String profilePolicy = '/profile/settings/policy';
  static const String profileFaq = '/profile/settings/faq';

  //! interests
  static const String interests = '/interests';

  //! map
  static const String map = '/map';
  static const String mapSearch = '/map/search';

  //! place details
  static const String placeDetails = '/place-details';

  //! Add to Trip
  static const String addToTripSelectTrip = '/add-to-trip/select-trip';
  static const String addToTripCreatePlan = '/add-to-trip/create-plan';
  static const String addToTripManage = '/add-to-trip/manage';
  static const String addToTripSelectDay = '/add-to-trip/select-day';
}
