// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiEditState {

 AiEditStatus get status; List<ChatMessage> get messages; GeneratedPlanEntity? get currentPlan; EditPlanResponseEntity? get lastAIResponse; String get errorMessage; String? get tripId;
/// Create a copy of AiEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiEditStateCopyWith<AiEditState> get copyWith => _$AiEditStateCopyWithImpl<AiEditState>(this as AiEditState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiEditState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.currentPlan, currentPlan) || other.currentPlan == currentPlan)&&(identical(other.lastAIResponse, lastAIResponse) || other.lastAIResponse == lastAIResponse)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(messages),currentPlan,lastAIResponse,errorMessage,tripId);

@override
String toString() {
  return 'AiEditState(status: $status, messages: $messages, currentPlan: $currentPlan, lastAIResponse: $lastAIResponse, errorMessage: $errorMessage, tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class $AiEditStateCopyWith<$Res>  {
  factory $AiEditStateCopyWith(AiEditState value, $Res Function(AiEditState) _then) = _$AiEditStateCopyWithImpl;
@useResult
$Res call({
 AiEditStatus status, List<ChatMessage> messages, GeneratedPlanEntity? currentPlan, EditPlanResponseEntity? lastAIResponse, String errorMessage, String? tripId
});




}
/// @nodoc
class _$AiEditStateCopyWithImpl<$Res>
    implements $AiEditStateCopyWith<$Res> {
  _$AiEditStateCopyWithImpl(this._self, this._then);

  final AiEditState _self;
  final $Res Function(AiEditState) _then;

/// Create a copy of AiEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? messages = null,Object? currentPlan = freezed,Object? lastAIResponse = freezed,Object? errorMessage = null,Object? tripId = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiEditStatus,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,currentPlan: freezed == currentPlan ? _self.currentPlan : currentPlan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanEntity?,lastAIResponse: freezed == lastAIResponse ? _self.lastAIResponse : lastAIResponse // ignore: cast_nullable_to_non_nullable
as EditPlanResponseEntity?,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiEditState].
extension AiEditStatePatterns on AiEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiEditState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiEditState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiEditState value)  $default,){
final _that = this;
switch (_that) {
case _AiEditState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiEditState value)?  $default,){
final _that = this;
switch (_that) {
case _AiEditState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AiEditStatus status,  List<ChatMessage> messages,  GeneratedPlanEntity? currentPlan,  EditPlanResponseEntity? lastAIResponse,  String errorMessage,  String? tripId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiEditState() when $default != null:
return $default(_that.status,_that.messages,_that.currentPlan,_that.lastAIResponse,_that.errorMessage,_that.tripId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AiEditStatus status,  List<ChatMessage> messages,  GeneratedPlanEntity? currentPlan,  EditPlanResponseEntity? lastAIResponse,  String errorMessage,  String? tripId)  $default,) {final _that = this;
switch (_that) {
case _AiEditState():
return $default(_that.status,_that.messages,_that.currentPlan,_that.lastAIResponse,_that.errorMessage,_that.tripId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AiEditStatus status,  List<ChatMessage> messages,  GeneratedPlanEntity? currentPlan,  EditPlanResponseEntity? lastAIResponse,  String errorMessage,  String? tripId)?  $default,) {final _that = this;
switch (_that) {
case _AiEditState() when $default != null:
return $default(_that.status,_that.messages,_that.currentPlan,_that.lastAIResponse,_that.errorMessage,_that.tripId);case _:
  return null;

}
}

}

/// @nodoc


class _AiEditState implements AiEditState {
  const _AiEditState({this.status = AiEditStatus.initial, final  List<ChatMessage> messages = const [], this.currentPlan, this.lastAIResponse, this.errorMessage = '', this.tripId}): _messages = messages;
  

@override@JsonKey() final  AiEditStatus status;
 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  GeneratedPlanEntity? currentPlan;
@override final  EditPlanResponseEntity? lastAIResponse;
@override@JsonKey() final  String errorMessage;
@override final  String? tripId;

/// Create a copy of AiEditState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiEditStateCopyWith<_AiEditState> get copyWith => __$AiEditStateCopyWithImpl<_AiEditState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiEditState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.currentPlan, currentPlan) || other.currentPlan == currentPlan)&&(identical(other.lastAIResponse, lastAIResponse) || other.lastAIResponse == lastAIResponse)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.tripId, tripId) || other.tripId == tripId));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_messages),currentPlan,lastAIResponse,errorMessage,tripId);

@override
String toString() {
  return 'AiEditState(status: $status, messages: $messages, currentPlan: $currentPlan, lastAIResponse: $lastAIResponse, errorMessage: $errorMessage, tripId: $tripId)';
}


}

/// @nodoc
abstract mixin class _$AiEditStateCopyWith<$Res> implements $AiEditStateCopyWith<$Res> {
  factory _$AiEditStateCopyWith(_AiEditState value, $Res Function(_AiEditState) _then) = __$AiEditStateCopyWithImpl;
@override @useResult
$Res call({
 AiEditStatus status, List<ChatMessage> messages, GeneratedPlanEntity? currentPlan, EditPlanResponseEntity? lastAIResponse, String errorMessage, String? tripId
});




}
/// @nodoc
class __$AiEditStateCopyWithImpl<$Res>
    implements _$AiEditStateCopyWith<$Res> {
  __$AiEditStateCopyWithImpl(this._self, this._then);

  final _AiEditState _self;
  final $Res Function(_AiEditState) _then;

/// Create a copy of AiEditState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? messages = null,Object? currentPlan = freezed,Object? lastAIResponse = freezed,Object? errorMessage = null,Object? tripId = freezed,}) {
  return _then(_AiEditState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiEditStatus,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,currentPlan: freezed == currentPlan ? _self.currentPlan : currentPlan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanEntity?,lastAIResponse: freezed == lastAIResponse ? _self.lastAIResponse : lastAIResponse // ignore: cast_nullable_to_non_nullable
as EditPlanResponseEntity?,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
