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

  // Places
  static String getRecommendedPlaces = 'api/v1/ai/places/recommend';

  //! Would be with hidden gems
  static String getPopularPlaces = 'api/v1/ai/places/top-rated';
  static String searchPlaces = 'api/v1/ai/places/search';
  static String getPlaces = 'api/v1/ai/places/getplaces';
  static String placeDetails(String id) => 'api/v1/ai/places/$id';

  // Home & Explore
  static String getBanners = 'api/v1/home/banners';
  static String getPlannerPreviews = 'api/v1/home/planner-previews';

  // static String formatCategoryQuery(String category) {
  //   return 'category:"$category"';
  // }

  // static String formatDateQuery(DateTime time) {
  //   return 'ts:"$time"';
  // }
}

class ApiKeys {
  static String authorization = 'Authorization';
  static String bearer = 'Bearer';
  // static String googleAndroidClientId =
  //     '316222442921-faaef736j2ule3pneimge0n46t3tdfd6.apps.googleusercontent.com';
}
