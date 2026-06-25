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

 String get tripId; String get status; int get people; double get totalCalculatedCost; int get daysCount; List<PlanPlaceModel> get accommodation; Map<int, DayPlanModel> get days;
/// Create a copy of GeneratedPlanModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeneratedPlanModelCopyWith<GeneratedPlanModel> get copyWith => _$GeneratedPlanModelCopyWithImpl<GeneratedPlanModel>(this as GeneratedPlanModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeneratedPlanModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalCalculatedCost, totalCalculatedCost) || other.totalCalculatedCost == totalCalculatedCost)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&const DeepCollectionEquality().equals(other.accommodation, accommodation)&&const DeepCollectionEquality().equals(other.days, days));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,status,people,totalCalculatedCost,daysCount,const DeepCollectionEquality().hash(accommodation),const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'GeneratedPlanModel(tripId: $tripId, status: $status, people: $people, totalCalculatedCost: $totalCalculatedCost, daysCount: $daysCount, accommodation: $accommodation, days: $days)';
}


}

/// @nodoc
abstract mixin class $GeneratedPlanModelCopyWith<$Res>  {
  factory $GeneratedPlanModelCopyWith(GeneratedPlanModel value, $Res Function(GeneratedPlanModel) _then) = _$GeneratedPlanModelCopyWithImpl;
@useResult
$Res call({
 String tripId, String status, int people, double totalCalculatedCost, int daysCount, List<PlanPlaceModel> accommodation, Map<int, DayPlanModel> days
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
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? status = null,Object? people = null,Object? totalCalculatedCost = null,Object? daysCount = null,Object? accommodation = null,Object? days = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalCalculatedCost: null == totalCalculatedCost ? _self.totalCalculatedCost : totalCalculatedCost // ignore: cast_nullable_to_non_nullable
as double,daysCount: null == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int,accommodation: null == accommodation ? _self.accommodation : accommodation // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as Map<int, DayPlanModel>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String status,  int people,  double totalCalculatedCost,  int daysCount,  List<PlanPlaceModel> accommodation,  Map<int, DayPlanModel> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeneratedPlanModel() when $default != null:
return $default(_that.tripId,_that.status,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.accommodation,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String status,  int people,  double totalCalculatedCost,  int daysCount,  List<PlanPlaceModel> accommodation,  Map<int, DayPlanModel> days)  $default,) {final _that = this;
switch (_that) {
case _GeneratedPlanModel():
return $default(_that.tripId,_that.status,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.accommodation,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String status,  int people,  double totalCalculatedCost,  int daysCount,  List<PlanPlaceModel> accommodation,  Map<int, DayPlanModel> days)?  $default,) {final _that = this;
switch (_that) {
case _GeneratedPlanModel() when $default != null:
return $default(_that.tripId,_that.status,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.accommodation,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _GeneratedPlanModel implements GeneratedPlanModel {
  const _GeneratedPlanModel({required this.tripId, required this.status, required this.people, required this.totalCalculatedCost, required this.daysCount, required final  List<PlanPlaceModel> accommodation, required final  Map<int, DayPlanModel> days}): _accommodation = accommodation,_days = days;
  

@override final  String tripId;
@override final  String status;
@override final  int people;
@override final  double totalCalculatedCost;
@override final  int daysCount;
 final  List<PlanPlaceModel> _accommodation;
@override List<PlanPlaceModel> get accommodation {
  if (_accommodation is EqualUnmodifiableListView) return _accommodation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accommodation);
}

 final  Map<int, DayPlanModel> _days;
@override Map<int, DayPlanModel> get days {
  if (_days is EqualUnmodifiableMapView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_days);
}


/// Create a copy of GeneratedPlanModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedPlanModelCopyWith<_GeneratedPlanModel> get copyWith => __$GeneratedPlanModelCopyWithImpl<_GeneratedPlanModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedPlanModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalCalculatedCost, totalCalculatedCost) || other.totalCalculatedCost == totalCalculatedCost)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&const DeepCollectionEquality().equals(other._accommodation, _accommodation)&&const DeepCollectionEquality().equals(other._days, _days));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,status,people,totalCalculatedCost,daysCount,const DeepCollectionEquality().hash(_accommodation),const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'GeneratedPlanModel(tripId: $tripId, status: $status, people: $people, totalCalculatedCost: $totalCalculatedCost, daysCount: $daysCount, accommodation: $accommodation, days: $days)';
}


}

/// @nodoc
abstract mixin class _$GeneratedPlanModelCopyWith<$Res> implements $GeneratedPlanModelCopyWith<$Res> {
  factory _$GeneratedPlanModelCopyWith(_GeneratedPlanModel value, $Res Function(_GeneratedPlanModel) _then) = __$GeneratedPlanModelCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String status, int people, double totalCalculatedCost, int daysCount, List<PlanPlaceModel> accommodation, Map<int, DayPlanModel> days
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
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? status = null,Object? people = null,Object? totalCalculatedCost = null,Object? daysCount = null,Object? accommodation = null,Object? days = null,}) {
  return _then(_GeneratedPlanModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalCalculatedCost: null == totalCalculatedCost ? _self.totalCalculatedCost : totalCalculatedCost // ignore: cast_nullable_to_non_nullable
as double,daysCount: null == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int,accommodation: null == accommodation ? _self._accommodation : accommodation // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as Map<int, DayPlanModel>,
  ));
}


}

// dart format on
