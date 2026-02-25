abstract class Failure {
  final String message;
  final String? debugMessage;
  const Failure(this.message, {this.debugMessage});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message, String? debugMessage})
    : super(message, debugMessage: debugMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.debugMessage});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String? message, String? debugMessage})
    : super(message ?? 'Unauthorized access', debugMessage: debugMessage);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? debugMessage})
    : super('Something went wrong', debugMessage: debugMessage);
}
