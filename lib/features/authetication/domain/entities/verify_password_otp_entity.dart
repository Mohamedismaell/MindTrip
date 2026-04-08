import 'package:equatable/equatable.dart';

class VerifyPasswordOtpEntity extends Equatable {
  final String resetToken;

  const VerifyPasswordOtpEntity({required this.resetToken});

  @override
  List<Object?> get props => [resetToken];
}
