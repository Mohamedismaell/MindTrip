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

  Future<String> uploadProfilePhoto(String filePath) async {
    print(' profile photo ******* ===>${filePath}}');
    final formDataMap = {
      'file': await MultipartFile.fromFile(
        filePath,
        filename: 'profile_photo.webp',
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

  Future<void> updateProfile({String? displayName, String? phoneNumber}) async {
    final data = <String, dynamic>{};
    if (displayName != null) data['displayName'] = displayName;
    if (phoneNumber != null) data['phoneNumber'] = phoneNumber;

    await _api.patch(EndPoints.updateProfile, data: data);
  }
}
