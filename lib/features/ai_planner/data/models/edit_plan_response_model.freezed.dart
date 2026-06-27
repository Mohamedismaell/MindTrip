// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_plan_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditPlanResponseModel {

 String get mode; String? get message;@JsonKey(name: 'trip_id') String? get tripId; String? get status;@JsonKey(name: 'change_applied') String? get changeApplied;@JsonKey(name: 'ask_for_replacement') bool? get askForReplacement;@JsonKey(name: 'insert_after') String? get insertAfter; PlanPlaceModel? get item; int? get people;@JsonKey(name: 'total_calculated_cost') double? get totalCalculatedCost;@JsonKey(name: 'days_count') int? get daysCount;@JsonKey(name: 'needs_replan') bool? get needsReplan; GeneratedPlanModel? get plan;
/// Create a copy of EditPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditPlanResponseModelCopyWith<EditPlanResponseModel> get copyWith => _$EditPlanResponseModelCopyWithImpl<EditPlanResponseModel>(this as EditPlanResponseModel, _$identity);

  /// Serializes this EditPlanResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPlanResponseModel&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.message, message) || other.message == message)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.changeApplied, changeApplied) || other.changeApplied == changeApplied)&&(identical(other.askForReplacement, askForReplacement) || other.askForReplacement == askForReplacement)&&(identical(other.insertAfter, insertAfter) || other.insertAfter == insertAfter)&&(identical(other.item, item) || other.item == item)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalCalculatedCost, totalCalculatedCost) || other.totalCalculatedCost == totalCalculatedCost)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&(identical(other.needsReplan, needsReplan) || other.needsReplan == needsReplan)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,message,tripId,status,changeApplied,askForReplacement,insertAfter,item,people,totalCalculatedCost,daysCount,needsReplan,plan);

@override
String toString() {
  return 'EditPlanResponseModel(mode: $mode, message: $message, tripId: $tripId, status: $status, changeApplied: $changeApplied, askForReplacement: $askForReplacement, insertAfter: $insertAfter, item: $item, people: $people, totalCalculatedCost: $totalCalculatedCost, daysCount: $daysCount, needsReplan: $needsReplan, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $EditPlanResponseModelCopyWith<$Res>  {
  factory $EditPlanResponseModelCopyWith(EditPlanResponseModel value, $Res Function(EditPlanResponseModel) _then) = _$EditPlanResponseModelCopyWithImpl;
@useResult
$Res call({
 String mode, String? message,@JsonKey(name: 'trip_id') String? tripId, String? status,@JsonKey(name: 'change_applied') String? changeApplied,@JsonKey(name: 'ask_for_replacement') bool? askForReplacement,@JsonKey(name: 'insert_after') String? insertAfter, PlanPlaceModel? item, int? people,@JsonKey(name: 'total_calculated_cost') double? totalCalculatedCost,@JsonKey(name: 'days_count') int? daysCount,@JsonKey(name: 'needs_replan') bool? needsReplan, GeneratedPlanModel? plan
});




}
/// @nodoc
class _$EditPlanResponseModelCopyWithImpl<$Res>
    implements $EditPlanResponseModelCopyWith<$Res> {
  _$EditPlanResponseModelCopyWithImpl(this._self, this._then);

  final EditPlanResponseModel _self;
  final $Res Function(EditPlanResponseModel) _then;

/// Create a copy of EditPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? message = freezed,Object? tripId = freezed,Object? status = freezed,Object? changeApplied = freezed,Object? askForReplacement = freezed,Object? insertAfter = freezed,Object? item = freezed,Object? people = freezed,Object? totalCalculatedCost = freezed,Object? daysCount = freezed,Object? needsReplan = freezed,Object? plan = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,changeApplied: freezed == changeApplied ? _self.changeApplied : changeApplied // ignore: cast_nullable_to_non_nullable
as String?,askForReplacement: freezed == askForReplacement ? _self.askForReplacement : askForReplacement // ignore: cast_nullable_to_non_nullable
as bool?,insertAfter: freezed == insertAfter ? _self.insertAfter : insertAfter // ignore: cast_nullable_to_non_nullable
as String?,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as PlanPlaceModel?,people: freezed == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int?,totalCalculatedCost: freezed == totalCalculatedCost ? _self.totalCalculatedCost : totalCalculatedCost // ignore: cast_nullable_to_non_nullable
as double?,daysCount: freezed == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int?,needsReplan: freezed == needsReplan ? _self.needsReplan : needsReplan // ignore: cast_nullable_to_non_nullable
as bool?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditPlanResponseModel].
extension EditPlanResponseModelPatterns on EditPlanResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditPlanResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditPlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditPlanResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _EditPlanResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditPlanResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _EditPlanResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mode,  String? message, @JsonKey(name: 'trip_id')  String? tripId,  String? status, @JsonKey(name: 'change_applied')  String? changeApplied, @JsonKey(name: 'ask_for_replacement')  bool? askForReplacement, @JsonKey(name: 'insert_after')  String? insertAfter,  PlanPlaceModel? item,  int? people, @JsonKey(name: 'total_calculated_cost')  double? totalCalculatedCost, @JsonKey(name: 'days_count')  int? daysCount, @JsonKey(name: 'needs_replan')  bool? needsReplan,  GeneratedPlanModel? plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditPlanResponseModel() when $default != null:
return $default(_that.mode,_that.message,_that.tripId,_that.status,_that.changeApplied,_that.askForReplacement,_that.insertAfter,_that.item,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.needsReplan,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mode,  String? message, @JsonKey(name: 'trip_id')  String? tripId,  String? status, @JsonKey(name: 'change_applied')  String? changeApplied, @JsonKey(name: 'ask_for_replacement')  bool? askForReplacement, @JsonKey(name: 'insert_after')  String? insertAfter,  PlanPlaceModel? item,  int? people, @JsonKey(name: 'total_calculated_cost')  double? totalCalculatedCost, @JsonKey(name: 'days_count')  int? daysCount, @JsonKey(name: 'needs_replan')  bool? needsReplan,  GeneratedPlanModel? plan)  $default,) {final _that = this;
switch (_that) {
case _EditPlanResponseModel():
return $default(_that.mode,_that.message,_that.tripId,_that.status,_that.changeApplied,_that.askForReplacement,_that.insertAfter,_that.item,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.needsReplan,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mode,  String? message, @JsonKey(name: 'trip_id')  String? tripId,  String? status, @JsonKey(name: 'change_applied')  String? changeApplied, @JsonKey(name: 'ask_for_replacement')  bool? askForReplacement, @JsonKey(name: 'insert_after')  String? insertAfter,  PlanPlaceModel? item,  int? people, @JsonKey(name: 'total_calculated_cost')  double? totalCalculatedCost, @JsonKey(name: 'days_count')  int? daysCount, @JsonKey(name: 'needs_replan')  bool? needsReplan,  GeneratedPlanModel? plan)?  $default,) {final _that = this;
switch (_that) {
case _EditPlanResponseModel() when $default != null:
return $default(_that.mode,_that.message,_that.tripId,_that.status,_that.changeApplied,_that.askForReplacement,_that.insertAfter,_that.item,_that.people,_that.totalCalculatedCost,_that.daysCount,_that.needsReplan,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EditPlanResponseModel implements EditPlanResponseModel {
  const _EditPlanResponseModel({required this.mode, this.message, @JsonKey(name: 'trip_id') this.tripId, this.status, @JsonKey(name: 'change_applied') this.changeApplied, @JsonKey(name: 'ask_for_replacement') this.askForReplacement, @JsonKey(name: 'insert_after') this.insertAfter, this.item, this.people, @JsonKey(name: 'total_calculated_cost') this.totalCalculatedCost, @JsonKey(name: 'days_count') this.daysCount, @JsonKey(name: 'needs_replan') this.needsReplan, this.plan});
  factory _EditPlanResponseModel.fromJson(Map<String, dynamic> json) => _$EditPlanResponseModelFromJson(json);

@override final  String mode;
@override final  String? message;
@override@JsonKey(name: 'trip_id') final  String? tripId;
@override final  String? status;
@override@JsonKey(name: 'change_applied') final  String? changeApplied;
@override@JsonKey(name: 'ask_for_replacement') final  bool? askForReplacement;
@override@JsonKey(name: 'insert_after') final  String? insertAfter;
@override final  PlanPlaceModel? item;
@override final  int? people;
@override@JsonKey(name: 'total_calculated_cost') final  double? totalCalculatedCost;
@override@JsonKey(name: 'days_count') final  int? daysCount;
@override@JsonKey(name: 'needs_replan') final  bool? needsReplan;
@override final  GeneratedPlanModel? plan;

/// Create a copy of EditPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditPlanResponseModelCopyWith<_EditPlanResponseModel> get copyWith => __$EditPlanResponseModelCopyWithImpl<_EditPlanResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EditPlanResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditPlanResponseModel&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.message, message) || other.message == message)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.status, status) || other.status == status)&&(identical(other.changeApplied, changeApplied) || other.changeApplied == changeApplied)&&(identical(other.askForReplacement, askForReplacement) || other.askForReplacement == askForReplacement)&&(identical(other.insertAfter, insertAfter) || other.insertAfter == insertAfter)&&(identical(other.item, item) || other.item == item)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalCalculatedCost, totalCalculatedCost) || other.totalCalculatedCost == totalCalculatedCost)&&(identical(other.daysCount, daysCount) || other.daysCount == daysCount)&&(identical(other.needsReplan, needsReplan) || other.needsReplan == needsReplan)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,message,tripId,status,changeApplied,askForReplacement,insertAfter,item,people,totalCalculatedCost,daysCount,needsReplan,plan);

@override
String toString() {
  return 'EditPlanResponseModel(mode: $mode, message: $message, tripId: $tripId, status: $status, changeApplied: $changeApplied, askForReplacement: $askForReplacement, insertAfter: $insertAfter, item: $item, people: $people, totalCalculatedCost: $totalCalculatedCost, daysCount: $daysCount, needsReplan: $needsReplan, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$EditPlanResponseModelCopyWith<$Res> implements $EditPlanResponseModelCopyWith<$Res> {
  factory _$EditPlanResponseModelCopyWith(_EditPlanResponseModel value, $Res Function(_EditPlanResponseModel) _then) = __$EditPlanResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String mode, String? message,@JsonKey(name: 'trip_id') String? tripId, String? status,@JsonKey(name: 'change_applied') String? changeApplied,@JsonKey(name: 'ask_for_replacement') bool? askForReplacement,@JsonKey(name: 'insert_after') String? insertAfter, PlanPlaceModel? item, int? people,@JsonKey(name: 'total_calculated_cost') double? totalCalculatedCost,@JsonKey(name: 'days_count') int? daysCount,@JsonKey(name: 'needs_replan') bool? needsReplan, GeneratedPlanModel? plan
});




}
/// @nodoc
class __$EditPlanResponseModelCopyWithImpl<$Res>
    implements _$EditPlanResponseModelCopyWith<$Res> {
  __$EditPlanResponseModelCopyWithImpl(this._self, this._then);

  final _EditPlanResponseModel _self;
  final $Res Function(_EditPlanResponseModel) _then;

/// Create a copy of EditPlanResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? message = freezed,Object? tripId = freezed,Object? status = freezed,Object? changeApplied = freezed,Object? askForReplacement = freezed,Object? insertAfter = freezed,Object? item = freezed,Object? people = freezed,Object? totalCalculatedCost = freezed,Object? daysCount = freezed,Object? needsReplan = freezed,Object? plan = freezed,}) {
  return _then(_EditPlanResponseModel(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,changeApplied: freezed == changeApplied ? _self.changeApplied : changeApplied // ignore: cast_nullable_to_non_nullable
as String?,askForReplacement: freezed == askForReplacement ? _self.askForReplacement : askForReplacement // ignore: cast_nullable_to_non_nullable
as bool?,insertAfter: freezed == insertAfter ? _self.insertAfter : insertAfter // ignore: cast_nullable_to_non_nullable
as String?,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as PlanPlaceModel?,people: freezed == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int?,totalCalculatedCost: freezed == totalCalculatedCost ? _self.totalCalculatedCost : totalCalculatedCost // ignore: cast_nullable_to_non_nullable
as double?,daysCount: freezed == daysCount ? _self.daysCount : daysCount // ignore: cast_nullable_to_non_nullable
as int?,needsReplan: freezed == needsReplan ? _self.needsReplan : needsReplan // ignore: cast_nullable_to_non_nullable
as bool?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanModel?,
  ));
}


}

// dart format on
