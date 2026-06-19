import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static String get mapBoxApiKey => dotenv.env['MAP_BOX_API'] ?? '';

  static bool get isDevelopment => dotenv.env['ENVIRONMENT'] == 'development';

  static String get googlePlacesKey => dotenv.env['GOOGLE_PLACES_KEY'] ?? '';
  static String get googleWebClientId =>
      dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
}
