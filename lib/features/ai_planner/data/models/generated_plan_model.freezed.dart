// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generated_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GeneratedPlanModel {

@JsonKey(name: 'trip_id', fromJson: parseString) String get tripId;@JsonKey(fromJson: parseString) String get status;@JsonKey(fromJson: parseInt) int get people;@JsonKey(name: 'total_calculated_cost', fromJson: parseInt) int get totalCalculatedCost;@JsonKey(name: 'days_count', fromJson: parseInt) int get daysCount; PlanModel? get plan;
/// Create a copy of GeneratedPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedPlanModelCopyWith<GeneratedPlanModel> get copyWith => _$GeneratedPlanModelCopyWithImpl<GeneratedPlanModel>(this as GeneratedPlanModel, _$identity);

  /// Serializes this GeneratedPlanModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedPlanModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalCalculatedCost, totalCalculatedCost) || other.totalCalculatedCost == totalCalculatedCost)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,status,people,totalCalculatedCost,daysCount,plan);

@override
String toString() {
  return 'GeneratedPlanModel(tripId: $tripId, status: $status, people: $people, totalCalculatedCost: $totalCalculatedCost, daysCount: $daysCount, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $GeneratedPlanModelCopyWith<$Res>  {
  factory $GeneratedPlanModelCopyWith(GeneratedPlanModel value, $Res Function(GeneratedPlanModel) _then) = _$GeneratedPlanModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'trip_id', fromJson: parseString) String tripId,@JsonKey(fromJson: parseString) String status,@JsonKey(fromJson: parseInt) int people,@JsonKey(name: 'total_calculated_cost', fromJson: parseInt) int totalCalculatedCost,@JsonKey(name: 'days_count', fromJson: parseInt) int daysCount, PlanModel? plan
});




}
/// @nodoc
class _$GeneratedPlanModelCopyWithImpl<$Res>
    implements $GeneratedPlanModelCopyWith<$Res> {
  _$GeneratedPlanModelCopyWithImpl(this._self, this._then);

  final GeneratedPlanModel _self;
  final $Res Function(GeneratedPlanModel) _then;

/// Create a copy of GeneratedPlanModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? status = null,Object? people = null,Object? totalCalculatedCost = null,Object? daysCount = null,Object? plan = freezed,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalCalculatedCost: null == totalCalculatedCost ? _self.totalCalculatedCost : totalCalculatedCost // ignore: cast_nullable_to_non_nullable
as int,daysCount: null == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as PlanModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [GeneratedPlanModel].
extension GeneratedPlanModelPatterns on GeneratedPlanModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeneratedPlanModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeneratedPlanModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeneratedPlanModel value)  $default,){
final _that = this;
switch (_that) {
case _GeneratedPlanModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeneratedPlanModel value)?  $default,){
final _that = this;
switch (_that) {
case _GeneratedPlanModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'trip_id', fromJson: parseString)  String tripId, @JsonKey(fromJson: parseString)  String status, @JsonKey(fromJson: parseInt)  int people, @JsonKey(name: 'total_calculated_cost', fromJson: parseInt)  int totalCalculatedCost, @JsonKey(name: 'days_count', fromJson: parseInt)  int daysCount,  PlanModel? plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedPlanModel() when $default != null:
return $default(_that.tripId,_that.status,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'trip_id', fromJson: parseString)  String tripId, @JsonKey(fromJson: parseString)  String status, @JsonKey(fromJson: parseInt)  int people, @JsonKey(name: 'total_calculated_cost', fromJson: parseInt)  int totalCalculatedCost, @JsonKey(name: 'days_count', fromJson: parseInt)  int daysCount,  PlanModel? plan)  $default,) {final _that = this;
switch (_that) {
case _GeneratedPlanModel():
return $default(_that.tripId,_that.status,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'trip_id', fromJson: parseString)  String tripId, @JsonKey(fromJson: parseString)  String status, @JsonKey(fromJson: parseInt)  int people, @JsonKey(name: 'total_calculated_cost', fromJson: parseInt)  int totalCalculatedCost, @JsonKey(name: 'days_count', fromJson: parseInt)  int daysCount,  PlanModel? plan)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedPlanModel() when $default != null:
return $default(_that.tripId,_that.status,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeneratedPlanModel implements GeneratedPlanModel {
  const _GeneratedPlanModel({@JsonKey(name: 'trip_id', fromJson: parseString) this.tripId = '', @JsonKey(fromJson: parseString) this.status = '', @JsonKey(fromJson: parseInt) this.people = 0, @JsonKey(name: 'total_calculated_cost', fromJson: parseInt) this.totalCalculatedCost = 0, @JsonKey(name: 'days_count', fromJson: parseInt) this.daysCount = 0, this.plan});
  factory _GeneratedPlanModel.fromJson(Map<String, dynamic> json) => _$GeneratedPlanModelFromJson(json);

@override@JsonKey(name: 'trip_id', fromJson: parseString) final  String tripId;
@override@JsonKey(fromJson: parseString) final  String status;
@override@JsonKey(fromJson: parseInt) final  int people;
@override@JsonKey(name: 'total_calculated_cost', fromJson: parseInt) final  int totalCalculatedCost;
@override@JsonKey(name: 'days_count', fromJson: parseInt) final  int daysCount;
@override final  PlanModel? plan;

/// Create a copy of GeneratedPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedPlanModelCopyWith<_GeneratedPlanModel> get copyWith => __$GeneratedPlanModelCopyWithImpl<_GeneratedPlanModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeneratedPlanModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedPlanModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalCalculatedCost, totalCalculatedCost) || other.totalCalculatedCost == totalCalculatedCost)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tripId,status,people,totalCalculatedCost,daysCount,plan);

@override
String toString() {
  return 'GeneratedPlanModel(tripId: $tripId, status: $status, people: $people, totalCalculatedCost: $totalCalculatedCost, daysCount: $daysCount, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$GeneratedPlanModelCopyWith<$Res> implements $GeneratedPlanModelCopyWith<$Res> {
  factory _$GeneratedPlanModelCopyWith(_GeneratedPlanModel value, $Res Function(_GeneratedPlanModel) _then) = __$GeneratedPlanModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'trip_id', fromJson: parseString) String tripId,@JsonKey(fromJson: parseString) String status,@JsonKey(fromJson: parseInt) int people,@JsonKey(name: 'total_calculated_cost', fromJson: parseInt) int totalCalculatedCost,@JsonKey(name: 'days_count', fromJson: parseInt) int daysCount, PlanModel? plan
});




}
/// @nodoc
class __$GeneratedPlanModelCopyWithImpl<$Res>
    implements _$GeneratedPlanModelCopyWith<$Res> {
  __$GeneratedPlanModelCopyWithImpl(this._self, this._then);

  final _GeneratedPlanModel _self;
  final $Res Function(_GeneratedPlanModel) _then;

/// Create a copy of GeneratedPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? status = null,Object? people = null,Object? totalCalculatedCost = null,Object? daysCount = null,Object? plan = freezed,}) {
  return _then(_GeneratedPlanModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalCalculatedCost: null == totalCalculatedCost ? _self.totalCalculatedCost : totalCalculatedCost // ignore: cast_nullable_to_non_nullable
as int,daysCount: null == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as PlanModel?,
  ));
}


}

// dart format on
