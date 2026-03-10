import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';
import 'package:mindtrip/features/authetication/data/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiConsumer _api;
  AuthRemoteDataSource({required ApiConsumer api}) : _api = api;

  //  Sign In

  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await _api.post(
      EndPoints.login,
      data: {'email': email, 'password': password, 'rememberMe': rememberMe},
    );

    return AuthResponseModel.fromJson(response);
  }

  //  Sign Up

  Future<AuthResponseModel> signUp({
    required String name,
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    final response = await _api.post(
      EndPoints.register,
      data: {
        'displayName': name,
        'email': email,
        'password': password,
        'confirmPassword': password,
        'rememberMe': rememberMe,
      },
    );

    return AuthResponseModel.fromJson(response);
  }

  //  Refresh Token
  Future<AuthResponseModel> refreshToken({required String refreshToken}) async {
    final response = await _api.post(
      EndPoints.refreshToken,
      data: {"refreshToken": refreshToken},
    );

    return AuthResponseModel.fromJson(response);
  }

  //  Get Current User

  /// GET /auth/me
  ///
  /// Fetches the profile of the currently authenticated user using the stored
  /// access token. Returns a [UserModel].
  Future<UserModel> getCurrentUser({required String accessToken}) async {
    // TODO: Replace with real API call
    // final response = await _api.get('/auth/me', headers: { 'Authorization': 'Bearer $accessToken' });
    await Future.delayed(const Duration(seconds: 1));

    return UserModel.fromJson({
      'userId': 'usr_001',
      'displayName': 'Mohamed Ismaeel',
      'email': 'user@example.com',
      'profilePhotoUrl': null,
      'languagePreference': 'AR',
    });
  }

  //  Logout (server-side)

  /// POST /auth/logout
  ///
  /// Optional server-side session invalidation.
  Future<void> logout({required String accessToken}) async {
    // TODO: Replace with real API call
    // await _api.post('/auth/logout', headers: { 'Authorization': 'Bearer $accessToken' });
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
