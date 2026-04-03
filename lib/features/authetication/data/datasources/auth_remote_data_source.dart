import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/features/authetication/data/models/auth_response_model.dart';

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

  // //  Get Current User
  // Future<UserModel> getCurrentUser({required String accessToken}) async {
  //   // TODO: Replace with real API call
  //   // final response = await _api.get('/auth/me', headers: { 'Authorization': 'Bearer $accessToken' });
  //   await Future.delayed(const Duration(seconds: 1));

  //   return UserModel.fromJson({
  //     'userId': 'usr_001',
  //     'displayName': 'Mohamed Ismaeel',
  //     'email': 'user@example.com',
  //     'profilePhotoUrl': null,
  //     'languagePreference': 'AR',
  //   });
  // }

  Future<AuthResponseModel> signInWithGoogle({required String idToken}) async {
    final response = await _api.post(
      EndPoints.googleLogin,
      data: {"idToken": idToken},
    );

    return AuthResponseModel.fromJson(response);
  }

  Future<AuthResponseModel> signInWithFacebook({
    required String accessToken,
  }) async {
    final response = await _api.post(
      EndPoints.facebookLogin,
      data: {"AccessToken": accessToken},
    );

    return AuthResponseModel.fromJson(response);
  }

  Future<void> forgetPassword({required String email}) async {
    await _api.post(EndPoints.forgetPassword, data: {"email": email});
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    await _api.post(EndPoints.verifyOtp, data: {"email": email, "otp": otp});
  }

  // Logout
  Future<void> logout({required String refreshToken}) async {
    await _api.post(EndPoints.logout, data: {"refreshToken": refreshToken});
  }
}
