// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {

 AuthStatus get status; UserEntity? get user; String? get errorMessage;// UI helpers
 bool get obscurePassword; bool get obscureConfirm; bool get rememberMe; OtpFlow get otpFlow; String? get email; String? get password; String? get resetToken;
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthStateCopyWith<AuthState> get copyWith => _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscureConfirm, obscureConfirm) || other.obscureConfirm == obscureConfirm)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.otpFlow, otpFlow) || other.otpFlow == otpFlow)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,errorMessage,obscurePassword,obscureConfirm,rememberMe,otpFlow,email,password,resetToken);

@override
String toString() {
  return 'AuthState(status: $status, user: $user, errorMessage: $errorMessage, obscurePassword: $obscurePassword, obscureConfirm: $obscureConfirm, rememberMe: $rememberMe, otpFlow: $otpFlow, email: $email, password: $password, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res>  {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) = _$AuthStateCopyWithImpl;
@useResult
$Res call({
 AuthStatus status, UserEntity? user, String? errorMessage, bool obscurePassword, bool obscureConfirm, bool rememberMe, OtpFlow otpFlow, String? email, String? password, String? resetToken
});


$UserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthStateCopyWithImpl<$Res>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? user = freezed,Object? errorMessage = freezed,Object? obscurePassword = null,Object? obscureConfirm = null,Object? rememberMe = null,Object? otpFlow = null,Object? email = freezed,Object? password = freezed,Object? resetToken = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirm: null == obscureConfirm ? _self.obscureConfirm : obscureConfirm // ignore: cast_nullable_to_non_nullable
as bool,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,otpFlow: null == otpFlow ? _self.otpFlow : otpFlow // ignore: cast_nullable_to_non_nullable
as OtpFlow,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthState value)  $default,){
final _that = this;
switch (_that) {
case _AuthState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthState value)?  $default,){
final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthStatus status,  UserEntity? user,  String? errorMessage,  bool obscurePassword,  bool obscureConfirm,  bool rememberMe,  OtpFlow otpFlow,  String? email,  String? password,  String? resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.user,_that.errorMessage,_that.obscurePassword,_that.obscureConfirm,_that.rememberMe,_that.otpFlow,_that.email,_that.password,_that.resetToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthStatus status,  UserEntity? user,  String? errorMessage,  bool obscurePassword,  bool obscureConfirm,  bool rememberMe,  OtpFlow otpFlow,  String? email,  String? password,  String? resetToken)  $default,) {final _that = this;
switch (_that) {
case _AuthState():
return $default(_that.status,_that.user,_that.errorMessage,_that.obscurePassword,_that.obscureConfirm,_that.rememberMe,_that.otpFlow,_that.email,_that.password,_that.resetToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthStatus status,  UserEntity? user,  String? errorMessage,  bool obscurePassword,  bool obscureConfirm,  bool rememberMe,  OtpFlow otpFlow,  String? email,  String? password,  String? resetToken)?  $default,) {final _that = this;
switch (_that) {
case _AuthState() when $default != null:
return $default(_that.status,_that.user,_that.errorMessage,_that.obscurePassword,_that.obscureConfirm,_that.rememberMe,_that.otpFlow,_that.email,_that.password,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc


class _AuthState implements AuthState {
  const _AuthState({this.status = AuthStatus.initial, this.user, this.errorMessage, this.obscurePassword = true, this.obscureConfirm = true, this.rememberMe = false, this.otpFlow = OtpFlow.forgetPassword, this.email, this.password, this.resetToken});
  

@override@JsonKey() final  AuthStatus status;
@override final  UserEntity? user;
@override final  String? errorMessage;
// UI helpers
@override@JsonKey() final  bool obscurePassword;
@override@JsonKey() final  bool obscureConfirm;
@override@JsonKey() final  bool rememberMe;
@override@JsonKey() final  OtpFlow otpFlow;
@override final  String? email;
@override final  String? password;
@override final  String? resetToken;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthStateCopyWith<_AuthState> get copyWith => __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthState&&(identical(other.status, status) || other.status == status)&&(identical(other.user, user) || other.user == user)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscureConfirm, obscureConfirm) || other.obscureConfirm == obscureConfirm)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe)&&(identical(other.otpFlow, otpFlow) || other.otpFlow == otpFlow)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode => Object.hash(runtimeType,status,user,errorMessage,obscurePassword,obscureConfirm,rememberMe,otpFlow,email,password,resetToken);

@override
String toString() {
  return 'AuthState(status: $status, user: $user, errorMessage: $errorMessage, obscurePassword: $obscurePassword, obscureConfirm: $obscureConfirm, rememberMe: $rememberMe, otpFlow: $otpFlow, email: $email, password: $password, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(_AuthState value, $Res Function(_AuthState) _then) = __$AuthStateCopyWithImpl;
@override @useResult
$Res call({
 AuthStatus status, UserEntity? user, String? errorMessage, bool obscurePassword, bool obscureConfirm, bool rememberMe, OtpFlow otpFlow, String? email, String? password, String? resetToken
});


@override $UserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class __$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? user = freezed,Object? errorMessage = freezed,Object? obscurePassword = null,Object? obscureConfirm = null,Object? rememberMe = null,Object? otpFlow = null,Object? email = freezed,Object? password = freezed,Object? resetToken = freezed,}) {
  return _then(_AuthState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AuthStatus,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirm: null == obscureConfirm ? _self.obscureConfirm : obscureConfirm // ignore: cast_nullable_to_non_nullable
as bool,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,otpFlow: null == otpFlow ? _self.otpFlow : otpFlow // ignore: cast_nullable_to_non_nullable
as OtpFlow,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
