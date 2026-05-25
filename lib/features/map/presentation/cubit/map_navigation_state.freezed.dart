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

 MapRoute? get activeRoute; bool get isRouteLoading; String? get routeError; NavigationProfile get selectedProfile; int get currentStepIndex; int get totalLegs; int get currentLegIndex; bool get isSequentialMode;/// Name of the place being navigated to
 String? get destinationName;/// All place names in sequential navigation order
 List<String> get placeNames;
/// Create a copy of MapNavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MapNavigationStateCopyWith<MapNavigationState> get copyWith => _$MapNavigationStateCopyWithImpl<MapNavigationState>(this as MapNavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MapNavigationState&&(identical(other.activeRoute, activeRoute) || other.activeRoute == activeRoute)&&(identical(other.isRouteLoading, isRouteLoading) || other.isRouteLoading == isRouteLoading)&&(identical(other.routeError, routeError) || other.routeError == routeError)&&(identical(other.selectedProfile, selectedProfile) || other.selectedProfile == selectedProfile)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&(identical(other.totalLegs, totalLegs) || other.totalLegs == totalLegs)&&(identical(other.currentLegIndex, currentLegIndex) || other.currentLegIndex == currentLegIndex)&&(identical(other.isSequentialMode, isSequentialMode) || other.isSequentialMode == isSequentialMode)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&const DeepCollectionEquality().equals(other.placeNames, placeNames));
}


@override
int get hashCode => Object.hash(runtimeType,activeRoute,isRouteLoading,routeError,selectedProfile,currentStepIndex,totalLegs,currentLegIndex,isSequentialMode,destinationName,const DeepCollectionEquality().hash(placeNames));

@override
String toString() {
  return 'MapNavigationState(activeRoute: $activeRoute, isRouteLoading: $isRouteLoading, routeError: $routeError, selectedProfile: $selectedProfile, currentStepIndex: $currentStepIndex, totalLegs: $totalLegs, currentLegIndex: $currentLegIndex, isSequentialMode: $isSequentialMode, destinationName: $destinationName, placeNames: $placeNames)';
}


}

/// @nodoc
abstract mixin class $MapNavigationStateCopyWith<$Res>  {
  factory $MapNavigationStateCopyWith(MapNavigationState value, $Res Function(MapNavigationState) _then) = _$MapNavigationStateCopyWithImpl;
@useResult
$Res call({
 MapRoute? activeRoute, bool isRouteLoading, String? routeError, NavigationProfile selectedProfile, int currentStepIndex, int totalLegs, int currentLegIndex, bool isSequentialMode, String? destinationName, List<String> placeNames
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
@pragma('vm:prefer-inline') @override $Res call({Object? activeRoute = freezed,Object? isRouteLoading = null,Object? routeError = freezed,Object? selectedProfile = null,Object? currentStepIndex = null,Object? totalLegs = null,Object? currentLegIndex = null,Object? isSequentialMode = null,Object? destinationName = freezed,Object? placeNames = null,}) {
  return _then(_self.copyWith(
activeRoute: freezed == activeRoute ? _self.activeRoute : activeRoute // ignore: cast_nullable_to_non_nullable
as MapRoute?,isRouteLoading: null == isRouteLoading ? _self.isRouteLoading : isRouteLoading // ignore: cast_nullable_to_non_nullable
as bool,routeError: freezed == routeError ? _self.routeError : routeError // ignore: cast_nullable_to_non_nullable
as String?,selectedProfile: null == selectedProfile ? _self.selectedProfile : selectedProfile // ignore: cast_nullable_to_non_nullable
as NavigationProfile,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,totalLegs: null == totalLegs ? _self.totalLegs : totalLegs // ignore: cast_nullable_to_non_nullable
as int,currentLegIndex: null == currentLegIndex ? _self.currentLegIndex : currentLegIndex // ignore: cast_nullable_to_non_nullable
as int,isSequentialMode: null == isSequentialMode ? _self.isSequentialMode : isSequentialMode // ignore: cast_nullable_to_non_nullable
as bool,destinationName: freezed == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String?,placeNames: null == placeNames ? _self.placeNames : placeNames // ignore: cast_nullable_to_non_nullable
as List<String>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MapRoute? activeRoute,  bool isRouteLoading,  String? routeError,  NavigationProfile selectedProfile,  int currentStepIndex,  int totalLegs,  int currentLegIndex,  bool isSequentialMode,  String? destinationName,  List<String> placeNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MapNavigationState() when $default != null:
return $default(_that.activeRoute,_that.isRouteLoading,_that.routeError,_that.selectedProfile,_that.currentStepIndex,_that.totalLegs,_that.currentLegIndex,_that.isSequentialMode,_that.destinationName,_that.placeNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MapRoute? activeRoute,  bool isRouteLoading,  String? routeError,  NavigationProfile selectedProfile,  int currentStepIndex,  int totalLegs,  int currentLegIndex,  bool isSequentialMode,  String? destinationName,  List<String> placeNames)  $default,) {final _that = this;
switch (_that) {
case _MapNavigationState():
return $default(_that.activeRoute,_that.isRouteLoading,_that.routeError,_that.selectedProfile,_that.currentStepIndex,_that.totalLegs,_that.currentLegIndex,_that.isSequentialMode,_that.destinationName,_that.placeNames);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MapRoute? activeRoute,  bool isRouteLoading,  String? routeError,  NavigationProfile selectedProfile,  int currentStepIndex,  int totalLegs,  int currentLegIndex,  bool isSequentialMode,  String? destinationName,  List<String> placeNames)?  $default,) {final _that = this;
switch (_that) {
case _MapNavigationState() when $default != null:
return $default(_that.activeRoute,_that.isRouteLoading,_that.routeError,_that.selectedProfile,_that.currentStepIndex,_that.totalLegs,_that.currentLegIndex,_that.isSequentialMode,_that.destinationName,_that.placeNames);case _:
  return null;

}
}

}

/// @nodoc


class _MapNavigationState extends MapNavigationState {
  const _MapNavigationState({this.activeRoute, this.isRouteLoading = false, this.routeError, this.selectedProfile = NavigationProfile.driving, this.currentStepIndex = 0, this.totalLegs = 0, this.currentLegIndex = 0, this.isSequentialMode = false, this.destinationName, final  List<String> placeNames = const []}): _placeNames = placeNames,super._();
  

@override final  MapRoute? activeRoute;
@override@JsonKey() final  bool isRouteLoading;
@override final  String? routeError;
@override@JsonKey() final  NavigationProfile selectedProfile;
@override@JsonKey() final  int currentStepIndex;
@override@JsonKey() final  int totalLegs;
@override@JsonKey() final  int currentLegIndex;
@override@JsonKey() final  bool isSequentialMode;
/// Name of the place being navigated to
@override final  String? destinationName;
/// All place names in sequential navigation order
 final  List<String> _placeNames;
/// All place names in sequential navigation order
@override@JsonKey() List<String> get placeNames {
  if (_placeNames is EqualUnmodifiableListView) return _placeNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeNames);
}


/// Create a copy of MapNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MapNavigationStateCopyWith<_MapNavigationState> get copyWith => __$MapNavigationStateCopyWithImpl<_MapNavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MapNavigationState&&(identical(other.activeRoute, activeRoute) || other.activeRoute == activeRoute)&&(identical(other.isRouteLoading, isRouteLoading) || other.isRouteLoading == isRouteLoading)&&(identical(other.routeError, routeError) || other.routeError == routeError)&&(identical(other.selectedProfile, selectedProfile) || other.selectedProfile == selectedProfile)&&(identical(other.currentStepIndex, currentStepIndex) || other.currentStepIndex == currentStepIndex)&&(identical(other.totalLegs, totalLegs) || other.totalLegs == totalLegs)&&(identical(other.currentLegIndex, currentLegIndex) || other.currentLegIndex == currentLegIndex)&&(identical(other.isSequentialMode, isSequentialMode) || other.isSequentialMode == isSequentialMode)&&(identical(other.destinationName, destinationName) || other.destinationName == destinationName)&&const DeepCollectionEquality().equals(other._placeNames, _placeNames));
}


@override
int get hashCode => Object.hash(runtimeType,activeRoute,isRouteLoading,routeError,selectedProfile,currentStepIndex,totalLegs,currentLegIndex,isSequentialMode,destinationName,const DeepCollectionEquality().hash(_placeNames));

@override
String toString() {
  return 'MapNavigationState(activeRoute: $activeRoute, isRouteLoading: $isRouteLoading, routeError: $routeError, selectedProfile: $selectedProfile, currentStepIndex: $currentStepIndex, totalLegs: $totalLegs, currentLegIndex: $currentLegIndex, isSequentialMode: $isSequentialMode, destinationName: $destinationName, placeNames: $placeNames)';
}


}

/// @nodoc
abstract mixin class _$MapNavigationStateCopyWith<$Res> implements $MapNavigationStateCopyWith<$Res> {
  factory _$MapNavigationStateCopyWith(_MapNavigationState value, $Res Function(_MapNavigationState) _then) = __$MapNavigationStateCopyWithImpl;
@override @useResult
$Res call({
 MapRoute? activeRoute, bool isRouteLoading, String? routeError, NavigationProfile selectedProfile, int currentStepIndex, int totalLegs, int currentLegIndex, bool isSequentialMode, String? destinationName, List<String> placeNames
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
@override @pragma('vm:prefer-inline') $Res call({Object? activeRoute = freezed,Object? isRouteLoading = null,Object? routeError = freezed,Object? selectedProfile = null,Object? currentStepIndex = null,Object? totalLegs = null,Object? currentLegIndex = null,Object? isSequentialMode = null,Object? destinationName = freezed,Object? placeNames = null,}) {
  return _then(_MapNavigationState(
activeRoute: freezed == activeRoute ? _self.activeRoute : activeRoute // ignore: cast_nullable_to_non_nullable
as MapRoute?,isRouteLoading: null == isRouteLoading ? _self.isRouteLoading : isRouteLoading // ignore: cast_nullable_to_non_nullable
as bool,routeError: freezed == routeError ? _self.routeError : routeError // ignore: cast_nullable_to_non_nullable
as String?,selectedProfile: null == selectedProfile ? _self.selectedProfile : selectedProfile // ignore: cast_nullable_to_non_nullable
as NavigationProfile,currentStepIndex: null == currentStepIndex ? _self.currentStepIndex : currentStepIndex // ignore: cast_nullable_to_non_nullable
as int,totalLegs: null == totalLegs ? _self.totalLegs : totalLegs // ignore: cast_nullable_to_non_nullable
as int,currentLegIndex: null == currentLegIndex ? _self.currentLegIndex : currentLegIndex // ignore: cast_nullable_to_non_nullable
as int,isSequentialMode: null == isSequentialMode ? _self.isSequentialMode : isSequentialMode // ignore: cast_nullable_to_non_nullable
as bool,destinationName: freezed == destinationName ? _self.destinationName : destinationName // ignore: cast_nullable_to_non_nullable
as String?,placeNames: null == placeNames ? _self._placeNames : placeNames // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
