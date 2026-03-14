abstract class SocialAuthProvider {
  Future<String?> signIn();
  Future<void> signOut();
}
