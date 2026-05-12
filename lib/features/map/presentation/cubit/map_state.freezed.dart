// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapState {

 List<MapAnnotationEntry> get annotations; PlaceModel? get selectedPlace; GooglePlaceEntity? get selectedGooglePlace; List<String> get selectedPlacePhotoUrls; bool get isBottomSheetVisible; bool get isLocationGranted; bool get clearSelectedPlace; bool get clearSelectedGooglePlace; bool get clearFlyToLocation; double? get flyToLat; double? get flyToLng;
/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapStateCopyWith<MapState> get copyWith => _$MapStateCopyWithImpl<MapState>(this as MapState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapState&&const DeepCollectionEquality().equals(other.annotations, annotations)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.selectedGooglePlace, selectedGooglePlace) || other.selectedGooglePlace == selectedGooglePlace)&&const DeepCollectionEquality().equals(other.selectedPlacePhotoUrls, selectedPlacePhotoUrls)&&(identical(other.isBottomSheetVisible, isBottomSheetVisible) || other.isBottomSheetVisible == isBottomSheetVisible)&&(identical(other.isLocationGranted, isLocationGranted) || other.isLocationGranted == isLocationGranted)&&(identical(other.clearSelectedPlace, clearSelectedPlace) || other.clearSelectedPlace == clearSelectedPlace)&&(identical(other.clearSelectedGooglePlace, clearSelectedGooglePlace) || other.clearSelectedGooglePlace == clearSelectedGooglePlace)&&(identical(other.clearFlyToLocation, clearFlyToLocation) || other.clearFlyToLocation == clearFlyToLocation)&&(identical(other.flyToLat, flyToLat) || other.flyToLat == flyToLat)&&(identical(other.flyToLng, flyToLng) || other.flyToLng == flyToLng));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(annotations),selectedPlace,selectedGooglePlace,const DeepCollectionEquality().hash(selectedPlacePhotoUrls),isBottomSheetVisible,isLocationGranted,clearSelectedPlace,clearSelectedGooglePlace,clearFlyToLocation,flyToLat,flyToLng);

@override
String toString() {
  return 'MapState(annotations: $annotations, selectedPlace: $selectedPlace, selectedGooglePlace: $selectedGooglePlace, selectedPlacePhotoUrls: $selectedPlacePhotoUrls, isBottomSheetVisible: $isBottomSheetVisible, isLocationGranted: $isLocationGranted, clearSelectedPlace: $clearSelectedPlace, clearSelectedGooglePlace: $clearSelectedGooglePlace, clearFlyToLocation: $clearFlyToLocation, flyToLat: $flyToLat, flyToLng: $flyToLng)';
}


}

/// @nodoc
abstract mixin class $MapStateCopyWith<$Res>  {
  factory $MapStateCopyWith(MapState value, $Res Function(MapState) _then) = _$MapStateCopyWithImpl;
@useResult
$Res call({
 List<MapAnnotationEntry> annotations, PlaceModel? selectedPlace, GooglePlaceEntity? selectedGooglePlace, List<String> selectedPlacePhotoUrls, bool isBottomSheetVisible, bool isLocationGranted, bool clearSelectedPlace, bool clearSelectedGooglePlace, bool clearFlyToLocation, double? flyToLat, double? flyToLng
});




}
/// @nodoc
class _$MapStateCopyWithImpl<$Res>
    implements $MapStateCopyWith<$Res> {
  _$MapStateCopyWithImpl(this._self, this._then);

  final MapState _self;
  final $Res Function(MapState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? annotations = null,Object? selectedPlace = freezed,Object? selectedGooglePlace = freezed,Object? selectedPlacePhotoUrls = null,Object? isBottomSheetVisible = null,Object? isLocationGranted = null,Object? clearSelectedPlace = null,Object? clearSelectedGooglePlace = null,Object? clearFlyToLocation = null,Object? flyToLat = freezed,Object? flyToLng = freezed,}) {
  return _then(_self.copyWith(
annotations: null == annotations ? _self.annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<MapAnnotationEntry>,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as PlaceModel?,selectedGooglePlace: freezed == selectedGooglePlace ? _self.selectedGooglePlace : selectedGooglePlace // ignore: cast_nullable_to_non_nullable
as GooglePlaceEntity?,selectedPlacePhotoUrls: null == selectedPlacePhotoUrls ? _self.selectedPlacePhotoUrls : selectedPlacePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isBottomSheetVisible: null == isBottomSheetVisible ? _self.isBottomSheetVisible : isBottomSheetVisible // ignore: cast_nullable_to_non_nullable
as bool,isLocationGranted: null == isLocationGranted ? _self.isLocationGranted : isLocationGranted // ignore: cast_nullable_to_non_nullable
as bool,clearSelectedPlace: null == clearSelectedPlace ? _self.clearSelectedPlace : clearSelectedPlace // ignore: cast_nullable_to_non_nullable
as bool,clearSelectedGooglePlace: null == clearSelectedGooglePlace ? _self.clearSelectedGooglePlace : clearSelectedGooglePlace // ignore: cast_nullable_to_non_nullable
as bool,clearFlyToLocation: null == clearFlyToLocation ? _self.clearFlyToLocation : clearFlyToLocation // ignore: cast_nullable_to_non_nullable
as bool,flyToLat: freezed == flyToLat ? _self.flyToLat : flyToLat // ignore: cast_nullable_to_non_nullable
as double?,flyToLng: freezed == flyToLng ? _self.flyToLng : flyToLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [MapState].
extension MapStatePatterns on MapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapState value)  $default,){
final _that = this;
switch (_that) {
case _MapState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapState value)?  $default,){
final _that = this;
switch (_that) {
case _MapState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MapAnnotationEntry> annotations,  PlaceModel? selectedPlace,  GooglePlaceEntity? selectedGooglePlace,  List<String> selectedPlacePhotoUrls,  bool isBottomSheetVisible,  bool isLocationGranted,  bool clearSelectedPlace,  bool clearSelectedGooglePlace,  bool clearFlyToLocation,  double? flyToLat,  double? flyToLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapState() when $default != null:
return $default(_that.annotations,_that.selectedPlace,_that.selectedGooglePlace,_that.selectedPlacePhotoUrls,_that.isBottomSheetVisible,_that.isLocationGranted,_that.clearSelectedPlace,_that.clearSelectedGooglePlace,_that.clearFlyToLocation,_that.flyToLat,_that.flyToLng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MapAnnotationEntry> annotations,  PlaceModel? selectedPlace,  GooglePlaceEntity? selectedGooglePlace,  List<String> selectedPlacePhotoUrls,  bool isBottomSheetVisible,  bool isLocationGranted,  bool clearSelectedPlace,  bool clearSelectedGooglePlace,  bool clearFlyToLocation,  double? flyToLat,  double? flyToLng)  $default,) {final _that = this;
switch (_that) {
case _MapState():
return $default(_that.annotations,_that.selectedPlace,_that.selectedGooglePlace,_that.selectedPlacePhotoUrls,_that.isBottomSheetVisible,_that.isLocationGranted,_that.clearSelectedPlace,_that.clearSelectedGooglePlace,_that.clearFlyToLocation,_that.flyToLat,_that.flyToLng);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MapAnnotationEntry> annotations,  PlaceModel? selectedPlace,  GooglePlaceEntity? selectedGooglePlace,  List<String> selectedPlacePhotoUrls,  bool isBottomSheetVisible,  bool isLocationGranted,  bool clearSelectedPlace,  bool clearSelectedGooglePlace,  bool clearFlyToLocation,  double? flyToLat,  double? flyToLng)?  $default,) {final _that = this;
switch (_that) {
case _MapState() when $default != null:
return $default(_that.annotations,_that.selectedPlace,_that.selectedGooglePlace,_that.selectedPlacePhotoUrls,_that.isBottomSheetVisible,_that.isLocationGranted,_that.clearSelectedPlace,_that.clearSelectedGooglePlace,_that.clearFlyToLocation,_that.flyToLat,_that.flyToLng);case _:
  return null;

}
}

}

/// @nodoc


class _MapState extends MapState {
  const _MapState({final  List<MapAnnotationEntry> annotations = const [], this.selectedPlace, this.selectedGooglePlace, final  List<String> selectedPlacePhotoUrls = const [], this.isBottomSheetVisible = false, this.isLocationGranted = false, this.clearSelectedPlace = false, this.clearSelectedGooglePlace = false, this.clearFlyToLocation = false, this.flyToLat, this.flyToLng}): _annotations = annotations,_selectedPlacePhotoUrls = selectedPlacePhotoUrls,super._();
  

 final  List<MapAnnotationEntry> _annotations;
@override@JsonKey() List<MapAnnotationEntry> get annotations {
  if (_annotations is EqualUnmodifiableListView) return _annotations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_annotations);
}

@override final  PlaceModel? selectedPlace;
@override final  GooglePlaceEntity? selectedGooglePlace;
 final  List<String> _selectedPlacePhotoUrls;
@override@JsonKey() List<String> get selectedPlacePhotoUrls {
  if (_selectedPlacePhotoUrls is EqualUnmodifiableListView) return _selectedPlacePhotoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedPlacePhotoUrls);
}

@override@JsonKey() final  bool isBottomSheetVisible;
@override@JsonKey() final  bool isLocationGranted;
@override@JsonKey() final  bool clearSelectedPlace;
@override@JsonKey() final  bool clearSelectedGooglePlace;
@override@JsonKey() final  bool clearFlyToLocation;
@override final  double? flyToLat;
@override final  double? flyToLng;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapStateCopyWith<_MapState> get copyWith => __$MapStateCopyWithImpl<_MapState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapState&&const DeepCollectionEquality().equals(other._annotations, _annotations)&&(identical(other.selectedPlace, selectedPlace) || other.selectedPlace == selectedPlace)&&(identical(other.selectedGooglePlace, selectedGooglePlace) || other.selectedGooglePlace == selectedGooglePlace)&&const DeepCollectionEquality().equals(other._selectedPlacePhotoUrls, _selectedPlacePhotoUrls)&&(identical(other.isBottomSheetVisible, isBottomSheetVisible) || other.isBottomSheetVisible == isBottomSheetVisible)&&(identical(other.isLocationGranted, isLocationGranted) || other.isLocationGranted == isLocationGranted)&&(identical(other.clearSelectedPlace, clearSelectedPlace) || other.clearSelectedPlace == clearSelectedPlace)&&(identical(other.clearSelectedGooglePlace, clearSelectedGooglePlace) || other.clearSelectedGooglePlace == clearSelectedGooglePlace)&&(identical(other.clearFlyToLocation, clearFlyToLocation) || other.clearFlyToLocation == clearFlyToLocation)&&(identical(other.flyToLat, flyToLat) || other.flyToLat == flyToLat)&&(identical(other.flyToLng, flyToLng) || other.flyToLng == flyToLng));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_annotations),selectedPlace,selectedGooglePlace,const DeepCollectionEquality().hash(_selectedPlacePhotoUrls),isBottomSheetVisible,isLocationGranted,clearSelectedPlace,clearSelectedGooglePlace,clearFlyToLocation,flyToLat,flyToLng);

@override
String toString() {
  return 'MapState(annotations: $annotations, selectedPlace: $selectedPlace, selectedGooglePlace: $selectedGooglePlace, selectedPlacePhotoUrls: $selectedPlacePhotoUrls, isBottomSheetVisible: $isBottomSheetVisible, isLocationGranted: $isLocationGranted, clearSelectedPlace: $clearSelectedPlace, clearSelectedGooglePlace: $clearSelectedGooglePlace, clearFlyToLocation: $clearFlyToLocation, flyToLat: $flyToLat, flyToLng: $flyToLng)';
}


}

/// @nodoc
abstract mixin class _$MapStateCopyWith<$Res> implements $MapStateCopyWith<$Res> {
  factory _$MapStateCopyWith(_MapState value, $Res Function(_MapState) _then) = __$MapStateCopyWithImpl;
@override @useResult
$Res call({
 List<MapAnnotationEntry> annotations, PlaceModel? selectedPlace, GooglePlaceEntity? selectedGooglePlace, List<String> selectedPlacePhotoUrls, bool isBottomSheetVisible, bool isLocationGranted, bool clearSelectedPlace, bool clearSelectedGooglePlace, bool clearFlyToLocation, double? flyToLat, double? flyToLng
});




}
/// @nodoc
class __$MapStateCopyWithImpl<$Res>
    implements _$MapStateCopyWith<$Res> {
  __$MapStateCopyWithImpl(this._self, this._then);

  final _MapState _self;
  final $Res Function(_MapState) _then;

/// Create a copy of MapState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? annotations = null,Object? selectedPlace = freezed,Object? selectedGooglePlace = freezed,Object? selectedPlacePhotoUrls = null,Object? isBottomSheetVisible = null,Object? isLocationGranted = null,Object? clearSelectedPlace = null,Object? clearSelectedGooglePlace = null,Object? clearFlyToLocation = null,Object? flyToLat = freezed,Object? flyToLng = freezed,}) {
  return _then(_MapState(
annotations: null == annotations ? _self._annotations : annotations // ignore: cast_nullable_to_non_nullable
as List<MapAnnotationEntry>,selectedPlace: freezed == selectedPlace ? _self.selectedPlace : selectedPlace // ignore: cast_nullable_to_non_nullable
as PlaceModel?,selectedGooglePlace: freezed == selectedGooglePlace ? _self.selectedGooglePlace : selectedGooglePlace // ignore: cast_nullable_to_non_nullable
as GooglePlaceEntity?,selectedPlacePhotoUrls: null == selectedPlacePhotoUrls ? _self._selectedPlacePhotoUrls : selectedPlacePhotoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,isBottomSheetVisible: null == isBottomSheetVisible ? _self.isBottomSheetVisible : isBottomSheetVisible // ignore: cast_nullable_to_non_nullable
as bool,isLocationGranted: null == isLocationGranted ? _self.isLocationGranted : isLocationGranted // ignore: cast_nullable_to_non_nullable
as bool,clearSelectedPlace: null == clearSelectedPlace ? _self.clearSelectedPlace : clearSelectedPlace // ignore: cast_nullable_to_non_nullable
as bool,clearSelectedGooglePlace: null == clearSelectedGooglePlace ? _self.clearSelectedGooglePlace : clearSelectedGooglePlace // ignore: cast_nullable_to_non_nullable
as bool,clearFlyToLocation: null == clearFlyToLocation ? _self.clearFlyToLocation : clearFlyToLocation // ignore: cast_nullable_to_non_nullable
as bool,flyToLat: freezed == flyToLat ? _self.flyToLat : flyToLat // ignore: cast_nullable_to_non_nullable
as double?,flyToLng: freezed == flyToLng ? _self.flyToLng : flyToLng // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
