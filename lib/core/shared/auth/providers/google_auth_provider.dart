import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindtrip/core/utils/app_env.dart';
import 'package:mindtrip/core/shared/auth/providers/social_auth_provider.dart';

class GoogleAuthProvider implements SocialAuthProvider {
  final GoogleSignIn _google = GoogleSignIn.instance;
  // static const String _googleWebClientId = String.fromEnvironment(
  //   'GOOGLE_WEB_CLIENT_ID',
  // );

  @override
  Future<String?> signIn() async {
    // Provide both serverClientId (for Android to get idToken) and clientId (for Web/iOS)
    await _google.initialize(serverClientId: AppEnv.googleWebClientId);
    final account = await _google.authenticate();
    final auth = account.authentication;

    return auth.idToken;
  }

  @override
  Future<void> signOut() async {
    await _google.signOut();
  }
}
// metohiw694@okcpress.com
// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mindtrip/core/shared/auth/providers/social_auth_provider.dart';

// class GoogleAuthProvider implements SocialAuthProvider {
//   static const String _googleWebClientId = String.fromEnvironment(
//     'GOOGLE_WEB_CLIENT_ID',
//   );

//   final firebase_auth.FirebaseAuth _firebaseAuth =
//       firebase_auth.FirebaseAuth.instance;

//   /// initialize() must be called EXACTLY ONCE before any other method.
//   /// Call this from your app startup (e.g. main() or a DI setup),
//   /// NOT inside signIn() — calling it more than once causes undefined behavior.
//   static Future<void> initialize() async {
//     await GoogleSignIn.instance.initialize(serverClientId: _googleWebClientId);
//   }

//   @override
//   Future<String?> signIn() async {
//     // account.authentication is a synchronous getter in google_sign_in v7,
//     // NOT a Future — do not use await here.
//     final account = await GoogleSignIn.instance.authenticate();

//     final auth = account.authentication;

//     final credential = firebase_auth.GoogleAuthProvider.credential(
//       idToken: auth.idToken,
//     );

//     final userCredential =
//         await _firebaseAuth.signInWithCredential(credential);

//     final firebaseToken = await userCredential.user?.getIdToken();

//     return firebaseToken;
//   }

//   @override
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//     await GoogleSignIn.instance.signOut();
//   }
// }
