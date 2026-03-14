import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mindtrip/core/shared/auth/providers/social_auth_provider.dart';

class FacebookAuthProvider implements SocialAuthProvider {
  @override
  Future<String?> signIn() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      return null;
    }

    final accessToken = result.accessToken;

    return accessToken?.tokenString;
  }

  @override
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }
}
