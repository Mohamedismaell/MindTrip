import 'package:mindtrip/core/database/api/api_consumer.dart';
import 'package:mindtrip/core/database/api/end_points.dart';
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
}
