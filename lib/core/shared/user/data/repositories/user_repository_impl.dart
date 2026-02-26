import 'package:mindtrip/core/shared/user/data/datasources/user_remote_data_source.dart';
import 'package:mindtrip/core/shared/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<Result<UserModel>> getCurrentUser() async {
  //   try {
  //     final user = await remoteDataSource.getCurrentUser();

  //     return Result.ok(user);
  //   } catch (e) {
  //     final error = ApiErrorMapper.fromException(e);
  //     return Result.error(error);
  //   }
  // }
}
