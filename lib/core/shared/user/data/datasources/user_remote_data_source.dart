import 'package:dio/dio.dart';
import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
import 'package:mindtrip/core/shared/user/data/models/upload_photo_response.dart';
import 'package:mindtrip/core/shared/user/data/models/user_model.dart';

class UserRemoteDataSource {
  final ApiConsumer _api;

  UserRemoteDataSource({required ApiConsumer api}) : _api = api;

  Future<UserModel> getCurrentUser() async {
    final response = await _api.get(EndPoints.getCurrentUser);
    return UserModel.fromJson(response as Map<String, dynamic>);
  }

  Future<void> updateInterests(List<String> interests) async {
    await _api.put(EndPoints.insertInterests, data: {'interests': interests});
  }

  /// Uploads a profile photo as multipart form-data.
  /// Returns the CDN URL from the backend response.
  Future<String> uploadProfilePhoto(String filePath) async {
    final formDataMap = {
      'file': await MultipartFile.fromFile(
        filePath,
        filename: 'profile_photo.jpg',
      ),
    };

    final response = await _api.post(
      EndPoints.uploadPhoto,
      data: formDataMap,
      isFormData: true,
    );

    final parsed = UploadPhotoResponse.fromJson(response);
    return parsed.url;
  }
}
