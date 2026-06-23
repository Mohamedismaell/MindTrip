// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlaceDetailsState {

 PlaceDetailsStatus get placeDetailsStatus; PlaceEntity? get place; PlaceEntity? get preview; String? get placeDetailsError; NearbyStatus get nearbyStatus; PaginationState<PlaceEntity> get nearbyPlaces; String? get nearbyError;
/// Create a copy of PlaceDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDetailsStateCopyWith<PlaceDetailsState> get copyWith => _$PlaceDetailsStateCopyWithImpl<PlaceDetailsState>(this as PlaceDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDetailsState&&(identical(other.placeDetailsStatus, placeDetailsStatus) || other.placeDetailsStatus == placeDetailsStatus)&&(identical(other.place, place) || other.place == place)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.placeDetailsError, placeDetailsError) || other.placeDetailsError == placeDetailsError)&&(identical(other.nearbyStatus, nearbyStatus) || other.nearbyStatus == nearbyStatus)&&(identical(other.nearbyPlaces, nearbyPlaces) || other.nearbyPlaces == nearbyPlaces)&&(identical(other.nearbyError, nearbyError) || other.nearbyError == nearbyError));
}


@override
int get hashCode => Object.hash(runtimeType,placeDetailsStatus,place,preview,placeDetailsError,nearbyStatus,nearbyPlaces,nearbyError);

@override
String toString() {
  return 'PlaceDetailsState(placeDetailsStatus: $placeDetailsStatus, place: $place, preview: $preview, placeDetailsError: $placeDetailsError, nearbyStatus: $nearbyStatus, nearbyPlaces: $nearbyPlaces, nearbyError: $nearbyError)';
}


}

/// @nodoc
abstract mixin class $PlaceDetailsStateCopyWith<$Res>  {
  factory $PlaceDetailsStateCopyWith(PlaceDetailsState value, $Res Function(PlaceDetailsState) _then) = _$PlaceDetailsStateCopyWithImpl;
@useResult
$Res call({
 PlaceDetailsStatus placeDetailsStatus, PlaceEntity? place, PlaceEntity? preview, String? placeDetailsError, NearbyStatus nearbyStatus, PaginationState<PlaceEntity> nearbyPlaces, String? nearbyError
});


$PaginationStateCopyWith<PlaceEntity, $Res> get nearbyPlaces;

}
/// @nodoc
class _$PlaceDetailsStateCopyWithImpl<$Res>
    implements $PlaceDetailsStateCopyWith<$Res> {
  _$PlaceDetailsStateCopyWithImpl(this._self, this._then);

  final PlaceDetailsState _self;
  final $Res Function(PlaceDetailsState) _then;

/// Create a copy of PlaceDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeDetailsStatus = null,Object? place = freezed,Object? preview = freezed,Object? placeDetailsError = freezed,Object? nearbyStatus = null,Object? nearbyPlaces = null,Object? nearbyError = freezed,}) {
  return _then(_self.copyWith(
placeDetailsStatus: null == placeDetailsStatus ? _self.placeDetailsStatus : placeDetailsStatus // ignore: cast_nullable_to_non_nullable
as PlaceDetailsStatus,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceEntity?,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as PlaceEntity?,placeDetailsError: freezed == placeDetailsError ? _self.placeDetailsError : placeDetailsError // ignore: cast_nullable_to_non_nullable
as String?,nearbyStatus: null == nearbyStatus ? _self.nearbyStatus : nearbyStatus // ignore: cast_nullable_to_non_nullable
as NearbyStatus,nearbyPlaces: null == nearbyPlaces ? _self.nearbyPlaces : nearbyPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,nearbyError: freezed == nearbyError ? _self.nearbyError : nearbyError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PlaceDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get nearbyPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.nearbyPlaces, (value) {
    return _then(_self.copyWith(nearbyPlaces: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceDetailsState].
extension PlaceDetailsStatePatterns on PlaceDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlaceDetailsStatus placeDetailsStatus,  PlaceEntity? place,  PlaceEntity? preview,  String? placeDetailsError,  NearbyStatus nearbyStatus,  PaginationState<PlaceEntity> nearbyPlaces,  String? nearbyError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDetailsState() when $default != null:
return $default(_that.placeDetailsStatus,_that.place,_that.preview,_that.placeDetailsError,_that.nearbyStatus,_that.nearbyPlaces,_that.nearbyError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlaceDetailsStatus placeDetailsStatus,  PlaceEntity? place,  PlaceEntity? preview,  String? placeDetailsError,  NearbyStatus nearbyStatus,  PaginationState<PlaceEntity> nearbyPlaces,  String? nearbyError)  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailsState():
return $default(_that.placeDetailsStatus,_that.place,_that.preview,_that.placeDetailsError,_that.nearbyStatus,_that.nearbyPlaces,_that.nearbyError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlaceDetailsStatus placeDetailsStatus,  PlaceEntity? place,  PlaceEntity? preview,  String? placeDetailsError,  NearbyStatus nearbyStatus,  PaginationState<PlaceEntity> nearbyPlaces,  String? nearbyError)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailsState() when $default != null:
return $default(_that.placeDetailsStatus,_that.place,_that.preview,_that.placeDetailsError,_that.nearbyStatus,_that.nearbyPlaces,_that.nearbyError);case _:
  return null;

}
}

}

/// @nodoc


class _PlaceDetailsState implements PlaceDetailsState {
  const _PlaceDetailsState({this.placeDetailsStatus = PlaceDetailsStatus.initial, this.place, this.preview, this.placeDetailsError, this.nearbyStatus = NearbyStatus.initial, this.nearbyPlaces = const PaginationState<PlaceEntity>(), this.nearbyError});
  

@override@JsonKey() final  PlaceDetailsStatus placeDetailsStatus;
@override final  PlaceEntity? place;
@override final  PlaceEntity? preview;
@override final  String? placeDetailsError;
@override@JsonKey() final  NearbyStatus nearbyStatus;
@override@JsonKey() final  PaginationState<PlaceEntity> nearbyPlaces;
@override final  String? nearbyError;

/// Create a copy of PlaceDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDetailsStateCopyWith<_PlaceDetailsState> get copyWith => __$PlaceDetailsStateCopyWithImpl<_PlaceDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDetailsState&&(identical(other.placeDetailsStatus, placeDetailsStatus) || other.placeDetailsStatus == placeDetailsStatus)&&(identical(other.place, place) || other.place == place)&&(identical(other.preview, preview) || other.preview == preview)&&(identical(other.placeDetailsError, placeDetailsError) || other.placeDetailsError == placeDetailsError)&&(identical(other.nearbyStatus, nearbyStatus) || other.nearbyStatus == nearbyStatus)&&(identical(other.nearbyPlaces, nearbyPlaces) || other.nearbyPlaces == nearbyPlaces)&&(identical(other.nearbyError, nearbyError) || other.nearbyError == nearbyError));
}


@override
int get hashCode => Object.hash(runtimeType,placeDetailsStatus,place,preview,placeDetailsError,nearbyStatus,nearbyPlaces,nearbyError);

@override
String toString() {
  return 'PlaceDetailsState(placeDetailsStatus: $placeDetailsStatus, place: $place, preview: $preview, placeDetailsError: $placeDetailsError, nearbyStatus: $nearbyStatus, nearbyPlaces: $nearbyPlaces, nearbyError: $nearbyError)';
}


}

/// @nodoc
abstract mixin class _$PlaceDetailsStateCopyWith<$Res> implements $PlaceDetailsStateCopyWith<$Res> {
  factory _$PlaceDetailsStateCopyWith(_PlaceDetailsState value, $Res Function(_PlaceDetailsState) _then) = __$PlaceDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 PlaceDetailsStatus placeDetailsStatus, PlaceEntity? place, PlaceEntity? preview, String? placeDetailsError, NearbyStatus nearbyStatus, PaginationState<PlaceEntity> nearbyPlaces, String? nearbyError
});


@override $PaginationStateCopyWith<PlaceEntity, $Res> get nearbyPlaces;

}
/// @nodoc
class __$PlaceDetailsStateCopyWithImpl<$Res>
    implements _$PlaceDetailsStateCopyWith<$Res> {
  __$PlaceDetailsStateCopyWithImpl(this._self, this._then);

  final _PlaceDetailsState _self;
  final $Res Function(_PlaceDetailsState) _then;

/// Create a copy of PlaceDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeDetailsStatus = null,Object? place = freezed,Object? preview = freezed,Object? placeDetailsError = freezed,Object? nearbyStatus = null,Object? nearbyPlaces = null,Object? nearbyError = freezed,}) {
  return _then(_PlaceDetailsState(
placeDetailsStatus: null == placeDetailsStatus ? _self.placeDetailsStatus : placeDetailsStatus // ignore: cast_nullable_to_non_nullable
as PlaceDetailsStatus,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceEntity?,preview: freezed == preview ? _self.preview : preview // ignore: cast_nullable_to_non_nullable
as PlaceEntity?,placeDetailsError: freezed == placeDetailsError ? _self.placeDetailsError : placeDetailsError // ignore: cast_nullable_to_non_nullable
as String?,nearbyStatus: null == nearbyStatus ? _self.nearbyStatus : nearbyStatus // ignore: cast_nullable_to_non_nullable
as NearbyStatus,nearbyPlaces: null == nearbyPlaces ? _self.nearbyPlaces : nearbyPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,nearbyError: freezed == nearbyError ? _self.nearbyError : nearbyError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PlaceDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get nearbyPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.nearbyPlaces, (value) {
    return _then(_self.copyWith(nearbyPlaces: value));
  });
}
}

// dart format on
