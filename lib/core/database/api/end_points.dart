class EndPoints {
  static String baseUrl = 'https://tripmind.runasp.net/';
  static String login = 'api/v1/auth/login';
  static String register = 'api/v1/auth/register';
  static String refreshToken = 'api/v1/auth/refresh';
  static String getCurrentUser = 'api/v1/auth/me';
  static String logout = 'api/v1/auth/logout';
  static String googleLogin = 'api/v1/auth/google';
  static String facebookLogin = 'api/v1/auth/facebook';
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
  static String googleAndroidClientId =
      '316222442921-faaef736j2ule3pneimge0n46t3tdfd6.apps.googleusercontent.com';
}
