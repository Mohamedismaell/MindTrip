// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DayPlanModel {

 List<PlanPlaceModel> get morning; List<PlanPlaceModel> get afternoon; List<PlanPlaceModel> get evening;
/// Create a copy of DayPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DayPlanModelCopyWith<DayPlanModel> get copyWith => _$DayPlanModelCopyWithImpl<DayPlanModel>(this as DayPlanModel, _$identity);

  /// Serializes this DayPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayPlanModel&&const DeepCollectionEquality().equals(other.morning, morning)&&const DeepCollectionEquality().equals(other.afternoon, afternoon)&&const DeepCollectionEquality().equals(other.evening, evening));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(morning),const DeepCollectionEquality().hash(afternoon),const DeepCollectionEquality().hash(evening));

@override
String toString() {
  return 'DayPlanModel(morning: $morning, afternoon: $afternoon, evening: $evening)';
}


}

/// @nodoc
abstract mixin class $DayPlanModelCopyWith<$Res>  {
  factory $DayPlanModelCopyWith(DayPlanModel value, $Res Function(DayPlanModel) _then) = _$DayPlanModelCopyWithImpl;
@useResult
$Res call({
 List<PlanPlaceModel> morning, List<PlanPlaceModel> afternoon, List<PlanPlaceModel> evening
});




}
/// @nodoc
class _$DayPlanModelCopyWithImpl<$Res>
    implements $DayPlanModelCopyWith<$Res> {
  _$DayPlanModelCopyWithImpl(this._self, this._then);

  final DayPlanModel _self;
  final $Res Function(DayPlanModel) _then;

/// Create a copy of DayPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? morning = null,Object? afternoon = null,Object? evening = null,}) {
  return _then(_self.copyWith(
morning: null == morning ? _self.morning : morning // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,afternoon: null == afternoon ? _self.afternoon : afternoon // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,evening: null == evening ? _self.evening : evening // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [DayPlanModel].
extension DayPlanModelPatterns on DayPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _DayPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _DayPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PlanPlaceModel> morning,  List<PlanPlaceModel> afternoon,  List<PlanPlaceModel> evening)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayPlanModel() when $default != null:
return $default(_that.morning,_that.afternoon,_that.evening);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PlanPlaceModel> morning,  List<PlanPlaceModel> afternoon,  List<PlanPlaceModel> evening)  $default,) {final _that = this;
switch (_that) {
case _DayPlanModel():
return $default(_that.morning,_that.afternoon,_that.evening);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PlanPlaceModel> morning,  List<PlanPlaceModel> afternoon,  List<PlanPlaceModel> evening)?  $default,) {final _that = this;
switch (_that) {
case _DayPlanModel() when $default != null:
return $default(_that.morning,_that.afternoon,_that.evening);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DayPlanModel implements DayPlanModel {
  const _DayPlanModel({final  List<PlanPlaceModel> morning = const <PlanPlaceModel>[], final  List<PlanPlaceModel> afternoon = const <PlanPlaceModel>[], final  List<PlanPlaceModel> evening = const <PlanPlaceModel>[]}): _morning = morning,_afternoon = afternoon,_evening = evening;
  factory _DayPlanModel.fromJson(Map<String, dynamic> json) => _$DayPlanModelFromJson(json);

 final  List<PlanPlaceModel> _morning;
@override@JsonKey() List<PlanPlaceModel> get morning {
  if (_morning is EqualUnmodifiableListView) return _morning;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_morning);
}

 final  List<PlanPlaceModel> _afternoon;
@override@JsonKey() List<PlanPlaceModel> get afternoon {
  if (_afternoon is EqualUnmodifiableListView) return _afternoon;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_afternoon);
}

 final  List<PlanPlaceModel> _evening;
@override@JsonKey() List<PlanPlaceModel> get evening {
  if (_evening is EqualUnmodifiableListView) return _evening;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_evening);
}


/// Create a copy of DayPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DayPlanModelCopyWith<_DayPlanModel> get copyWith => __$DayPlanModelCopyWithImpl<_DayPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DayPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayPlanModel&&const DeepCollectionEquality().equals(other._morning, _morning)&&const DeepCollectionEquality().equals(other._afternoon, _afternoon)&&const DeepCollectionEquality().equals(other._evening, _evening));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_morning),const DeepCollectionEquality().hash(_afternoon),const DeepCollectionEquality().hash(_evening));

@override
String toString() {
  return 'DayPlanModel(morning: $morning, afternoon: $afternoon, evening: $evening)';
}


}

/// @nodoc
abstract mixin class _$DayPlanModelCopyWith<$Res> implements $DayPlanModelCopyWith<$Res> {
  factory _$DayPlanModelCopyWith(_DayPlanModel value, $Res Function(_DayPlanModel) _then) = __$DayPlanModelCopyWithImpl;
@override @useResult
$Res call({
 List<PlanPlaceModel> morning, List<PlanPlaceModel> afternoon, List<PlanPlaceModel> evening
});




}
/// @nodoc
class __$DayPlanModelCopyWithImpl<$Res>
    implements _$DayPlanModelCopyWith<$Res> {
  __$DayPlanModelCopyWithImpl(this._self, this._then);

  final _DayPlanModel _self;
  final $Res Function(_DayPlanModel) _then;

/// Create a copy of DayPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? morning = null,Object? afternoon = null,Object? evening = null,}) {
  return _then(_DayPlanModel(
morning: null == morning ? _self._morning : morning // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,afternoon: null == afternoon ? _self._afternoon : afternoon // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,evening: null == evening ? _self._evening : evening // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,
  ));
}


}

// dart format on
