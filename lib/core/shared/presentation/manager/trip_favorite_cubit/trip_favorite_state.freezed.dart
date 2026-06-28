// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_favorite_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripFavoriteState {

 Set<String> get favoriteTripIds; List<FavoriteTripEntity> get favoriteTrips; FavoritesStatus get status; String? get errorMessage;
/// Create a copy of TripFavoriteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripFavoriteStateCopyWith<TripFavoriteState> get copyWith => _$TripFavoriteStateCopyWithImpl<TripFavoriteState>(this as TripFavoriteState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripFavoriteState&&const DeepCollectionEquality().equals(other.favoriteTripIds, favoriteTripIds)&&const DeepCollectionEquality().equals(other.favoriteTrips, favoriteTrips)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(favoriteTripIds),const DeepCollectionEquality().hash(favoriteTrips),status,errorMessage);

@override
String toString() {
  return 'TripFavoriteState(favoriteTripIds: $favoriteTripIds, favoriteTrips: $favoriteTrips, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TripFavoriteStateCopyWith<$Res>  {
  factory $TripFavoriteStateCopyWith(TripFavoriteState value, $Res Function(TripFavoriteState) _then) = _$TripFavoriteStateCopyWithImpl;
@useResult
$Res call({
 Set<String> favoriteTripIds, List<FavoriteTripEntity> favoriteTrips, FavoritesStatus status, String? errorMessage
});




}
/// @nodoc
class _$TripFavoriteStateCopyWithImpl<$Res>
    implements $TripFavoriteStateCopyWith<$Res> {
  _$TripFavoriteStateCopyWithImpl(this._self, this._then);

  final TripFavoriteState _self;
  final $Res Function(TripFavoriteState) _then;

/// Create a copy of TripFavoriteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favoriteTripIds = null,Object? favoriteTrips = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
favoriteTripIds: null == favoriteTripIds ? _self.favoriteTripIds : favoriteTripIds // ignore: cast_nullable_to_non_nullable
as Set<String>,favoriteTrips: null == favoriteTrips ? _self.favoriteTrips : favoriteTrips // ignore: cast_nullable_to_non_nullable
as List<FavoriteTripEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FavoritesStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripFavoriteState].
extension TripFavoriteStatePatterns on TripFavoriteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripFavoriteState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripFavoriteState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripFavoriteState value)  $default,){
final _that = this;
switch (_that) {
case _TripFavoriteState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripFavoriteState value)?  $default,){
final _that = this;
switch (_that) {
case _TripFavoriteState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<String> favoriteTripIds,  List<FavoriteTripEntity> favoriteTrips,  FavoritesStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripFavoriteState() when $default != null:
return $default(_that.favoriteTripIds,_that.favoriteTrips,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<String> favoriteTripIds,  List<FavoriteTripEntity> favoriteTrips,  FavoritesStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TripFavoriteState():
return $default(_that.favoriteTripIds,_that.favoriteTrips,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<String> favoriteTripIds,  List<FavoriteTripEntity> favoriteTrips,  FavoritesStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TripFavoriteState() when $default != null:
return $default(_that.favoriteTripIds,_that.favoriteTrips,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TripFavoriteState implements TripFavoriteState {
  const _TripFavoriteState({final  Set<String> favoriteTripIds = const <String>{}, final  List<FavoriteTripEntity> favoriteTrips = const <FavoriteTripEntity>[], this.status = FavoritesStatus.initial, this.errorMessage}): _favoriteTripIds = favoriteTripIds,_favoriteTrips = favoriteTrips;
  

 final  Set<String> _favoriteTripIds;
@override@JsonKey() Set<String> get favoriteTripIds {
  if (_favoriteTripIds is EqualUnmodifiableSetView) return _favoriteTripIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_favoriteTripIds);
}

 final  List<FavoriteTripEntity> _favoriteTrips;
@override@JsonKey() List<FavoriteTripEntity> get favoriteTrips {
  if (_favoriteTrips is EqualUnmodifiableListView) return _favoriteTrips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteTrips);
}

@override@JsonKey() final  FavoritesStatus status;
@override final  String? errorMessage;

/// Create a copy of TripFavoriteState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripFavoriteStateCopyWith<_TripFavoriteState> get copyWith => __$TripFavoriteStateCopyWithImpl<_TripFavoriteState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripFavoriteState&&const DeepCollectionEquality().equals(other._favoriteTripIds, _favoriteTripIds)&&const DeepCollectionEquality().equals(other._favoriteTrips, _favoriteTrips)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favoriteTripIds),const DeepCollectionEquality().hash(_favoriteTrips),status,errorMessage);

@override
String toString() {
  return 'TripFavoriteState(favoriteTripIds: $favoriteTripIds, favoriteTrips: $favoriteTrips, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TripFavoriteStateCopyWith<$Res> implements $TripFavoriteStateCopyWith<$Res> {
  factory _$TripFavoriteStateCopyWith(_TripFavoriteState value, $Res Function(_TripFavoriteState) _then) = __$TripFavoriteStateCopyWithImpl;
@override @useResult
$Res call({
 Set<String> favoriteTripIds, List<FavoriteTripEntity> favoriteTrips, FavoritesStatus status, String? errorMessage
});




}
/// @nodoc
class __$TripFavoriteStateCopyWithImpl<$Res>
    implements _$TripFavoriteStateCopyWith<$Res> {
  __$TripFavoriteStateCopyWithImpl(this._self, this._then);

  final _TripFavoriteState _self;
  final $Res Function(_TripFavoriteState) _then;

/// Create a copy of TripFavoriteState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favoriteTripIds = null,Object? favoriteTrips = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_TripFavoriteState(
favoriteTripIds: null == favoriteTripIds ? _self._favoriteTripIds : favoriteTripIds // ignore: cast_nullable_to_non_nullable
as Set<String>,favoriteTrips: null == favoriteTrips ? _self._favoriteTrips : favoriteTrips // ignore: cast_nullable_to_non_nullable
as List<FavoriteTripEntity>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FavoritesStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
