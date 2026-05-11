import 'package:dio/dio.dart';
import 'package:mindtrip/core/connections/result.dart';
import 'package:mindtrip/features/profile/domain/repositories/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository repository;

  DeleteAccountUseCase({required this.repository});

  Future<Result<void>> call({CancelToken? cancelToken}) {
    return repository.deleteAccount(cancelToken: cancelToken);
  }
}
