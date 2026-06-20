// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapSearchState {

// Autocomplete
 List<PlacePrediction> get autocompletePredictions; MapSearchStatus get autocompleteStatus; String? get autocompleteErrorMessage;// Place Details
 GooglePlaceEntity? get resolvedSearchPlace; MapSearchStatus get placeDetailsStatus; String? get placeDetailsErrorMessage;// Search Metadata
 String? get lastQuery;// Nearby (future)
 List<GooglePlaceEntity> get nearbyPlaces;
/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapSearchStateCopyWith<MapSearchState> get copyWith => _$MapSearchStateCopyWithImpl<MapSearchState>(this as MapSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapSearchState&&const DeepCollectionEquality().equals(other.autocompletePredictions, autocompletePredictions)&&(identical(other.autocompleteStatus, autocompleteStatus) || other.autocompleteStatus == autocompleteStatus)&&(identical(other.autocompleteErrorMessage, autocompleteErrorMessage) || other.autocompleteErrorMessage == autocompleteErrorMessage)&&(identical(other.resolvedSearchPlace, resolvedSearchPlace) || other.resolvedSearchPlace == resolvedSearchPlace)&&(identical(other.placeDetailsStatus, placeDetailsStatus) || other.placeDetailsStatus == placeDetailsStatus)&&(identical(other.placeDetailsErrorMessage, placeDetailsErrorMessage) || other.placeDetailsErrorMessage == placeDetailsErrorMessage)&&(identical(other.lastQuery, lastQuery) || other.lastQuery == lastQuery)&&const DeepCollectionEquality().equals(other.nearbyPlaces, nearbyPlaces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(autocompletePredictions),autocompleteStatus,autocompleteErrorMessage,resolvedSearchPlace,placeDetailsStatus,placeDetailsErrorMessage,lastQuery,const DeepCollectionEquality().hash(nearbyPlaces));

@override
String toString() {
  return 'MapSearchState(autocompletePredictions: $autocompletePredictions, autocompleteStatus: $autocompleteStatus, autocompleteErrorMessage: $autocompleteErrorMessage, resolvedSearchPlace: $resolvedSearchPlace, placeDetailsStatus: $placeDetailsStatus, placeDetailsErrorMessage: $placeDetailsErrorMessage, lastQuery: $lastQuery, nearbyPlaces: $nearbyPlaces)';
}


}

/// @nodoc
abstract mixin class $MapSearchStateCopyWith<$Res>  {
  factory $MapSearchStateCopyWith(MapSearchState value, $Res Function(MapSearchState) _then) = _$MapSearchStateCopyWithImpl;
@useResult
$Res call({
 List<PlacePrediction> autocompletePredictions, MapSearchStatus autocompleteStatus, String? autocompleteErrorMessage, GooglePlaceEntity? resolvedSearchPlace, MapSearchStatus placeDetailsStatus, String? placeDetailsErrorMessage, String? lastQuery, List<GooglePlaceEntity> nearbyPlaces
});




}
/// @nodoc
class _$MapSearchStateCopyWithImpl<$Res>
    implements $MapSearchStateCopyWith<$Res> {
  _$MapSearchStateCopyWithImpl(this._self, this._then);

  final MapSearchState _self;
  final $Res Function(MapSearchState) _then;

/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? autocompletePredictions = null,Object? autocompleteStatus = null,Object? autocompleteErrorMessage = freezed,Object? resolvedSearchPlace = freezed,Object? placeDetailsStatus = null,Object? placeDetailsErrorMessage = freezed,Object? lastQuery = freezed,Object? nearbyPlaces = null,}) {
  return _then(_self.copyWith(
autocompletePredictions: null == autocompletePredictions ? _self.autocompletePredictions : autocompletePredictions // ignore: cast_nullable_to_non_nullable
as List<PlacePrediction>,autocompleteStatus: null == autocompleteStatus ? _self.autocompleteStatus : autocompleteStatus // ignore: cast_nullable_to_non_nullable
as MapSearchStatus,autocompleteErrorMessage: freezed == autocompleteErrorMessage ? _self.autocompleteErrorMessage : autocompleteErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,resolvedSearchPlace: freezed == resolvedSearchPlace ? _self.resolvedSearchPlace : resolvedSearchPlace // ignore: cast_nullable_to_non_nullable
as GooglePlaceEntity?,placeDetailsStatus: null == placeDetailsStatus ? _self.placeDetailsStatus : placeDetailsStatus // ignore: cast_nullable_to_non_nullable
as MapSearchStatus,placeDetailsErrorMessage: freezed == placeDetailsErrorMessage ? _self.placeDetailsErrorMessage : placeDetailsErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastQuery: freezed == lastQuery ? _self.lastQuery : lastQuery // ignore: cast_nullable_to_non_nullable
as String?,nearbyPlaces: null == nearbyPlaces ? _self.nearbyPlaces : nearbyPlaces // ignore: cast_nullable_to_non_nullable
as List<GooglePlaceEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [MapSearchState].
extension MapSearchStatePatterns on MapSearchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapSearchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapSearchState value)  $default,){
final _that = this;
switch (_that) {
case _MapSearchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapSearchState value)?  $default,){
final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlacePrediction> autocompletePredictions,  MapSearchStatus autocompleteStatus,  String? autocompleteErrorMessage,  GooglePlaceEntity? resolvedSearchPlace,  MapSearchStatus placeDetailsStatus,  String? placeDetailsErrorMessage,  String? lastQuery,  List<GooglePlaceEntity> nearbyPlaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
return $default(_that.autocompletePredictions,_that.autocompleteStatus,_that.autocompleteErrorMessage,_that.resolvedSearchPlace,_that.placeDetailsStatus,_that.placeDetailsErrorMessage,_that.lastQuery,_that.nearbyPlaces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlacePrediction> autocompletePredictions,  MapSearchStatus autocompleteStatus,  String? autocompleteErrorMessage,  GooglePlaceEntity? resolvedSearchPlace,  MapSearchStatus placeDetailsStatus,  String? placeDetailsErrorMessage,  String? lastQuery,  List<GooglePlaceEntity> nearbyPlaces)  $default,) {final _that = this;
switch (_that) {
case _MapSearchState():
return $default(_that.autocompletePredictions,_that.autocompleteStatus,_that.autocompleteErrorMessage,_that.resolvedSearchPlace,_that.placeDetailsStatus,_that.placeDetailsErrorMessage,_that.lastQuery,_that.nearbyPlaces);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlacePrediction> autocompletePredictions,  MapSearchStatus autocompleteStatus,  String? autocompleteErrorMessage,  GooglePlaceEntity? resolvedSearchPlace,  MapSearchStatus placeDetailsStatus,  String? placeDetailsErrorMessage,  String? lastQuery,  List<GooglePlaceEntity> nearbyPlaces)?  $default,) {final _that = this;
switch (_that) {
case _MapSearchState() when $default != null:
return $default(_that.autocompletePredictions,_that.autocompleteStatus,_that.autocompleteErrorMessage,_that.resolvedSearchPlace,_that.placeDetailsStatus,_that.placeDetailsErrorMessage,_that.lastQuery,_that.nearbyPlaces);case _:
  return null;

}
}

}

/// @nodoc


class _MapSearchState extends MapSearchState {
  const _MapSearchState({final  List<PlacePrediction> autocompletePredictions = const [], this.autocompleteStatus = MapSearchStatus.initial, this.autocompleteErrorMessage, this.resolvedSearchPlace, this.placeDetailsStatus = MapSearchStatus.initial, this.placeDetailsErrorMessage, this.lastQuery, final  List<GooglePlaceEntity> nearbyPlaces = const []}): _autocompletePredictions = autocompletePredictions,_nearbyPlaces = nearbyPlaces,super._();
  

// Autocomplete
 final  List<PlacePrediction> _autocompletePredictions;
// Autocomplete
@override@JsonKey() List<PlacePrediction> get autocompletePredictions {
  if (_autocompletePredictions is EqualUnmodifiableListView) return _autocompletePredictions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_autocompletePredictions);
}

@override@JsonKey() final  MapSearchStatus autocompleteStatus;
@override final  String? autocompleteErrorMessage;
// Place Details
@override final  GooglePlaceEntity? resolvedSearchPlace;
@override@JsonKey() final  MapSearchStatus placeDetailsStatus;
@override final  String? placeDetailsErrorMessage;
// Search Metadata
@override final  String? lastQuery;
// Nearby (future)
 final  List<GooglePlaceEntity> _nearbyPlaces;
// Nearby (future)
@override@JsonKey() List<GooglePlaceEntity> get nearbyPlaces {
  if (_nearbyPlaces is EqualUnmodifiableListView) return _nearbyPlaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nearbyPlaces);
}


/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapSearchStateCopyWith<_MapSearchState> get copyWith => __$MapSearchStateCopyWithImpl<_MapSearchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapSearchState&&const DeepCollectionEquality().equals(other._autocompletePredictions, _autocompletePredictions)&&(identical(other.autocompleteStatus, autocompleteStatus) || other.autocompleteStatus == autocompleteStatus)&&(identical(other.autocompleteErrorMessage, autocompleteErrorMessage) || other.autocompleteErrorMessage == autocompleteErrorMessage)&&(identical(other.resolvedSearchPlace, resolvedSearchPlace) || other.resolvedSearchPlace == resolvedSearchPlace)&&(identical(other.placeDetailsStatus, placeDetailsStatus) || other.placeDetailsStatus == placeDetailsStatus)&&(identical(other.placeDetailsErrorMessage, placeDetailsErrorMessage) || other.placeDetailsErrorMessage == placeDetailsErrorMessage)&&(identical(other.lastQuery, lastQuery) || other.lastQuery == lastQuery)&&const DeepCollectionEquality().equals(other._nearbyPlaces, _nearbyPlaces));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_autocompletePredictions),autocompleteStatus,autocompleteErrorMessage,resolvedSearchPlace,placeDetailsStatus,placeDetailsErrorMessage,lastQuery,const DeepCollectionEquality().hash(_nearbyPlaces));

@override
String toString() {
  return 'MapSearchState(autocompletePredictions: $autocompletePredictions, autocompleteStatus: $autocompleteStatus, autocompleteErrorMessage: $autocompleteErrorMessage, resolvedSearchPlace: $resolvedSearchPlace, placeDetailsStatus: $placeDetailsStatus, placeDetailsErrorMessage: $placeDetailsErrorMessage, lastQuery: $lastQuery, nearbyPlaces: $nearbyPlaces)';
}


}

/// @nodoc
abstract mixin class _$MapSearchStateCopyWith<$Res> implements $MapSearchStateCopyWith<$Res> {
  factory _$MapSearchStateCopyWith(_MapSearchState value, $Res Function(_MapSearchState) _then) = __$MapSearchStateCopyWithImpl;
@override @useResult
$Res call({
 List<PlacePrediction> autocompletePredictions, MapSearchStatus autocompleteStatus, String? autocompleteErrorMessage, GooglePlaceEntity? resolvedSearchPlace, MapSearchStatus placeDetailsStatus, String? placeDetailsErrorMessage, String? lastQuery, List<GooglePlaceEntity> nearbyPlaces
});




}
/// @nodoc
class __$MapSearchStateCopyWithImpl<$Res>
    implements _$MapSearchStateCopyWith<$Res> {
  __$MapSearchStateCopyWithImpl(this._self, this._then);

  final _MapSearchState _self;
  final $Res Function(_MapSearchState) _then;

/// Create a copy of MapSearchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? autocompletePredictions = null,Object? autocompleteStatus = null,Object? autocompleteErrorMessage = freezed,Object? resolvedSearchPlace = freezed,Object? placeDetailsStatus = null,Object? placeDetailsErrorMessage = freezed,Object? lastQuery = freezed,Object? nearbyPlaces = null,}) {
  return _then(_MapSearchState(
autocompletePredictions: null == autocompletePredictions ? _self._autocompletePredictions : autocompletePredictions // ignore: cast_nullable_to_non_nullable
as List<PlacePrediction>,autocompleteStatus: null == autocompleteStatus ? _self.autocompleteStatus : autocompleteStatus // ignore: cast_nullable_to_non_nullable
as MapSearchStatus,autocompleteErrorMessage: freezed == autocompleteErrorMessage ? _self.autocompleteErrorMessage : autocompleteErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,resolvedSearchPlace: freezed == resolvedSearchPlace ? _self.resolvedSearchPlace : resolvedSearchPlace // ignore: cast_nullable_to_non_nullable
as GooglePlaceEntity?,placeDetailsStatus: null == placeDetailsStatus ? _self.placeDetailsStatus : placeDetailsStatus // ignore: cast_nullable_to_non_nullable
as MapSearchStatus,placeDetailsErrorMessage: freezed == placeDetailsErrorMessage ? _self.placeDetailsErrorMessage : placeDetailsErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,lastQuery: freezed == lastQuery ? _self.lastQuery : lastQuery // ignore: cast_nullable_to_non_nullable
as String?,nearbyPlaces: null == nearbyPlaces ? _self._nearbyPlaces : nearbyPlaces // ignore: cast_nullable_to_non_nullable
as List<GooglePlaceEntity>,
  ));
}


}

// dart format on
