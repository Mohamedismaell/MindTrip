import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:mindtrip/core/shared/auth/providers/social_auth_provider.dart';

class FacebookAuthProvider implements SocialAuthProvider {
  @override
  Future<String?> signIn() async {
    final LoginResult result = await FacebookAuth.instance.login();

    switch (result.status) {
      case LoginStatus.success:
        return result.accessToken?.tokenString;

      case LoginStatus.cancelled:
        return null;

      case LoginStatus.failed:
        throw Exception(result.message ?? 'Facebook sign in failed');

      case LoginStatus.operationInProgress:
        throw Exception('Facebook sign in already in progress');
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }
}
