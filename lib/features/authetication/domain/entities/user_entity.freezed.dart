// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEntity {

 String get userId; String get displayName; String get email; String? get phoneNumber; String? get profilePhotoUrl; String? get languagePreference; List<String>? get interests;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.languagePreference, languagePreference) || other.languagePreference == languagePreference)&&const DeepCollectionEquality().equals(other.interests, interests));
}


@override
int get hashCode => Object.hash(runtimeType,userId,displayName,email,phoneNumber,profilePhotoUrl,languagePreference,const DeepCollectionEquality().hash(interests));

@override
String toString() {
  return 'UserEntity(userId: $userId, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, profilePhotoUrl: $profilePhotoUrl, languagePreference: $languagePreference, interests: $interests)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 String userId, String displayName, String email, String? phoneNumber, String? profilePhotoUrl, String? languagePreference, List<String>? interests
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? displayName = null,Object? email = null,Object? phoneNumber = freezed,Object? profilePhotoUrl = freezed,Object? languagePreference = freezed,Object? interests = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,languagePreference: freezed == languagePreference ? _self.languagePreference : languagePreference // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String displayName,  String email,  String? phoneNumber,  String? profilePhotoUrl,  String? languagePreference,  List<String>? interests)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.userId,_that.displayName,_that.email,_that.phoneNumber,_that.profilePhotoUrl,_that.languagePreference,_that.interests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String displayName,  String email,  String? phoneNumber,  String? profilePhotoUrl,  String? languagePreference,  List<String>? interests)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.userId,_that.displayName,_that.email,_that.phoneNumber,_that.profilePhotoUrl,_that.languagePreference,_that.interests);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String displayName,  String email,  String? phoneNumber,  String? profilePhotoUrl,  String? languagePreference,  List<String>? interests)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.userId,_that.displayName,_that.email,_that.phoneNumber,_that.profilePhotoUrl,_that.languagePreference,_that.interests);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity implements UserEntity {
  const _UserEntity({required this.userId, required this.displayName, required this.email, this.phoneNumber, this.profilePhotoUrl, this.languagePreference, final  List<String>? interests}): _interests = interests;
  

@override final  String userId;
@override final  String displayName;
@override final  String email;
@override final  String? phoneNumber;
@override final  String? profilePhotoUrl;
@override final  String? languagePreference;
 final  List<String>? _interests;
@override List<String>? get interests {
  final value = _interests;
  if (value == null) return null;
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.profilePhotoUrl, profilePhotoUrl) || other.profilePhotoUrl == profilePhotoUrl)&&(identical(other.languagePreference, languagePreference) || other.languagePreference == languagePreference)&&const DeepCollectionEquality().equals(other._interests, _interests));
}


@override
int get hashCode => Object.hash(runtimeType,userId,displayName,email,phoneNumber,profilePhotoUrl,languagePreference,const DeepCollectionEquality().hash(_interests));

@override
String toString() {
  return 'UserEntity(userId: $userId, displayName: $displayName, email: $email, phoneNumber: $phoneNumber, profilePhotoUrl: $profilePhotoUrl, languagePreference: $languagePreference, interests: $interests)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 String userId, String displayName, String email, String? phoneNumber, String? profilePhotoUrl, String? languagePreference, List<String>? interests
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? displayName = null,Object? email = null,Object? phoneNumber = freezed,Object? profilePhotoUrl = freezed,Object? languagePreference = freezed,Object? interests = freezed,}) {
  return _then(_UserEntity(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,profilePhotoUrl: freezed == profilePhotoUrl ? _self.profilePhotoUrl : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,languagePreference: freezed == languagePreference ? _self.languagePreference : languagePreference // ignore: cast_nullable_to_non_nullable
as String?,interests: freezed == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
