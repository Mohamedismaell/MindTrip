import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/auth/providers/social_auth_provider.dart';

class GoogleAuthProvider implements SocialAuthProvider {
  final GoogleSignIn _google = GoogleSignIn.instance;

  @override
  Future<String?> signIn() async {
    await _google.initialize(serverClientId: ApiKeys.googleAndroidClientId);
    final account = await _google.authenticate();

    final auth = account.authentication;

    return auth.idToken;
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
  }
}
