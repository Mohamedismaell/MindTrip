import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthProvider {
  final GoogleSignIn _google = GoogleSignIn.instance;

  Future<String?> signIn() async {
    await _google.initialize(
      serverClientId:
          "316222442921-faaef736j2ule3pneimge0n46t3tdfd6.apps.googleusercontent.com",
    );
    final account = await _google.authenticate();

    if (account == null) {
      return null;
    }

    final auth = await account.authentication;

    return auth.idToken;
  }

  Future<void> signOut() async {
    await _google.signOut();
  }
}
