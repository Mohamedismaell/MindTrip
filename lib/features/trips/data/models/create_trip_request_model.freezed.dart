// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_trip_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateTripRequestModel {

 String get title; String get destinationGovernorate; String get city; String? get startDate; String? get endDate; int get people; int get totalBudgetEgp; int get totalCost; GeneratedPlanModel get plan; CollectedDataModel get collected; String? get sessionId; bool get isPublic;
/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTripRequestModelCopyWith<CreateTripRequestModel> get copyWith => _$CreateTripRequestModelCopyWithImpl<CreateTripRequestModel>(this as CreateTripRequestModel, _$identity);

  /// Serializes this CreateTripRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTripRequestModel&&(identical(other.title, title) || other.title == title)&&(identical(other.destinationGovernorate, destinationGovernorate) || other.destinationGovernorate == destinationGovernorate)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalBudgetEgp, totalBudgetEgp) || other.totalBudgetEgp == totalBudgetEgp)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.collected, collected) || other.collected == collected)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,destinationGovernorate,city,startDate,endDate,people,totalBudgetEgp,totalCost,plan,collected,sessionId,isPublic);

@override
String toString() {
  return 'CreateTripRequestModel(title: $title, destinationGovernorate: $destinationGovernorate, city: $city, startDate: $startDate, endDate: $endDate, people: $people, totalBudgetEgp: $totalBudgetEgp, totalCost: $totalCost, plan: $plan, collected: $collected, sessionId: $sessionId, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class $CreateTripRequestModelCopyWith<$Res>  {
  factory $CreateTripRequestModelCopyWith(CreateTripRequestModel value, $Res Function(CreateTripRequestModel) _then) = _$CreateTripRequestModelCopyWithImpl;
@useResult
$Res call({
 String title, String destinationGovernorate, String city, String? startDate, String? endDate, int people, int totalBudgetEgp, int totalCost, GeneratedPlanModel plan, CollectedDataModel collected, String? sessionId, bool isPublic
});


$GeneratedPlanModelCopyWith<$Res> get plan;$CollectedDataModelCopyWith<$Res> get collected;

}
/// @nodoc
class _$CreateTripRequestModelCopyWithImpl<$Res>
    implements $CreateTripRequestModelCopyWith<$Res> {
  _$CreateTripRequestModelCopyWithImpl(this._self, this._then);

  final CreateTripRequestModel _self;
  final $Res Function(CreateTripRequestModel) _then;

/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? destinationGovernorate = null,Object? city = null,Object? startDate = freezed,Object? endDate = freezed,Object? people = null,Object? totalBudgetEgp = null,Object? totalCost = null,Object? plan = null,Object? collected = null,Object? sessionId = freezed,Object? isPublic = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,destinationGovernorate: null == destinationGovernorate ? _self.destinationGovernorate : destinationGovernorate // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalBudgetEgp: null == totalBudgetEgp ? _self.totalBudgetEgp : totalBudgetEgp // ignore: cast_nullable_to_non_nullable
as int,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as int,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanModel,collected: null == collected ? _self.collected : collected // ignore: cast_nullable_to_non_nullable
as CollectedDataModel,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneratedPlanModelCopyWith<$Res> get plan {
  
  return $GeneratedPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectedDataModelCopyWith<$Res> get collected {
  
  return $CollectedDataModelCopyWith<$Res>(_self.collected, (value) {
    return _then(_self.copyWith(collected: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateTripRequestModel].
extension CreateTripRequestModelPatterns on CreateTripRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTripRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTripRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTripRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _CreateTripRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTripRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTripRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String destinationGovernorate,  String city,  String? startDate,  String? endDate,  int people,  int totalBudgetEgp,  int totalCost,  GeneratedPlanModel plan,  CollectedDataModel collected,  String? sessionId,  bool isPublic)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTripRequestModel() when $default != null:
return $default(_that.title,_that.destinationGovernorate,_that.city,_that.startDate,_that.endDate,_that.people,_that.totalBudgetEgp,_that.totalCost,_that.plan,_that.collected,_that.sessionId,_that.isPublic);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String destinationGovernorate,  String city,  String? startDate,  String? endDate,  int people,  int totalBudgetEgp,  int totalCost,  GeneratedPlanModel plan,  CollectedDataModel collected,  String? sessionId,  bool isPublic)  $default,) {final _that = this;
switch (_that) {
case _CreateTripRequestModel():
return $default(_that.title,_that.destinationGovernorate,_that.city,_that.startDate,_that.endDate,_that.people,_that.totalBudgetEgp,_that.totalCost,_that.plan,_that.collected,_that.sessionId,_that.isPublic);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String destinationGovernorate,  String city,  String? startDate,  String? endDate,  int people,  int totalBudgetEgp,  int totalCost,  GeneratedPlanModel plan,  CollectedDataModel collected,  String? sessionId,  bool isPublic)?  $default,) {final _that = this;
switch (_that) {
case _CreateTripRequestModel() when $default != null:
return $default(_that.title,_that.destinationGovernorate,_that.city,_that.startDate,_that.endDate,_that.people,_that.totalBudgetEgp,_that.totalCost,_that.plan,_that.collected,_that.sessionId,_that.isPublic);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateTripRequestModel implements CreateTripRequestModel {
  const _CreateTripRequestModel({required this.title, required this.destinationGovernorate, required this.city, this.startDate, this.endDate, required this.people, required this.totalBudgetEgp, required this.totalCost, required this.plan, required this.collected, this.sessionId, required this.isPublic});
  factory _CreateTripRequestModel.fromJson(Map<String, dynamic> json) => _$CreateTripRequestModelFromJson(json);

@override final  String title;
@override final  String destinationGovernorate;
@override final  String city;
@override final  String? startDate;
@override final  String? endDate;
@override final  int people;
@override final  int totalBudgetEgp;
@override final  int totalCost;
@override final  GeneratedPlanModel plan;
@override final  CollectedDataModel collected;
@override final  String? sessionId;
@override final  bool isPublic;

/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTripRequestModelCopyWith<_CreateTripRequestModel> get copyWith => __$CreateTripRequestModelCopyWithImpl<_CreateTripRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateTripRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTripRequestModel&&(identical(other.title, title) || other.title == title)&&(identical(other.destinationGovernorate, destinationGovernorate) || other.destinationGovernorate == destinationGovernorate)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalBudgetEgp, totalBudgetEgp) || other.totalBudgetEgp == totalBudgetEgp)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.collected, collected) || other.collected == collected)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,destinationGovernorate,city,startDate,endDate,people,totalBudgetEgp,totalCost,plan,collected,sessionId,isPublic);

@override
String toString() {
  return 'CreateTripRequestModel(title: $title, destinationGovernorate: $destinationGovernorate, city: $city, startDate: $startDate, endDate: $endDate, people: $people, totalBudgetEgp: $totalBudgetEgp, totalCost: $totalCost, plan: $plan, collected: $collected, sessionId: $sessionId, isPublic: $isPublic)';
}


}

/// @nodoc
abstract mixin class _$CreateTripRequestModelCopyWith<$Res> implements $CreateTripRequestModelCopyWith<$Res> {
  factory _$CreateTripRequestModelCopyWith(_CreateTripRequestModel value, $Res Function(_CreateTripRequestModel) _then) = __$CreateTripRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String destinationGovernorate, String city, String? startDate, String? endDate, int people, int totalBudgetEgp, int totalCost, GeneratedPlanModel plan, CollectedDataModel collected, String? sessionId, bool isPublic
});


@override $GeneratedPlanModelCopyWith<$Res> get plan;@override $CollectedDataModelCopyWith<$Res> get collected;

}
/// @nodoc
class __$CreateTripRequestModelCopyWithImpl<$Res>
    implements _$CreateTripRequestModelCopyWith<$Res> {
  __$CreateTripRequestModelCopyWithImpl(this._self, this._then);

  final _CreateTripRequestModel _self;
  final $Res Function(_CreateTripRequestModel) _then;

/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? destinationGovernorate = null,Object? city = null,Object? startDate = freezed,Object? endDate = freezed,Object? people = null,Object? totalBudgetEgp = null,Object? totalCost = null,Object? plan = null,Object? collected = null,Object? sessionId = freezed,Object? isPublic = null,}) {
  return _then(_CreateTripRequestModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,destinationGovernorate: null == destinationGovernorate ? _self.destinationGovernorate : destinationGovernorate // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalBudgetEgp: null == totalBudgetEgp ? _self.totalBudgetEgp : totalBudgetEgp // ignore: cast_nullable_to_non_nullable
as int,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as int,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanModel,collected: null == collected ? _self.collected : collected // ignore: cast_nullable_to_non_nullable
as CollectedDataModel,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneratedPlanModelCopyWith<$Res> get plan {
  
  return $GeneratedPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}/// Create a copy of CreateTripRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectedDataModelCopyWith<$Res> get collected {
  
  return $CollectedDataModelCopyWith<$Res>(_self.collected, (value) {
    return _then(_self.copyWith(collected: value));
  });
}
}

// dart format on
