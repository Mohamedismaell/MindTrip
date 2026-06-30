class EndPoints {
  static String baseUrl = 'https://tripmind.runasp.net/';

  //Auth
  static String login = 'api/v1/auth/login';
  static String register = 'api/v1/auth/register';
  static String refreshToken = 'api/v1/auth/refresh';
  static String logout = 'api/v1/auth/logout';
  static String googleLogin = 'api/v1/auth/google';
  static String facebookLogin = 'api/v1/auth/facebook';
  static String forgetPassword = 'api/v1/auth/password/forgot';
  static String verifyPasswordOtp = 'api/v1/auth/password/verifyotp';
  static String resetPassword = 'api/v1/auth/password/reset';
  static String resendPasswordOtp = 'api/v1/auth/password/resend-otp';
  static String verifyEmail = 'api/v1/auth/email/verify';
  static String resendEmailOtp = 'api/v1/auth/email/resend-otp';
  static String deleteAccount = 'api/v1/users/me';

  //User
  static String getCurrentUser = 'api/v1/users/me';
  static String updateProfile = 'api/v1/users/me';
  static String insertInterests = 'api/v1/users/me/interests';
  static String uploadPhoto = 'api/v1/users/me/photo';
  static String getMyReviews = 'api/v1/users/me/reviews';

  // Places
  static String getRecommendedPlaces = 'api/v1/ai/places/recommend';

  //! Would be with hidden gems
  static String getPopularPlaces = 'api/v1/ai/places/top-rated';
  static String searchPlaces = 'api/v1/ai/places/search';
  static String getPlaces = 'api/v1/ai/places/getplaces';
  static String getNearbyPlaces = 'api/v1/ai/places/nearby';
  static String placeDetails(String id) => 'api/v1/ai/places/$id';

  // Home & Explore
  static String getBanners = 'api/v1/home/banners';
  static String getPlannerPreviews = 'api/v1/home/planner-previews';

  // Favorites
  static String favoritePlaces = 'api/v1/favorites/places';
  static String deleteFavoritePlace(String placeId) =>
      'api/v1/favorites/places/$placeId';
  static String favoriteTrips = 'api/v1/favorites/trips';
  static String favoriteTrip(String tripId) => 'api/v1/favorites/trips/$tripId';

  // AI Planner
  static String generatePlan = 'api/v1/ai/generate-plan';
  static String aiChat = 'api/v1/ai/chat';
  static String aiEdit = 'api/v1/ai/edit';

  // Trips
  static String trips = 'api/v1/trips';
  static String tripById(String id) => 'api/v1/trips/$id';
  static String tripPlan(String id) => 'api/v1/trips/$id/plan';
  static String tripStatus(String id) => 'api/v1/trips/$id/status';
  static String tripRename(String id) => 'api/v1/trips/$id/rename';
  static String tripShare(String id) => 'api/v1/trips/$id/share';
  static String tripReview(String id) => 'api/v1/trips/$id/review';
  static String tripReviewMe(String id) => 'api/v1/trips/$id/review/me';
  static String confirmTrip(String id) => 'api/v1/trips/$id/confirm';
}

class ApiKeys {
  static String authorization = 'Authorization';
  static String bearer = 'Bearer';
  // static String googleAndroidClientId =
  //     '316222442921-faaef736j2ule3pneimge0n46t3tdfd6.apps.googleusercontent.com';
}
