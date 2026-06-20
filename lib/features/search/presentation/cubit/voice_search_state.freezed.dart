// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VoiceSearchState {

 VoiceSearchStatus get status; String get transcript; String get errorMessage; bool get isFinalResult;
/// Create a copy of VoiceSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VoiceSearchStateCopyWith<VoiceSearchState> get copyWith => _$VoiceSearchStateCopyWithImpl<VoiceSearchState>(this as VoiceSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VoiceSearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.transcript, transcript) || other.transcript == transcript)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isFinalResult, isFinalResult) || other.isFinalResult == isFinalResult));
}


@override
int get hashCode => Object.hash(runtimeType,status,transcript,errorMessage,isFinalResult);

@override
String toString() {
  return 'VoiceSearchState(status: $status, transcript: $transcript, errorMessage: $errorMessage, isFinalResult: $isFinalResult)';
}


}

/// @nodoc
abstract mixin class $VoiceSearchStateCopyWith<$Res>  {
  factory $VoiceSearchStateCopyWith(VoiceSearchState value, $Res Function(VoiceSearchState) _then) = _$VoiceSearchStateCopyWithImpl;
@useResult
$Res call({
 VoiceSearchStatus status, String transcript, String errorMessage, bool isFinalResult
});




}
/// @nodoc
class _$VoiceSearchStateCopyWithImpl<$Res>
    implements $VoiceSearchStateCopyWith<$Res> {
  _$VoiceSearchStateCopyWithImpl(this._self, this._then);

  final VoiceSearchState _self;
  final $Res Function(VoiceSearchState) _then;

/// Create a copy of VoiceSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? transcript = null,Object? errorMessage = null,Object? isFinalResult = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoiceSearchStatus,transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isFinalResult: null == isFinalResult ? _self.isFinalResult : isFinalResult // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VoiceSearchState].
extension VoiceSearchStatePatterns on VoiceSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VoiceSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VoiceSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VoiceSearchState value)  $default,){
final _that = this;
switch (_that) {
case _VoiceSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VoiceSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _VoiceSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VoiceSearchStatus status,  String transcript,  String errorMessage,  bool isFinalResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VoiceSearchState() when $default != null:
return $default(_that.status,_that.transcript,_that.errorMessage,_that.isFinalResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VoiceSearchStatus status,  String transcript,  String errorMessage,  bool isFinalResult)  $default,) {final _that = this;
switch (_that) {
case _VoiceSearchState():
return $default(_that.status,_that.transcript,_that.errorMessage,_that.isFinalResult);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VoiceSearchStatus status,  String transcript,  String errorMessage,  bool isFinalResult)?  $default,) {final _that = this;
switch (_that) {
case _VoiceSearchState() when $default != null:
return $default(_that.status,_that.transcript,_that.errorMessage,_that.isFinalResult);case _:
  return null;

}
}

}

/// @nodoc


class _VoiceSearchState implements VoiceSearchState {
  const _VoiceSearchState({this.status = VoiceSearchStatus.idle, this.transcript = "", this.errorMessage = "", this.isFinalResult = false});
  

@override@JsonKey() final  VoiceSearchStatus status;
@override@JsonKey() final  String transcript;
@override@JsonKey() final  String errorMessage;
@override@JsonKey() final  bool isFinalResult;

/// Create a copy of VoiceSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VoiceSearchStateCopyWith<_VoiceSearchState> get copyWith => __$VoiceSearchStateCopyWithImpl<_VoiceSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VoiceSearchState&&(identical(other.status, status) || other.status == status)&&(identical(other.transcript, transcript) || other.transcript == transcript)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.isFinalResult, isFinalResult) || other.isFinalResult == isFinalResult));
}


@override
int get hashCode => Object.hash(runtimeType,status,transcript,errorMessage,isFinalResult);

@override
String toString() {
  return 'VoiceSearchState(status: $status, transcript: $transcript, errorMessage: $errorMessage, isFinalResult: $isFinalResult)';
}


}

/// @nodoc
abstract mixin class _$VoiceSearchStateCopyWith<$Res> implements $VoiceSearchStateCopyWith<$Res> {
  factory _$VoiceSearchStateCopyWith(_VoiceSearchState value, $Res Function(_VoiceSearchState) _then) = __$VoiceSearchStateCopyWithImpl;
@override @useResult
$Res call({
 VoiceSearchStatus status, String transcript, String errorMessage, bool isFinalResult
});




}
/// @nodoc
class __$VoiceSearchStateCopyWithImpl<$Res>
    implements _$VoiceSearchStateCopyWith<$Res> {
  __$VoiceSearchStateCopyWithImpl(this._self, this._then);

  final _VoiceSearchState _self;
  final $Res Function(_VoiceSearchState) _then;

/// Create a copy of VoiceSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? transcript = null,Object? errorMessage = null,Object? isFinalResult = null,}) {
  return _then(_VoiceSearchState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VoiceSearchStatus,transcript: null == transcript ? _self.transcript : transcript // ignore: cast_nullable_to_non_nullable
as String,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,isFinalResult: null == isFinalResult ? _self.isFinalResult : isFinalResult // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
