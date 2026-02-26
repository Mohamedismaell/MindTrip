import 'package:mindtrip/core/database/api/api_consumer.dart';

class UserRemoteDataSource {
  UserRemoteDataSource();
  // Future<UserModel> getCurrentUser() async {
  //   final userId = apiConsumer.auth.currentUser!.id;
  //   final response = await apiConsumer
  //       .from('profiles')
  //       .select()
  //       .eq('id', userId)
  //       .single();
  //   return UserModel.fromJsonMap(response);
  // }
}
