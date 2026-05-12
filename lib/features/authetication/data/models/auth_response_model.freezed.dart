// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthResponseModel {

 UserModel get user; String get accessToken; String get refreshToken; String get tokenType; int get expiresIn; bool get isEmailVerified; bool get twoFactorEnabled;
/// Create a copy of AuthResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResponseModelCopyWith<AuthResponseModel> get copyWith => _$AuthResponseModelCopyWithImpl<AuthResponseModel>(this as AuthResponseModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResponseModel&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.twoFactorEnabled, twoFactorEnabled) || other.twoFactorEnabled == twoFactorEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken,tokenType,expiresIn,isEmailVerified,twoFactorEnabled);

@override
String toString() {
  return 'AuthResponseModel(user: $user, accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn, isEmailVerified: $isEmailVerified, twoFactorEnabled: $twoFactorEnabled)';
}


}

/// @nodoc
abstract mixin class $AuthResponseModelCopyWith<$Res>  {
  factory $AuthResponseModelCopyWith(AuthResponseModel value, $Res Function(AuthResponseModel) _then) = _$AuthResponseModelCopyWithImpl;
@useResult
$Res call({
 UserModel user, String accessToken, String refreshToken, String tokenType, int expiresIn, bool isEmailVerified, bool twoFactorEnabled
});


$UserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthResponseModelCopyWithImpl<$Res>
    implements $AuthResponseModelCopyWith<$Res> {
  _$AuthResponseModelCopyWithImpl(this._self, this._then);

  final AuthResponseModel _self;
  final $Res Function(AuthResponseModel) _then;

/// Create a copy of AuthResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? accessToken = null,Object? refreshToken = null,Object? tokenType = null,Object? expiresIn = null,Object? isEmailVerified = null,Object? twoFactorEnabled = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,twoFactorEnabled: null == twoFactorEnabled ? _self.twoFactorEnabled : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of AuthResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResponseModel].
extension AuthResponseModelPatterns on AuthResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _AuthResponseModel():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserModel user,  String accessToken,  String refreshToken,  String tokenType,  int expiresIn,  bool isEmailVerified,  bool twoFactorEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResponseModel() when $default != null:
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.isEmailVerified,_that.twoFactorEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserModel user,  String accessToken,  String refreshToken,  String tokenType,  int expiresIn,  bool isEmailVerified,  bool twoFactorEnabled)  $default,) {final _that = this;
switch (_that) {
case _AuthResponseModel():
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.isEmailVerified,_that.twoFactorEnabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserModel user,  String accessToken,  String refreshToken,  String tokenType,  int expiresIn,  bool isEmailVerified,  bool twoFactorEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AuthResponseModel() when $default != null:
return $default(_that.user,_that.accessToken,_that.refreshToken,_that.tokenType,_that.expiresIn,_that.isEmailVerified,_that.twoFactorEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _AuthResponseModel extends AuthResponseModel {
  const _AuthResponseModel({required this.user, required this.accessToken, required this.refreshToken, this.tokenType = 'Bearer', this.expiresIn = 0, this.isEmailVerified = false, this.twoFactorEnabled = false}): super._();
  

@override final  UserModel user;
@override final  String accessToken;
@override final  String refreshToken;
@override@JsonKey() final  String tokenType;
@override@JsonKey() final  int expiresIn;
@override@JsonKey() final  bool isEmailVerified;
@override@JsonKey() final  bool twoFactorEnabled;

/// Create a copy of AuthResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResponseModelCopyWith<_AuthResponseModel> get copyWith => __$AuthResponseModelCopyWithImpl<_AuthResponseModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResponseModel&&(identical(other.user, user) || other.user == user)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenType, tokenType) || other.tokenType == tokenType)&&(identical(other.expiresIn, expiresIn) || other.expiresIn == expiresIn)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.twoFactorEnabled, twoFactorEnabled) || other.twoFactorEnabled == twoFactorEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,user,accessToken,refreshToken,tokenType,expiresIn,isEmailVerified,twoFactorEnabled);

@override
String toString() {
  return 'AuthResponseModel(user: $user, accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expiresIn: $expiresIn, isEmailVerified: $isEmailVerified, twoFactorEnabled: $twoFactorEnabled)';
}


}

/// @nodoc
abstract mixin class _$AuthResponseModelCopyWith<$Res> implements $AuthResponseModelCopyWith<$Res> {
  factory _$AuthResponseModelCopyWith(_AuthResponseModel value, $Res Function(_AuthResponseModel) _then) = __$AuthResponseModelCopyWithImpl;
@override @useResult
$Res call({
 UserModel user, String accessToken, String refreshToken, String tokenType, int expiresIn, bool isEmailVerified, bool twoFactorEnabled
});


@override $UserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthResponseModelCopyWithImpl<$Res>
    implements _$AuthResponseModelCopyWith<$Res> {
  __$AuthResponseModelCopyWithImpl(this._self, this._then);

  final _AuthResponseModel _self;
  final $Res Function(_AuthResponseModel) _then;

/// Create a copy of AuthResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? accessToken = null,Object? refreshToken = null,Object? tokenType = null,Object? expiresIn = null,Object? isEmailVerified = null,Object? twoFactorEnabled = null,}) {
  return _then(_AuthResponseModel(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,tokenType: null == tokenType ? _self.tokenType : tokenType // ignore: cast_nullable_to_non_nullable
as String,expiresIn: null == expiresIn ? _self.expiresIn : expiresIn // ignore: cast_nullable_to_non_nullable
as int,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,twoFactorEnabled: null == twoFactorEnabled ? _self.twoFactorEnabled : twoFactorEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of AuthResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get user {
  
  return $UserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
