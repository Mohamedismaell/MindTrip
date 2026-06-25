// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileState {

 UserEntity? get originalUser; String? get pendingPhotoPath; String get draftDisplayName; String get draftPhoneNumber; String get draftBio; EditSaveStatus get saveStatus; String? get editErrorMessage; DeleteAccountStatus get deleteStatus; String? get deleteErrorMessage;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.originalUser, originalUser) || other.originalUser == originalUser)&&(identical(other.pendingPhotoPath, pendingPhotoPath) || other.pendingPhotoPath == pendingPhotoPath)&&(identical(other.draftDisplayName, draftDisplayName) || other.draftDisplayName == draftDisplayName)&&(identical(other.draftPhoneNumber, draftPhoneNumber) || other.draftPhoneNumber == draftPhoneNumber)&&(identical(other.draftBio, draftBio) || other.draftBio == draftBio)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.editErrorMessage, editErrorMessage) || other.editErrorMessage == editErrorMessage)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.deleteErrorMessage, deleteErrorMessage) || other.deleteErrorMessage == deleteErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,originalUser,pendingPhotoPath,draftDisplayName,draftPhoneNumber,draftBio,saveStatus,editErrorMessage,deleteStatus,deleteErrorMessage);

@override
String toString() {
  return 'EditProfileState(originalUser: $originalUser, pendingPhotoPath: $pendingPhotoPath, draftDisplayName: $draftDisplayName, draftPhoneNumber: $draftPhoneNumber, draftBio: $draftBio, saveStatus: $saveStatus, editErrorMessage: $editErrorMessage, deleteStatus: $deleteStatus, deleteErrorMessage: $deleteErrorMessage)';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 UserEntity? originalUser, String? pendingPhotoPath, String draftDisplayName, String draftPhoneNumber, String draftBio, EditSaveStatus saveStatus, String? editErrorMessage, DeleteAccountStatus deleteStatus, String? deleteErrorMessage
});


$UserEntityCopyWith<$Res>? get originalUser;

}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? originalUser = freezed,Object? pendingPhotoPath = freezed,Object? draftDisplayName = null,Object? draftPhoneNumber = null,Object? draftBio = null,Object? saveStatus = null,Object? editErrorMessage = freezed,Object? deleteStatus = null,Object? deleteErrorMessage = freezed,}) {
  return _then(_self.copyWith(
originalUser: freezed == originalUser ? _self.originalUser : originalUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,pendingPhotoPath: freezed == pendingPhotoPath ? _self.pendingPhotoPath : pendingPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,draftDisplayName: null == draftDisplayName ? _self.draftDisplayName : draftDisplayName // ignore: cast_nullable_to_non_nullable
as String,draftPhoneNumber: null == draftPhoneNumber ? _self.draftPhoneNumber : draftPhoneNumber // ignore: cast_nullable_to_non_nullable
as String,draftBio: null == draftBio ? _self.draftBio : draftBio // ignore: cast_nullable_to_non_nullable
as String,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as EditSaveStatus,editErrorMessage: freezed == editErrorMessage ? _self.editErrorMessage : editErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as DeleteAccountStatus,deleteErrorMessage: freezed == deleteErrorMessage ? _self.deleteErrorMessage : deleteErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get originalUser {
    if (_self.originalUser == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.originalUser!, (value) {
    return _then(_self.copyWith(originalUser: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditProfileState value)  $default,){
final _that = this;
switch (_that) {
case _EditProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserEntity? originalUser,  String? pendingPhotoPath,  String draftDisplayName,  String draftPhoneNumber,  String draftBio,  EditSaveStatus saveStatus,  String? editErrorMessage,  DeleteAccountStatus deleteStatus,  String? deleteErrorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.originalUser,_that.pendingPhotoPath,_that.draftDisplayName,_that.draftPhoneNumber,_that.draftBio,_that.saveStatus,_that.editErrorMessage,_that.deleteStatus,_that.deleteErrorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserEntity? originalUser,  String? pendingPhotoPath,  String draftDisplayName,  String draftPhoneNumber,  String draftBio,  EditSaveStatus saveStatus,  String? editErrorMessage,  DeleteAccountStatus deleteStatus,  String? deleteErrorMessage)  $default,) {final _that = this;
switch (_that) {
case _EditProfileState():
return $default(_that.originalUser,_that.pendingPhotoPath,_that.draftDisplayName,_that.draftPhoneNumber,_that.draftBio,_that.saveStatus,_that.editErrorMessage,_that.deleteStatus,_that.deleteErrorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserEntity? originalUser,  String? pendingPhotoPath,  String draftDisplayName,  String draftPhoneNumber,  String draftBio,  EditSaveStatus saveStatus,  String? editErrorMessage,  DeleteAccountStatus deleteStatus,  String? deleteErrorMessage)?  $default,) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.originalUser,_that.pendingPhotoPath,_that.draftDisplayName,_that.draftPhoneNumber,_that.draftBio,_that.saveStatus,_that.editErrorMessage,_that.deleteStatus,_that.deleteErrorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _EditProfileState extends EditProfileState {
  const _EditProfileState({this.originalUser, this.pendingPhotoPath, this.draftDisplayName = '', this.draftPhoneNumber = '', this.draftBio = '', this.saveStatus = EditSaveStatus.idle, this.editErrorMessage, this.deleteStatus = DeleteAccountStatus.idle, this.deleteErrorMessage}): super._();
  

@override final  UserEntity? originalUser;
@override final  String? pendingPhotoPath;
@override@JsonKey() final  String draftDisplayName;
@override@JsonKey() final  String draftPhoneNumber;
@override@JsonKey() final  String draftBio;
@override@JsonKey() final  EditSaveStatus saveStatus;
@override final  String? editErrorMessage;
@override@JsonKey() final  DeleteAccountStatus deleteStatus;
@override final  String? deleteErrorMessage;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfileStateCopyWith<_EditProfileState> get copyWith => __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfileState&&(identical(other.originalUser, originalUser) || other.originalUser == originalUser)&&(identical(other.pendingPhotoPath, pendingPhotoPath) || other.pendingPhotoPath == pendingPhotoPath)&&(identical(other.draftDisplayName, draftDisplayName) || other.draftDisplayName == draftDisplayName)&&(identical(other.draftPhoneNumber, draftPhoneNumber) || other.draftPhoneNumber == draftPhoneNumber)&&(identical(other.draftBio, draftBio) || other.draftBio == draftBio)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.editErrorMessage, editErrorMessage) || other.editErrorMessage == editErrorMessage)&&(identical(other.deleteStatus, deleteStatus) || other.deleteStatus == deleteStatus)&&(identical(other.deleteErrorMessage, deleteErrorMessage) || other.deleteErrorMessage == deleteErrorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,originalUser,pendingPhotoPath,draftDisplayName,draftPhoneNumber,draftBio,saveStatus,editErrorMessage,deleteStatus,deleteErrorMessage);

@override
String toString() {
  return 'EditProfileState(originalUser: $originalUser, pendingPhotoPath: $pendingPhotoPath, draftDisplayName: $draftDisplayName, draftPhoneNumber: $draftPhoneNumber, draftBio: $draftBio, saveStatus: $saveStatus, editErrorMessage: $editErrorMessage, deleteStatus: $deleteStatus, deleteErrorMessage: $deleteErrorMessage)';
}


}

/// @nodoc
abstract mixin class _$EditProfileStateCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(_EditProfileState value, $Res Function(_EditProfileState) _then) = __$EditProfileStateCopyWithImpl;
@override @useResult
$Res call({
 UserEntity? originalUser, String? pendingPhotoPath, String draftDisplayName, String draftPhoneNumber, String draftBio, EditSaveStatus saveStatus, String? editErrorMessage, DeleteAccountStatus deleteStatus, String? deleteErrorMessage
});


@override $UserEntityCopyWith<$Res>? get originalUser;

}
/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(this._self, this._then);

  final _EditProfileState _self;
  final $Res Function(_EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? originalUser = freezed,Object? pendingPhotoPath = freezed,Object? draftDisplayName = null,Object? draftPhoneNumber = null,Object? draftBio = null,Object? saveStatus = null,Object? editErrorMessage = freezed,Object? deleteStatus = null,Object? deleteErrorMessage = freezed,}) {
  return _then(_EditProfileState(
originalUser: freezed == originalUser ? _self.originalUser : originalUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,pendingPhotoPath: freezed == pendingPhotoPath ? _self.pendingPhotoPath : pendingPhotoPath // ignore: cast_nullable_to_non_nullable
as String?,draftDisplayName: null == draftDisplayName ? _self.draftDisplayName : draftDisplayName // ignore: cast_nullable_to_non_nullable
as String,draftPhoneNumber: null == draftPhoneNumber ? _self.draftPhoneNumber : draftPhoneNumber // ignore: cast_nullable_to_non_nullable
as String,draftBio: null == draftBio ? _self.draftBio : draftBio // ignore: cast_nullable_to_non_nullable
as String,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as EditSaveStatus,editErrorMessage: freezed == editErrorMessage ? _self.editErrorMessage : editErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,deleteStatus: null == deleteStatus ? _self.deleteStatus : deleteStatus // ignore: cast_nullable_to_non_nullable
as DeleteAccountStatus,deleteErrorMessage: freezed == deleteErrorMessage ? _self.deleteErrorMessage : deleteErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get originalUser {
    if (_self.originalUser == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.originalUser!, (value) {
    return _then(_self.copyWith(originalUser: value));
  });
}
}

// dart format on
