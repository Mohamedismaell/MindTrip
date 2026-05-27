import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/enums/auth_status.dart';
import 'package:mindtrip/core/enums/otp_flow.dart';
import 'package:mindtrip/features/authetication/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    UserEntity? user,
    String? errorMessage,

    // UI helpers
    @Default(true) bool obscurePassword,
    @Default(true) bool obscureConfirm,
    @Default(false) bool rememberMe,

    @Default(OtpFlow.forgetPassword) OtpFlow otpFlow,
    String? email,
    String? password,
    String? resetToken,
  }) = _AuthState;
}
