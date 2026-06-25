// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanModel {

@JsonKey(name: 'accommodation', fromJson: _parseAccommodation) List<PlanPlaceModel> get accommodation;/// Days keyed by day number (1-based). Populated via custom fromJson.
@JsonKey(includeFromJson: false, includeToJson: false) Map<int, DayPlanModel> get days;
/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanModelCopyWith<PlanModel> get copyWith => _$PlanModelCopyWithImpl<PlanModel>(this as PlanModel, _$identity);

  /// Serializes this PlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanModel&&const DeepCollectionEquality().equals(other.accommodation, accommodation)&&const DeepCollectionEquality().equals(other.days, days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(accommodation),const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'PlanModel(accommodation: $accommodation, days: $days)';
}


}

/// @nodoc
abstract mixin class $PlanModelCopyWith<$Res>  {
  factory $PlanModelCopyWith(PlanModel value, $Res Function(PlanModel) _then) = _$PlanModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'accommodation', fromJson: _parseAccommodation) List<PlanPlaceModel> accommodation,@JsonKey(includeFromJson: false, includeToJson: false) Map<int, DayPlanModel> days
});




}
/// @nodoc
class _$PlanModelCopyWithImpl<$Res>
    implements $PlanModelCopyWith<$Res> {
  _$PlanModelCopyWithImpl(this._self, this._then);

  final PlanModel _self;
  final $Res Function(PlanModel) _then;

/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accommodation = null,Object? days = null,}) {
  return _then(_self.copyWith(
accommodation: null == accommodation ? _self.accommodation : accommodation // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as Map<int, DayPlanModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanModel].
extension PlanModelPatterns on PlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'accommodation', fromJson: _parseAccommodation)  List<PlanPlaceModel> accommodation, @JsonKey(includeFromJson: false, includeToJson: false)  Map<int, DayPlanModel> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
return $default(_that.accommodation,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'accommodation', fromJson: _parseAccommodation)  List<PlanPlaceModel> accommodation, @JsonKey(includeFromJson: false, includeToJson: false)  Map<int, DayPlanModel> days)  $default,) {final _that = this;
switch (_that) {
case _PlanModel():
return $default(_that.accommodation,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'accommodation', fromJson: _parseAccommodation)  List<PlanPlaceModel> accommodation, @JsonKey(includeFromJson: false, includeToJson: false)  Map<int, DayPlanModel> days)?  $default,) {final _that = this;
switch (_that) {
case _PlanModel() when $default != null:
return $default(_that.accommodation,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanModel extends PlanModel {
  const _PlanModel({@JsonKey(name: 'accommodation', fromJson: _parseAccommodation) final  List<PlanPlaceModel> accommodation = const [], @JsonKey(includeFromJson: false, includeToJson: false) final  Map<int, DayPlanModel> days = const {}}): _accommodation = accommodation,_days = days,super._();
  factory _PlanModel.fromJson(Map<String, dynamic> json) => _$PlanModelFromJson(json);

 final  List<PlanPlaceModel> _accommodation;
@override@JsonKey(name: 'accommodation', fromJson: _parseAccommodation) List<PlanPlaceModel> get accommodation {
  if (_accommodation is EqualUnmodifiableListView) return _accommodation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accommodation);
}

/// Days keyed by day number (1-based). Populated via custom fromJson.
 final  Map<int, DayPlanModel> _days;
/// Days keyed by day number (1-based). Populated via custom fromJson.
@override@JsonKey(includeFromJson: false, includeToJson: false) Map<int, DayPlanModel> get days {
  if (_days is EqualUnmodifiableMapView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_days);
}


/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanModelCopyWith<_PlanModel> get copyWith => __$PlanModelCopyWithImpl<_PlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanModel&&const DeepCollectionEquality().equals(other._accommodation, _accommodation)&&const DeepCollectionEquality().equals(other._days, _days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_accommodation),const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'PlanModel(accommodation: $accommodation, days: $days)';
}


}

/// @nodoc
abstract mixin class _$PlanModelCopyWith<$Res> implements $PlanModelCopyWith<$Res> {
  factory _$PlanModelCopyWith(_PlanModel value, $Res Function(_PlanModel) _then) = __$PlanModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'accommodation', fromJson: _parseAccommodation) List<PlanPlaceModel> accommodation,@JsonKey(includeFromJson: false, includeToJson: false) Map<int, DayPlanModel> days
});




}
/// @nodoc
class __$PlanModelCopyWithImpl<$Res>
    implements _$PlanModelCopyWith<$Res> {
  __$PlanModelCopyWithImpl(this._self, this._then);

  final _PlanModel _self;
  final $Res Function(_PlanModel) _then;

/// Create a copy of PlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accommodation = null,Object? days = null,}) {
  return _then(_PlanModel(
accommodation: null == accommodation ? _self._accommodation : accommodation // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as Map<int, DayPlanModel>,
  ));
}


}

// dart format on
