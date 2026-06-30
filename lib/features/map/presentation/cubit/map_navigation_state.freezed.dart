// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_navigation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MapNavigationState {

 Map<NavigationProfile, MapRoute> get routesByProfile; bool get isRouteLoading; String? get routeError; NavigationProfile get selectedProfile; int get currentStepIndex; int get totalLegs; int get currentLegIndex; bool get isSequentialMode; String? get destinationName; List<String> get placeNames; double? get remainingStepDistanceMeters;
/// Create a copy of MapNavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapNavigationStateCopyWith<MapNavigationState> get copyWith => _$MapNavigationStateCopyWithImpl<MapNavigationState>(this as MapNavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapNavigationState&&const DeepCollectionEquality().equals(other.routesByProfile, routesByProfile)&&(identical(other.isRouteLoading, isRouteLoading) || other.isRouteLoading == isRouteLoading)&&(identical(other.routeError, routeError) || other.routeError == routeError)&&(identical(other.selectedProfile, selectedProfile) || other.selectedProfile == selectedProfile)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&(identical(other.totalLegs, totalLegs) || other.totalLegs == totalLegs)&&(identical(other.currentLegIndex, currentLegIndex) || other.currentLegIndex == currentLegIndex)&&(identical(other.isSequentialMode, isSequentialMode) || other.isSequentialMode == isSequentialMode)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&const DeepCollectionEquality().equals(other.placeNames, placeNames)&&(identical(other.remainingStepDistanceMeters, remainingStepDistanceMeters) || other.remainingStepDistanceMeters == remainingStepDistanceMeters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(routesByProfile),isRouteLoading,routeError,selectedProfile,currentStepIndex,totalLegs,currentLegIndex,isSequentialMode,destinationName,const DeepCollectionEquality().hash(placeNames),remainingStepDistanceMeters);

@override
String toString() {
  return 'MapNavigationState(routesByProfile: $routesByProfile, isRouteLoading: $isRouteLoading, routeError: $routeError, selectedProfile: $selectedProfile, currentStepIndex: $currentStepIndex, totalLegs: $totalLegs, currentLegIndex: $currentLegIndex, isSequentialMode: $isSequentialMode, destinationName: $destinationName, placeNames: $placeNames, remainingStepDistanceMeters: $remainingStepDistanceMeters)';
}


}

/// @nodoc
abstract mixin class $MapNavigationStateCopyWith<$Res>  {
  factory $MapNavigationStateCopyWith(MapNavigationState value, $Res Function(MapNavigationState) _then) = _$MapNavigationStateCopyWithImpl;
@useResult
$Res call({
 Map<NavigationProfile, MapRoute> routesByProfile, bool isRouteLoading, String? routeError, NavigationProfile selectedProfile, int currentStepIndex, int totalLegs, int currentLegIndex, bool isSequentialMode, String? destinationName, List<String> placeNames, double? remainingStepDistanceMeters
});




}
/// @nodoc
class _$MapNavigationStateCopyWithImpl<$Res>
    implements $MapNavigationStateCopyWith<$Res> {
  _$MapNavigationStateCopyWithImpl(this._self, this._then);

  final MapNavigationState _self;
  final $Res Function(MapNavigationState) _then;

/// Create a copy of MapNavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? routesByProfile = null,Object? isRouteLoading = null,Object? routeError = freezed,Object? selectedProfile = null,Object? currentStepIndex = null,Object? totalLegs = null,Object? currentLegIndex = null,Object? isSequentialMode = null,Object? destinationName = freezed,Object? placeNames = null,Object? remainingStepDistanceMeters = freezed,}) {
  return _then(_self.copyWith(
routesByProfile: null == routesByProfile ? _self.routesByProfile : routesByProfile // ignore: cast_nullable_to_non_nullable
as Map<NavigationProfile, MapRoute>,isRouteLoading: null == isRouteLoading ? _self.isRouteLoading : isRouteLoading // ignore: cast_nullable_to_non_nullable
as bool,routeError: freezed == routeError ? _self.routeError : routeError // ignore: cast_nullable_to_non_nullable
as String?,selectedProfile: null == selectedProfile ? _self.selectedProfile : selectedProfile // ignore: cast_nullable_to_non_nullable
as NavigationProfile,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,totalLegs: null == totalLegs ? _self.totalLegs : totalLegs // ignore: cast_nullable_to_non_nullable
as int,currentLegIndex: null == currentLegIndex ? _self.currentLegIndex : currentLegIndex // ignore: cast_nullable_to_non_nullable
as int,isSequentialMode: null == isSequentialMode ? _self.isSequentialMode : isSequentialMode // ignore: cast_nullable_to_non_nullable
as bool,destinationName: freezed == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String?,placeNames: null == placeNames ? _self.placeNames : placeNames // ignore: cast_nullable_to_non_nullable
as List<String>,remainingStepDistanceMeters: freezed == remainingStepDistanceMeters ? _self.remainingStepDistanceMeters : remainingStepDistanceMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [MapNavigationState].
extension MapNavigationStatePatterns on MapNavigationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MapNavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MapNavigationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MapNavigationState value)  $default,){
final _that = this;
switch (_that) {
case _MapNavigationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MapNavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _MapNavigationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<NavigationProfile, MapRoute> routesByProfile,  bool isRouteLoading,  String? routeError,  NavigationProfile selectedProfile,  int currentStepIndex,  int totalLegs,  int currentLegIndex,  bool isSequentialMode,  String? destinationName,  List<String> placeNames,  double? remainingStepDistanceMeters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapNavigationState() when $default != null:
return $default(_that.routesByProfile,_that.isRouteLoading,_that.routeError,_that.selectedProfile,_that.currentStepIndex,_that.totalLegs,_that.currentLegIndex,_that.isSequentialMode,_that.destinationName,_that.placeNames,_that.remainingStepDistanceMeters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<NavigationProfile, MapRoute> routesByProfile,  bool isRouteLoading,  String? routeError,  NavigationProfile selectedProfile,  int currentStepIndex,  int totalLegs,  int currentLegIndex,  bool isSequentialMode,  String? destinationName,  List<String> placeNames,  double? remainingStepDistanceMeters)  $default,) {final _that = this;
switch (_that) {
case _MapNavigationState():
return $default(_that.routesByProfile,_that.isRouteLoading,_that.routeError,_that.selectedProfile,_that.currentStepIndex,_that.totalLegs,_that.currentLegIndex,_that.isSequentialMode,_that.destinationName,_that.placeNames,_that.remainingStepDistanceMeters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<NavigationProfile, MapRoute> routesByProfile,  bool isRouteLoading,  String? routeError,  NavigationProfile selectedProfile,  int currentStepIndex,  int totalLegs,  int currentLegIndex,  bool isSequentialMode,  String? destinationName,  List<String> placeNames,  double? remainingStepDistanceMeters)?  $default,) {final _that = this;
switch (_that) {
case _MapNavigationState() when $default != null:
return $default(_that.routesByProfile,_that.isRouteLoading,_that.routeError,_that.selectedProfile,_that.currentStepIndex,_that.totalLegs,_that.currentLegIndex,_that.isSequentialMode,_that.destinationName,_that.placeNames,_that.remainingStepDistanceMeters);case _:
  return null;

}
}

}

/// @nodoc


class _MapNavigationState extends MapNavigationState {
  const _MapNavigationState({final  Map<NavigationProfile, MapRoute> routesByProfile = const {}, this.isRouteLoading = false, this.routeError, this.selectedProfile = NavigationProfile.driving, this.currentStepIndex = 0, this.totalLegs = 0, this.currentLegIndex = 0, this.isSequentialMode = false, this.destinationName, final  List<String> placeNames = const [], this.remainingStepDistanceMeters}): _routesByProfile = routesByProfile,_placeNames = placeNames,super._();
  

 final  Map<NavigationProfile, MapRoute> _routesByProfile;
@override@JsonKey() Map<NavigationProfile, MapRoute> get routesByProfile {
  if (_routesByProfile is EqualUnmodifiableMapView) return _routesByProfile;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_routesByProfile);
}

@override@JsonKey() final  bool isRouteLoading;
@override final  String? routeError;
@override@JsonKey() final  NavigationProfile selectedProfile;
@override@JsonKey() final  int currentStepIndex;
@override@JsonKey() final  int totalLegs;
@override@JsonKey() final  int currentLegIndex;
@override@JsonKey() final  bool isSequentialMode;
@override final  String? destinationName;
 final  List<String> _placeNames;
@override@JsonKey() List<String> get placeNames {
  if (_placeNames is EqualUnmodifiableListView) return _placeNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeNames);
}

@override final  double? remainingStepDistanceMeters;

/// Create a copy of MapNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapNavigationStateCopyWith<_MapNavigationState> get copyWith => __$MapNavigationStateCopyWithImpl<_MapNavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapNavigationState&&const DeepCollectionEquality().equals(other._routesByProfile, _routesByProfile)&&(identical(other.isRouteLoading, isRouteLoading) || other.isRouteLoading == isRouteLoading)&&(identical(other.routeError, routeError) || other.routeError == routeError)&&(identical(other.selectedProfile, selectedProfile) || other.selectedProfile == selectedProfile)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&(identical(other.totalLegs, totalLegs) || other.totalLegs == totalLegs)&&(identical(other.currentLegIndex, currentLegIndex) || other.currentLegIndex == currentLegIndex)&&(identical(other.isSequentialMode, isSequentialMode) || other.isSequentialMode == isSequentialMode)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&const DeepCollectionEquality().equals(other._placeNames, _placeNames)&&(identical(other.remainingStepDistanceMeters, remainingStepDistanceMeters) || other.remainingStepDistanceMeters == remainingStepDistanceMeters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_routesByProfile),isRouteLoading,routeError,selectedProfile,currentStepIndex,totalLegs,currentLegIndex,isSequentialMode,destinationName,const DeepCollectionEquality().hash(_placeNames),remainingStepDistanceMeters);

@override
String toString() {
  return 'MapNavigationState(routesByProfile: $routesByProfile, isRouteLoading: $isRouteLoading, routeError: $routeError, selectedProfile: $selectedProfile, currentStepIndex: $currentStepIndex, totalLegs: $totalLegs, currentLegIndex: $currentLegIndex, isSequentialMode: $isSequentialMode, destinationName: $destinationName, placeNames: $placeNames, remainingStepDistanceMeters: $remainingStepDistanceMeters)';
}


}

/// @nodoc
abstract mixin class _$MapNavigationStateCopyWith<$Res> implements $MapNavigationStateCopyWith<$Res> {
  factory _$MapNavigationStateCopyWith(_MapNavigationState value, $Res Function(_MapNavigationState) _then) = __$MapNavigationStateCopyWithImpl;
@override @useResult
$Res call({
 Map<NavigationProfile, MapRoute> routesByProfile, bool isRouteLoading, String? routeError, NavigationProfile selectedProfile, int currentStepIndex, int totalLegs, int currentLegIndex, bool isSequentialMode, String? destinationName, List<String> placeNames, double? remainingStepDistanceMeters
});




}
/// @nodoc
class __$MapNavigationStateCopyWithImpl<$Res>
    implements _$MapNavigationStateCopyWith<$Res> {
  __$MapNavigationStateCopyWithImpl(this._self, this._then);

  final _MapNavigationState _self;
  final $Res Function(_MapNavigationState) _then;

/// Create a copy of MapNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? routesByProfile = null,Object? isRouteLoading = null,Object? routeError = freezed,Object? selectedProfile = null,Object? currentStepIndex = null,Object? totalLegs = null,Object? currentLegIndex = null,Object? isSequentialMode = null,Object? destinationName = freezed,Object? placeNames = null,Object? remainingStepDistanceMeters = freezed,}) {
  return _then(_MapNavigationState(
routesByProfile: null == routesByProfile ? _self._routesByProfile : routesByProfile // ignore: cast_nullable_to_non_nullable
as Map<NavigationProfile, MapRoute>,isRouteLoading: null == isRouteLoading ? _self.isRouteLoading : isRouteLoading // ignore: cast_nullable_to_non_nullable
as bool,routeError: freezed == routeError ? _self.routeError : routeError // ignore: cast_nullable_to_non_nullable
as String?,selectedProfile: null == selectedProfile ? _self.selectedProfile : selectedProfile // ignore: cast_nullable_to_non_nullable
as NavigationProfile,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,totalLegs: null == totalLegs ? _self.totalLegs : totalLegs // ignore: cast_nullable_to_non_nullable
as int,currentLegIndex: null == currentLegIndex ? _self.currentLegIndex : currentLegIndex // ignore: cast_nullable_to_non_nullable
as int,isSequentialMode: null == isSequentialMode ? _self.isSequentialMode : isSequentialMode // ignore: cast_nullable_to_non_nullable
as bool,destinationName: freezed == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String?,placeNames: null == placeNames ? _self._placeNames : placeNames // ignore: cast_nullable_to_non_nullable
as List<String>,remainingStepDistanceMeters: freezed == remainingStepDistanceMeters ? _self.remainingStepDistanceMeters : remainingStepDistanceMeters // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
