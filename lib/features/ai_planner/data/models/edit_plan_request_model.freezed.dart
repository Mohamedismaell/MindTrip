// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_plan_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditPlanRequestModel {

@JsonKey(name: 'targetChange') String get targetChange; String get destination; String get city; int get days; int get budget; int get people; List<String> get interests;@JsonKey(name: 'existingPlan') List<PlanPlaceModel> get existingPlan; List<PlanPlaceModel> get places; List<ConversationTurnModel> get conversation;@JsonKey(name: 'tripId') String? get tripId;@JsonKey(name: 'mustInclude') List<String>? get mustInclude;@JsonKey(name: 'mode') String? get mode;@JsonKey(name: 'item') ItemToEdit? get item;
/// Create a copy of EditPlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditPlanRequestModelCopyWith<EditPlanRequestModel> get copyWith => _$EditPlanRequestModelCopyWithImpl<EditPlanRequestModel>(this as EditPlanRequestModel, _$identity);

  /// Serializes this EditPlanRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditPlanRequestModel&&(identical(other.targetChange, targetChange) || other.targetChange == targetChange)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.city, city) || other.city == city)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other.interests, interests)&&const DeepCollectionEquality().equals(other.existingPlan, existingPlan)&&const DeepCollectionEquality().equals(other.places, places)&&const DeepCollectionEquality().equals(other.conversation, conversation)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&const DeepCollectionEquality().equals(other.mustInclude, mustInclude)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetChange,destination,city,days,budget,people,const DeepCollectionEquality().hash(interests),const DeepCollectionEquality().hash(existingPlan),const DeepCollectionEquality().hash(places),const DeepCollectionEquality().hash(conversation),tripId,const DeepCollectionEquality().hash(mustInclude),mode,item);

@override
String toString() {
  return 'EditPlanRequestModel(targetChange: $targetChange, destination: $destination, city: $city, days: $days, budget: $budget, people: $people, interests: $interests, existingPlan: $existingPlan, places: $places, conversation: $conversation, tripId: $tripId, mustInclude: $mustInclude, mode: $mode, item: $item)';
}


}

/// @nodoc
abstract mixin class $EditPlanRequestModelCopyWith<$Res>  {
  factory $EditPlanRequestModelCopyWith(EditPlanRequestModel value, $Res Function(EditPlanRequestModel) _then) = _$EditPlanRequestModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'targetChange') String targetChange, String destination, String city, int days, int budget, int people, List<String> interests,@JsonKey(name: 'existingPlan') List<PlanPlaceModel> existingPlan, List<PlanPlaceModel> places, List<ConversationTurnModel> conversation,@JsonKey(name: 'tripId') String? tripId,@JsonKey(name: 'mustInclude') List<String>? mustInclude,@JsonKey(name: 'mode') String? mode,@JsonKey(name: 'item') ItemToEdit? item
});


$ItemToEditCopyWith<$Res>? get item;

}
/// @nodoc
class _$EditPlanRequestModelCopyWithImpl<$Res>
    implements $EditPlanRequestModelCopyWith<$Res> {
  _$EditPlanRequestModelCopyWithImpl(this._self, this._then);

  final EditPlanRequestModel _self;
  final $Res Function(EditPlanRequestModel) _then;

/// Create a copy of EditPlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetChange = null,Object? destination = null,Object? city = null,Object? days = null,Object? budget = null,Object? people = null,Object? interests = null,Object? existingPlan = null,Object? places = null,Object? conversation = null,Object? tripId = freezed,Object? mustInclude = freezed,Object? mode = freezed,Object? item = freezed,}) {
  return _then(_self.copyWith(
targetChange: null == targetChange ? _self.targetChange : targetChange // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,existingPlan: null == existingPlan ? _self.existingPlan : existingPlan // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,conversation: null == conversation ? _self.conversation : conversation // ignore: cast_nullable_to_non_nullable
as List<ConversationTurnModel>,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,mustInclude: freezed == mustInclude ? _self.mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as List<String>?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ItemToEdit?,
  ));
}
/// Create a copy of EditPlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemToEditCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $ItemToEditCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// Adds pattern-matching-related methods to [EditPlanRequestModel].
extension EditPlanRequestModelPatterns on EditPlanRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditPlanRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditPlanRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditPlanRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _EditPlanRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditPlanRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _EditPlanRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'targetChange')  String targetChange,  String destination,  String city,  int days,  int budget,  int people,  List<String> interests, @JsonKey(name: 'existingPlan')  List<PlanPlaceModel> existingPlan,  List<PlanPlaceModel> places,  List<ConversationTurnModel> conversation, @JsonKey(name: 'tripId')  String? tripId, @JsonKey(name: 'mustInclude')  List<String>? mustInclude, @JsonKey(name: 'mode')  String? mode, @JsonKey(name: 'item')  ItemToEdit? item)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditPlanRequestModel() when $default != null:
return $default(_that.targetChange,_that.destination,_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.existingPlan,_that.places,_that.conversation,_that.tripId,_that.mustInclude,_that.mode,_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'targetChange')  String targetChange,  String destination,  String city,  int days,  int budget,  int people,  List<String> interests, @JsonKey(name: 'existingPlan')  List<PlanPlaceModel> existingPlan,  List<PlanPlaceModel> places,  List<ConversationTurnModel> conversation, @JsonKey(name: 'tripId')  String? tripId, @JsonKey(name: 'mustInclude')  List<String>? mustInclude, @JsonKey(name: 'mode')  String? mode, @JsonKey(name: 'item')  ItemToEdit? item)  $default,) {final _that = this;
switch (_that) {
case _EditPlanRequestModel():
return $default(_that.targetChange,_that.destination,_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.existingPlan,_that.places,_that.conversation,_that.tripId,_that.mustInclude,_that.mode,_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'targetChange')  String targetChange,  String destination,  String city,  int days,  int budget,  int people,  List<String> interests, @JsonKey(name: 'existingPlan')  List<PlanPlaceModel> existingPlan,  List<PlanPlaceModel> places,  List<ConversationTurnModel> conversation, @JsonKey(name: 'tripId')  String? tripId, @JsonKey(name: 'mustInclude')  List<String>? mustInclude, @JsonKey(name: 'mode')  String? mode, @JsonKey(name: 'item')  ItemToEdit? item)?  $default,) {final _that = this;
switch (_that) {
case _EditPlanRequestModel() when $default != null:
return $default(_that.targetChange,_that.destination,_that.city,_that.days,_that.budget,_that.people,_that.interests,_that.existingPlan,_that.places,_that.conversation,_that.tripId,_that.mustInclude,_that.mode,_that.item);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EditPlanRequestModel implements EditPlanRequestModel {
  const _EditPlanRequestModel({@JsonKey(name: 'targetChange') required this.targetChange, required this.destination, required this.city, required this.days, required this.budget, required this.people, required final  List<String> interests, @JsonKey(name: 'existingPlan') required final  List<PlanPlaceModel> existingPlan, final  List<PlanPlaceModel> places = const [], final  List<ConversationTurnModel> conversation = const [], @JsonKey(name: 'tripId') this.tripId, @JsonKey(name: 'mustInclude') final  List<String>? mustInclude, @JsonKey(name: 'mode') this.mode, @JsonKey(name: 'item') this.item}): _interests = interests,_existingPlan = existingPlan,_places = places,_conversation = conversation,_mustInclude = mustInclude;
  factory _EditPlanRequestModel.fromJson(Map<String, dynamic> json) => _$EditPlanRequestModelFromJson(json);

@override@JsonKey(name: 'targetChange') final  String targetChange;
@override final  String destination;
@override final  String city;
@override final  int days;
@override final  int budget;
@override final  int people;
 final  List<String> _interests;
@override List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

 final  List<PlanPlaceModel> _existingPlan;
@override@JsonKey(name: 'existingPlan') List<PlanPlaceModel> get existingPlan {
  if (_existingPlan is EqualUnmodifiableListView) return _existingPlan;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_existingPlan);
}

 final  List<PlanPlaceModel> _places;
@override@JsonKey() List<PlanPlaceModel> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}

 final  List<ConversationTurnModel> _conversation;
@override@JsonKey() List<ConversationTurnModel> get conversation {
  if (_conversation is EqualUnmodifiableListView) return _conversation;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_conversation);
}

@override@JsonKey(name: 'tripId') final  String? tripId;
 final  List<String>? _mustInclude;
@override@JsonKey(name: 'mustInclude') List<String>? get mustInclude {
  final value = _mustInclude;
  if (value == null) return null;
  if (_mustInclude is EqualUnmodifiableListView) return _mustInclude;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'mode') final  String? mode;
@override@JsonKey(name: 'item') final  ItemToEdit? item;

/// Create a copy of EditPlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditPlanRequestModelCopyWith<_EditPlanRequestModel> get copyWith => __$EditPlanRequestModelCopyWithImpl<_EditPlanRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EditPlanRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditPlanRequestModel&&(identical(other.targetChange, targetChange) || other.targetChange == targetChange)&&(identical(other.destination, destination) || other.destination == destination)&&(identical(other.city, city) || other.city == city)&&(identical(other.days, days) || other.days == days)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other._interests, _interests)&&const DeepCollectionEquality().equals(other._existingPlan, _existingPlan)&&const DeepCollectionEquality().equals(other._places, _places)&&const DeepCollectionEquality().equals(other._conversation, _conversation)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&const DeepCollectionEquality().equals(other._mustInclude, _mustInclude)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.item, item) || other.item == item));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,targetChange,destination,city,days,budget,people,const DeepCollectionEquality().hash(_interests),const DeepCollectionEquality().hash(_existingPlan),const DeepCollectionEquality().hash(_places),const DeepCollectionEquality().hash(_conversation),tripId,const DeepCollectionEquality().hash(_mustInclude),mode,item);

@override
String toString() {
  return 'EditPlanRequestModel(targetChange: $targetChange, destination: $destination, city: $city, days: $days, budget: $budget, people: $people, interests: $interests, existingPlan: $existingPlan, places: $places, conversation: $conversation, tripId: $tripId, mustInclude: $mustInclude, mode: $mode, item: $item)';
}


}

/// @nodoc
abstract mixin class _$EditPlanRequestModelCopyWith<$Res> implements $EditPlanRequestModelCopyWith<$Res> {
  factory _$EditPlanRequestModelCopyWith(_EditPlanRequestModel value, $Res Function(_EditPlanRequestModel) _then) = __$EditPlanRequestModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'targetChange') String targetChange, String destination, String city, int days, int budget, int people, List<String> interests,@JsonKey(name: 'existingPlan') List<PlanPlaceModel> existingPlan, List<PlanPlaceModel> places, List<ConversationTurnModel> conversation,@JsonKey(name: 'tripId') String? tripId,@JsonKey(name: 'mustInclude') List<String>? mustInclude,@JsonKey(name: 'mode') String? mode,@JsonKey(name: 'item') ItemToEdit? item
});


@override $ItemToEditCopyWith<$Res>? get item;

}
/// @nodoc
class __$EditPlanRequestModelCopyWithImpl<$Res>
    implements _$EditPlanRequestModelCopyWith<$Res> {
  __$EditPlanRequestModelCopyWithImpl(this._self, this._then);

  final _EditPlanRequestModel _self;
  final $Res Function(_EditPlanRequestModel) _then;

/// Create a copy of EditPlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetChange = null,Object? destination = null,Object? city = null,Object? days = null,Object? budget = null,Object? people = null,Object? interests = null,Object? existingPlan = null,Object? places = null,Object? conversation = null,Object? tripId = freezed,Object? mustInclude = freezed,Object? mode = freezed,Object? item = freezed,}) {
  return _then(_EditPlanRequestModel(
targetChange: null == targetChange ? _self.targetChange : targetChange // ignore: cast_nullable_to_non_nullable
as String,destination: null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as int,people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as int,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,existingPlan: null == existingPlan ? _self._existingPlan : existingPlan // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<PlanPlaceModel>,conversation: null == conversation ? _self._conversation : conversation // ignore: cast_nullable_to_non_nullable
as List<ConversationTurnModel>,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,mustInclude: freezed == mustInclude ? _self._mustInclude : mustInclude // ignore: cast_nullable_to_non_nullable
as List<String>?,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String?,item: freezed == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as ItemToEdit?,
  ));
}

/// Create a copy of EditPlanRequestModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ItemToEditCopyWith<$Res>? get item {
    if (_self.item == null) {
    return null;
  }

  return $ItemToEditCopyWith<$Res>(_self.item!, (value) {
    return _then(_self.copyWith(item: value));
  });
}
}


/// @nodoc
mixin _$ItemToEdit {

@JsonKey(name: 'place_id') String? get placeId;@JsonKey(name: 'name') String? get name;
/// Create a copy of ItemToEdit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ItemToEditCopyWith<ItemToEdit> get copyWith => _$ItemToEditCopyWithImpl<ItemToEdit>(this as ItemToEdit, _$identity);

  /// Serializes this ItemToEdit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ItemToEdit&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,name);

@override
String toString() {
  return 'ItemToEdit(placeId: $placeId, name: $name)';
}


}

/// @nodoc
abstract mixin class $ItemToEditCopyWith<$Res>  {
  factory $ItemToEditCopyWith(ItemToEdit value, $Res Function(ItemToEdit) _then) = _$ItemToEditCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'place_id') String? placeId,@JsonKey(name: 'name') String? name
});




}
/// @nodoc
class _$ItemToEditCopyWithImpl<$Res>
    implements $ItemToEditCopyWith<$Res> {
  _$ItemToEditCopyWithImpl(this._self, this._then);

  final ItemToEdit _self;
  final $Res Function(ItemToEdit) _then;

/// Create a copy of ItemToEdit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ItemToEdit].
extension ItemToEditPatterns on ItemToEdit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ItemToEdit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ItemToEdit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ItemToEdit value)  $default,){
final _that = this;
switch (_that) {
case _ItemToEdit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ItemToEdit value)?  $default,){
final _that = this;
switch (_that) {
case _ItemToEdit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id')  String? placeId, @JsonKey(name: 'name')  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ItemToEdit() when $default != null:
return $default(_that.placeId,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id')  String? placeId, @JsonKey(name: 'name')  String? name)  $default,) {final _that = this;
switch (_that) {
case _ItemToEdit():
return $default(_that.placeId,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'place_id')  String? placeId, @JsonKey(name: 'name')  String? name)?  $default,) {final _that = this;
switch (_that) {
case _ItemToEdit() when $default != null:
return $default(_that.placeId,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ItemToEdit implements ItemToEdit {
  const _ItemToEdit({@JsonKey(name: 'place_id') this.placeId, @JsonKey(name: 'name') this.name});
  factory _ItemToEdit.fromJson(Map<String, dynamic> json) => _$ItemToEditFromJson(json);

@override@JsonKey(name: 'place_id') final  String? placeId;
@override@JsonKey(name: 'name') final  String? name;

/// Create a copy of ItemToEdit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ItemToEditCopyWith<_ItemToEdit> get copyWith => __$ItemToEditCopyWithImpl<_ItemToEdit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ItemToEditToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ItemToEdit&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,name);

@override
String toString() {
  return 'ItemToEdit(placeId: $placeId, name: $name)';
}


}

/// @nodoc
abstract mixin class _$ItemToEditCopyWith<$Res> implements $ItemToEditCopyWith<$Res> {
  factory _$ItemToEditCopyWith(_ItemToEdit value, $Res Function(_ItemToEdit) _then) = __$ItemToEditCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'place_id') String? placeId,@JsonKey(name: 'name') String? name
});




}
/// @nodoc
class __$ItemToEditCopyWithImpl<$Res>
    implements _$ItemToEditCopyWith<$Res> {
  __$ItemToEditCopyWithImpl(this._self, this._then);

  final _ItemToEdit _self;
  final $Res Function(_ItemToEdit) _then;

/// Create a copy of ItemToEdit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = freezed,Object? name = freezed,}) {
  return _then(_ItemToEdit(
placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConversationTurnModel {

 String get role; String get content;
/// Create a copy of ConversationTurnModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConversationTurnModelCopyWith<ConversationTurnModel> get copyWith => _$ConversationTurnModelCopyWithImpl<ConversationTurnModel>(this as ConversationTurnModel, _$identity);

  /// Serializes this ConversationTurnModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConversationTurnModel&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'ConversationTurnModel(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $ConversationTurnModelCopyWith<$Res>  {
  factory $ConversationTurnModelCopyWith(ConversationTurnModel value, $Res Function(ConversationTurnModel) _then) = _$ConversationTurnModelCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$ConversationTurnModelCopyWithImpl<$Res>
    implements $ConversationTurnModelCopyWith<$Res> {
  _$ConversationTurnModelCopyWithImpl(this._self, this._then);

  final ConversationTurnModel _self;
  final $Res Function(ConversationTurnModel) _then;

/// Create a copy of ConversationTurnModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConversationTurnModel].
extension ConversationTurnModelPatterns on ConversationTurnModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConversationTurnModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConversationTurnModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConversationTurnModel value)  $default,){
final _that = this;
switch (_that) {
case _ConversationTurnModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConversationTurnModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConversationTurnModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String role,  String content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConversationTurnModel() when $default != null:
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String role,  String content)  $default,) {final _that = this;
switch (_that) {
case _ConversationTurnModel():
return $default(_that.role,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String role,  String content)?  $default,) {final _that = this;
switch (_that) {
case _ConversationTurnModel() when $default != null:
return $default(_that.role,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConversationTurnModel implements ConversationTurnModel {
  const _ConversationTurnModel({required this.role, required this.content});
  factory _ConversationTurnModel.fromJson(Map<String, dynamic> json) => _$ConversationTurnModelFromJson(json);

@override final  String role;
@override final  String content;

/// Create a copy of ConversationTurnModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConversationTurnModelCopyWith<_ConversationTurnModel> get copyWith => __$ConversationTurnModelCopyWithImpl<_ConversationTurnModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConversationTurnModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConversationTurnModel&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'ConversationTurnModel(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ConversationTurnModelCopyWith<$Res> implements $ConversationTurnModelCopyWith<$Res> {
  factory _$ConversationTurnModelCopyWith(_ConversationTurnModel value, $Res Function(_ConversationTurnModel) _then) = __$ConversationTurnModelCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$ConversationTurnModelCopyWithImpl<$Res>
    implements _$ConversationTurnModelCopyWith<$Res> {
  __$ConversationTurnModelCopyWithImpl(this._self, this._then);

  final _ConversationTurnModel _self;
  final $Res Function(_ConversationTurnModel) _then;

/// Create a copy of ConversationTurnModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_ConversationTurnModel(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
