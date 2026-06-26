// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TripModel {

 String get tripId; String get title; String get destinationGovernorate; String get city; DateTime get startDate; DateTime get endDate; int get durationDays; int get people; int get totalBudgetEgp; int get totalCost; String get status; String get shareToken; bool get isPublic; String get sessionId;@JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson) CollectedDataModel get collected; String get coverImageUrl; int get placesCount; int get progressPercent; DateTime get createdAt; DateTime get updatedAt; GeneratedPlanModel get plan;
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripModelCopyWith<TripModel> get copyWith => _$TripModelCopyWithImpl<TripModel>(this as TripModel, _$identity);

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.destinationGovernorate, destinationGovernorate) || other.destinationGovernorate == destinationGovernorate)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalBudgetEgp, totalBudgetEgp) || other.totalBudgetEgp == totalBudgetEgp)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.status, status) || other.status == status)&&(identical(other.shareToken, shareToken) || other.shareToken == shareToken)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.collected, collected) || other.collected == collected)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.placesCount, placesCount) || other.placesCount == placesCount)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tripId,title,destinationGovernorate,city,startDate,endDate,durationDays,people,totalBudgetEgp,totalCost,status,shareToken,isPublic,sessionId,collected,coverImageUrl,placesCount,progressPercent,createdAt,updatedAt,plan]);

@override
String toString() {
  return 'TripModel(tripId: $tripId, title: $title, destinationGovernorate: $destinationGovernorate, city: $city, startDate: $startDate, endDate: $endDate, durationDays: $durationDays, people: $people, totalBudgetEgp: $totalBudgetEgp, totalCost: $totalCost, status: $status, shareToken: $shareToken, isPublic: $isPublic, sessionId: $sessionId, collected: $collected, coverImageUrl: $coverImageUrl, placesCount: $placesCount, progressPercent: $progressPercent, createdAt: $createdAt, updatedAt: $updatedAt, plan: $plan)';
}


}

/// @nodoc
abstract mixin class $TripModelCopyWith<$Res>  {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) _then) = _$TripModelCopyWithImpl;
@useResult
$Res call({
 String tripId, String title, String destinationGovernorate, String city, DateTime startDate, DateTime endDate, int durationDays, int people, int totalBudgetEgp, int totalCost, String status, String shareToken, bool isPublic, String sessionId,@JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson) CollectedDataModel collected, String coverImageUrl, int placesCount, int progressPercent, DateTime createdAt, DateTime updatedAt, GeneratedPlanModel plan
});


$CollectedDataModelCopyWith<$Res> get collected;$GeneratedPlanModelCopyWith<$Res> get plan;

}
/// @nodoc
class _$TripModelCopyWithImpl<$Res>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._self, this._then);

  final TripModel _self;
  final $Res Function(TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = null,Object? title = null,Object? destinationGovernorate = null,Object? city = null,Object? startDate = null,Object? endDate = null,Object? durationDays = null,Object? people = null,Object? totalBudgetEgp = null,Object? totalCost = null,Object? status = null,Object? shareToken = null,Object? isPublic = null,Object? sessionId = null,Object? collected = null,Object? coverImageUrl = null,Object? placesCount = null,Object? progressPercent = null,Object? createdAt = null,Object? updatedAt = null,Object? plan = null,}) {
  return _then(_self.copyWith(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,destinationGovernorate: null == destinationGovernorate ? _self.destinationGovernorate : destinationGovernorate // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalBudgetEgp: null == totalBudgetEgp ? _self.totalBudgetEgp : totalBudgetEgp // ignore: cast_nullable_to_non_nullable
as int,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,shareToken: null == shareToken ? _self.shareToken : shareToken // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,collected: null == collected ? _self.collected : collected // ignore: cast_nullable_to_non_nullable
as CollectedDataModel,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,placesCount: null == placesCount ? _self.placesCount : placesCount // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanModel,
  ));
}
/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectedDataModelCopyWith<$Res> get collected {
  
  return $CollectedDataModelCopyWith<$Res>(_self.collected, (value) {
    return _then(_self.copyWith(collected: value));
  });
}/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneratedPlanModelCopyWith<$Res> get plan {
  
  return $GeneratedPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [TripModel].
extension TripModelPatterns on TripModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripModel value)  $default,){
final _that = this;
switch (_that) {
case _TripModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripModel value)?  $default,){
final _that = this;
switch (_that) {
case _TripModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripId,  String title,  String destinationGovernorate,  String city,  DateTime startDate,  DateTime endDate,  int durationDays,  int people,  int totalBudgetEgp,  int totalCost,  String status,  String shareToken,  bool isPublic,  String sessionId, @JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson)  CollectedDataModel collected,  String coverImageUrl,  int placesCount,  int progressPercent,  DateTime createdAt,  DateTime updatedAt,  GeneratedPlanModel plan)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.tripId,_that.title,_that.destinationGovernorate,_that.city,_that.startDate,_that.endDate,_that.durationDays,_that.people,_that.totalBudgetEgp,_that.totalCost,_that.status,_that.shareToken,_that.isPublic,_that.sessionId,_that.collected,_that.coverImageUrl,_that.placesCount,_that.progressPercent,_that.createdAt,_that.updatedAt,_that.plan);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripId,  String title,  String destinationGovernorate,  String city,  DateTime startDate,  DateTime endDate,  int durationDays,  int people,  int totalBudgetEgp,  int totalCost,  String status,  String shareToken,  bool isPublic,  String sessionId, @JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson)  CollectedDataModel collected,  String coverImageUrl,  int placesCount,  int progressPercent,  DateTime createdAt,  DateTime updatedAt,  GeneratedPlanModel plan)  $default,) {final _that = this;
switch (_that) {
case _TripModel():
return $default(_that.tripId,_that.title,_that.destinationGovernorate,_that.city,_that.startDate,_that.endDate,_that.durationDays,_that.people,_that.totalBudgetEgp,_that.totalCost,_that.status,_that.shareToken,_that.isPublic,_that.sessionId,_that.collected,_that.coverImageUrl,_that.placesCount,_that.progressPercent,_that.createdAt,_that.updatedAt,_that.plan);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripId,  String title,  String destinationGovernorate,  String city,  DateTime startDate,  DateTime endDate,  int durationDays,  int people,  int totalBudgetEgp,  int totalCost,  String status,  String shareToken,  bool isPublic,  String sessionId, @JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson)  CollectedDataModel collected,  String coverImageUrl,  int placesCount,  int progressPercent,  DateTime createdAt,  DateTime updatedAt,  GeneratedPlanModel plan)?  $default,) {final _that = this;
switch (_that) {
case _TripModel() when $default != null:
return $default(_that.tripId,_that.title,_that.destinationGovernorate,_that.city,_that.startDate,_that.endDate,_that.durationDays,_that.people,_that.totalBudgetEgp,_that.totalCost,_that.status,_that.shareToken,_that.isPublic,_that.sessionId,_that.collected,_that.coverImageUrl,_that.placesCount,_that.progressPercent,_that.createdAt,_that.updatedAt,_that.plan);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TripModel implements TripModel {
  const _TripModel({required this.tripId, required this.title, required this.destinationGovernorate, required this.city, required this.startDate, required this.endDate, required this.durationDays, required this.people, required this.totalBudgetEgp, required this.totalCost, required this.status, required this.shareToken, required this.isPublic, required this.sessionId, @JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson) required this.collected, required this.coverImageUrl, required this.placesCount, required this.progressPercent, required this.createdAt, required this.updatedAt, required this.plan});
  factory _TripModel.fromJson(Map<String, dynamic> json) => _$TripModelFromJson(json);

@override final  String tripId;
@override final  String title;
@override final  String destinationGovernorate;
@override final  String city;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  int durationDays;
@override final  int people;
@override final  int totalBudgetEgp;
@override final  int totalCost;
@override final  String status;
@override final  String shareToken;
@override final  bool isPublic;
@override final  String sessionId;
@override@JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson) final  CollectedDataModel collected;
@override final  String coverImageUrl;
@override final  int placesCount;
@override final  int progressPercent;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  GeneratedPlanModel plan;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripModelCopyWith<_TripModel> get copyWith => __$TripModelCopyWithImpl<_TripModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TripModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripModel&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.title, title) || other.title == title)&&(identical(other.destinationGovernorate, destinationGovernorate) || other.destinationGovernorate == destinationGovernorate)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays)&&(identical(other.people, people) || other.people == people)&&(identical(other.totalBudgetEgp, totalBudgetEgp) || other.totalBudgetEgp == totalBudgetEgp)&&(identical(other.totalCost, totalCost) || other.totalCost == totalCost)&&(identical(other.status, status) || other.status == status)&&(identical(other.shareToken, shareToken) || other.shareToken == shareToken)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.collected, collected) || other.collected == collected)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.placesCount, placesCount) || other.placesCount == placesCount)&&(identical(other.progressPercent, progressPercent) || other.progressPercent == progressPercent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.plan, plan) || other.plan == plan));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,tripId,title,destinationGovernorate,city,startDate,endDate,durationDays,people,totalBudgetEgp,totalCost,status,shareToken,isPublic,sessionId,collected,coverImageUrl,placesCount,progressPercent,createdAt,updatedAt,plan]);

@override
String toString() {
  return 'TripModel(tripId: $tripId, title: $title, destinationGovernorate: $destinationGovernorate, city: $city, startDate: $startDate, endDate: $endDate, durationDays: $durationDays, people: $people, totalBudgetEgp: $totalBudgetEgp, totalCost: $totalCost, status: $status, shareToken: $shareToken, isPublic: $isPublic, sessionId: $sessionId, collected: $collected, coverImageUrl: $coverImageUrl, placesCount: $placesCount, progressPercent: $progressPercent, createdAt: $createdAt, updatedAt: $updatedAt, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$TripModelCopyWith<$Res> implements $TripModelCopyWith<$Res> {
  factory _$TripModelCopyWith(_TripModel value, $Res Function(_TripModel) _then) = __$TripModelCopyWithImpl;
@override @useResult
$Res call({
 String tripId, String title, String destinationGovernorate, String city, DateTime startDate, DateTime endDate, int durationDays, int people, int totalBudgetEgp, int totalCost, String status, String shareToken, bool isPublic, String sessionId,@JsonKey(name: 'collectedJson', fromJson: TripModel._collectedFromJson, toJson: TripModel._collectedToJson) CollectedDataModel collected, String coverImageUrl, int placesCount, int progressPercent, DateTime createdAt, DateTime updatedAt, GeneratedPlanModel plan
});


@override $CollectedDataModelCopyWith<$Res> get collected;@override $GeneratedPlanModelCopyWith<$Res> get plan;

}
/// @nodoc
class __$TripModelCopyWithImpl<$Res>
    implements _$TripModelCopyWith<$Res> {
  __$TripModelCopyWithImpl(this._self, this._then);

  final _TripModel _self;
  final $Res Function(_TripModel) _then;

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = null,Object? title = null,Object? destinationGovernorate = null,Object? city = null,Object? startDate = null,Object? endDate = null,Object? durationDays = null,Object? people = null,Object? totalBudgetEgp = null,Object? totalCost = null,Object? status = null,Object? shareToken = null,Object? isPublic = null,Object? sessionId = null,Object? collected = null,Object? coverImageUrl = null,Object? placesCount = null,Object? progressPercent = null,Object? createdAt = null,Object? updatedAt = null,Object? plan = null,}) {
  return _then(_TripModel(
tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,destinationGovernorate: null == destinationGovernorate ? _self.destinationGovernorate : destinationGovernorate // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,durationDays: null == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,totalBudgetEgp: null == totalBudgetEgp ? _self.totalBudgetEgp : totalBudgetEgp // ignore: cast_nullable_to_non_nullable
as int,totalCost: null == totalCost ? _self.totalCost : totalCost // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,shareToken: null == shareToken ? _self.shareToken : shareToken // ignore: cast_nullable_to_non_nullable
as String,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,collected: null == collected ? _self.collected : collected // ignore: cast_nullable_to_non_nullable
as CollectedDataModel,coverImageUrl: null == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String,placesCount: null == placesCount ? _self.placesCount : placesCount // ignore: cast_nullable_to_non_nullable
as int,progressPercent: null == progressPercent ? _self.progressPercent : progressPercent // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanModel,
  ));
}

/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CollectedDataModelCopyWith<$Res> get collected {
  
  return $CollectedDataModelCopyWith<$Res>(_self.collected, (value) {
    return _then(_self.copyWith(collected: value));
  });
}/// Create a copy of TripModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeneratedPlanModelCopyWith<$Res> get plan {
  
  return $GeneratedPlanModelCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

// dart format on
