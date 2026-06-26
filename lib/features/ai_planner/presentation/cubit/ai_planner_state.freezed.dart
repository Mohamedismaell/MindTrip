// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_planner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AiPlannerState {

 String? get tripId; GeneratedPlanEntity? get generatedPlan; AiPlannerStatus get status; String get errorMessage; int get currentPage; String get sessionId; int get maxReachedPage; String? get selectedDestination; String get destinationQuery; DateTime? get tripStart; DateTime? get tripEnd; int get adults; int get children; BudgetTierModel? get selectedBudget; String get customBudget; DateTime? get visibleMonth; List<String> get selectedInterests; DateTime get focusedDay;
/// Create a copy of AiPlannerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiPlannerStateCopyWith<AiPlannerState> get copyWith => _$AiPlannerStateCopyWithImpl<AiPlannerState>(this as AiPlannerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiPlannerState&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.generatedPlan, generatedPlan) || other.generatedPlan == generatedPlan)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.maxReachedPage, maxReachedPage) || other.maxReachedPage == maxReachedPage)&&(identical(other.selectedDestination, selectedDestination) || other.selectedDestination == selectedDestination)&&(identical(other.destinationQuery, destinationQuery) || other.destinationQuery == destinationQuery)&&(identical(other.tripStart, tripStart) || other.tripStart == tripStart)&&(identical(other.tripEnd, tripEnd) || other.tripEnd == tripEnd)&&(identical(other.adults, adults) || other.adults == adults)&&(identical(other.children, children) || other.children == children)&&(identical(other.selectedBudget, selectedBudget) || other.selectedBudget == selectedBudget)&&(identical(other.customBudget, customBudget) || other.customBudget == customBudget)&&(identical(other.visibleMonth, visibleMonth) || other.visibleMonth == visibleMonth)&&const DeepCollectionEquality().equals(other.selectedInterests, selectedInterests)&&(identical(other.focusedDay, focusedDay) || other.focusedDay == focusedDay));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,generatedPlan,status,errorMessage,currentPage,sessionId,maxReachedPage,selectedDestination,destinationQuery,tripStart,tripEnd,adults,children,selectedBudget,customBudget,visibleMonth,const DeepCollectionEquality().hash(selectedInterests),focusedDay);

@override
String toString() {
  return 'AiPlannerState(tripId: $tripId, generatedPlan: $generatedPlan, status: $status, errorMessage: $errorMessage, currentPage: $currentPage, sessionId: $sessionId, maxReachedPage: $maxReachedPage, selectedDestination: $selectedDestination, destinationQuery: $destinationQuery, tripStart: $tripStart, tripEnd: $tripEnd, adults: $adults, children: $children, selectedBudget: $selectedBudget, customBudget: $customBudget, visibleMonth: $visibleMonth, selectedInterests: $selectedInterests, focusedDay: $focusedDay)';
}


}

/// @nodoc
abstract mixin class $AiPlannerStateCopyWith<$Res>  {
  factory $AiPlannerStateCopyWith(AiPlannerState value, $Res Function(AiPlannerState) _then) = _$AiPlannerStateCopyWithImpl;
@useResult
$Res call({
 String? tripId, GeneratedPlanEntity? generatedPlan, AiPlannerStatus status, String errorMessage, int currentPage, String sessionId, int maxReachedPage, String? selectedDestination, String destinationQuery, DateTime? tripStart, DateTime? tripEnd, int adults, int children, BudgetTierModel? selectedBudget, String customBudget, DateTime? visibleMonth, List<String> selectedInterests, DateTime focusedDay
});




}
/// @nodoc
class _$AiPlannerStateCopyWithImpl<$Res>
    implements $AiPlannerStateCopyWith<$Res> {
  _$AiPlannerStateCopyWithImpl(this._self, this._then);

  final AiPlannerState _self;
  final $Res Function(AiPlannerState) _then;

/// Create a copy of AiPlannerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripId = freezed,Object? generatedPlan = freezed,Object? status = null,Object? errorMessage = null,Object? currentPage = null,Object? sessionId = null,Object? maxReachedPage = null,Object? selectedDestination = freezed,Object? destinationQuery = null,Object? tripStart = freezed,Object? tripEnd = freezed,Object? adults = null,Object? children = null,Object? selectedBudget = freezed,Object? customBudget = null,Object? visibleMonth = freezed,Object? selectedInterests = null,Object? focusedDay = null,}) {
  return _then(_self.copyWith(
tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,generatedPlan: freezed == generatedPlan ? _self.generatedPlan : generatedPlan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanEntity?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiPlannerStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,maxReachedPage: null == maxReachedPage ? _self.maxReachedPage : maxReachedPage // ignore: cast_nullable_to_non_nullable
as int,selectedDestination: freezed == selectedDestination ? _self.selectedDestination : selectedDestination // ignore: cast_nullable_to_non_nullable
as String?,destinationQuery: null == destinationQuery ? _self.destinationQuery : destinationQuery // ignore: cast_nullable_to_non_nullable
as String,tripStart: freezed == tripStart ? _self.tripStart : tripStart // ignore: cast_nullable_to_non_nullable
as DateTime?,tripEnd: freezed == tripEnd ? _self.tripEnd : tripEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,adults: null == adults ? _self.adults : adults // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as int,selectedBudget: freezed == selectedBudget ? _self.selectedBudget : selectedBudget // ignore: cast_nullable_to_non_nullable
as BudgetTierModel?,customBudget: null == customBudget ? _self.customBudget : customBudget // ignore: cast_nullable_to_non_nullable
as String,visibleMonth: freezed == visibleMonth ? _self.visibleMonth : visibleMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedInterests: null == selectedInterests ? _self.selectedInterests : selectedInterests // ignore: cast_nullable_to_non_nullable
as List<String>,focusedDay: null == focusedDay ? _self.focusedDay : focusedDay // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AiPlannerState].
extension AiPlannerStatePatterns on AiPlannerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiPlannerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiPlannerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiPlannerState value)  $default,){
final _that = this;
switch (_that) {
case _AiPlannerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiPlannerState value)?  $default,){
final _that = this;
switch (_that) {
case _AiPlannerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? tripId,  GeneratedPlanEntity? generatedPlan,  AiPlannerStatus status,  String errorMessage,  int currentPage,  String sessionId,  int maxReachedPage,  String? selectedDestination,  String destinationQuery,  DateTime? tripStart,  DateTime? tripEnd,  int adults,  int children,  BudgetTierModel? selectedBudget,  String customBudget,  DateTime? visibleMonth,  List<String> selectedInterests,  DateTime focusedDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiPlannerState() when $default != null:
return $default(_that.tripId,_that.generatedPlan,_that.status,_that.errorMessage,_that.currentPage,_that.sessionId,_that.maxReachedPage,_that.selectedDestination,_that.destinationQuery,_that.tripStart,_that.tripEnd,_that.adults,_that.children,_that.selectedBudget,_that.customBudget,_that.visibleMonth,_that.selectedInterests,_that.focusedDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? tripId,  GeneratedPlanEntity? generatedPlan,  AiPlannerStatus status,  String errorMessage,  int currentPage,  String sessionId,  int maxReachedPage,  String? selectedDestination,  String destinationQuery,  DateTime? tripStart,  DateTime? tripEnd,  int adults,  int children,  BudgetTierModel? selectedBudget,  String customBudget,  DateTime? visibleMonth,  List<String> selectedInterests,  DateTime focusedDay)  $default,) {final _that = this;
switch (_that) {
case _AiPlannerState():
return $default(_that.tripId,_that.generatedPlan,_that.status,_that.errorMessage,_that.currentPage,_that.sessionId,_that.maxReachedPage,_that.selectedDestination,_that.destinationQuery,_that.tripStart,_that.tripEnd,_that.adults,_that.children,_that.selectedBudget,_that.customBudget,_that.visibleMonth,_that.selectedInterests,_that.focusedDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? tripId,  GeneratedPlanEntity? generatedPlan,  AiPlannerStatus status,  String errorMessage,  int currentPage,  String sessionId,  int maxReachedPage,  String? selectedDestination,  String destinationQuery,  DateTime? tripStart,  DateTime? tripEnd,  int adults,  int children,  BudgetTierModel? selectedBudget,  String customBudget,  DateTime? visibleMonth,  List<String> selectedInterests,  DateTime focusedDay)?  $default,) {final _that = this;
switch (_that) {
case _AiPlannerState() when $default != null:
return $default(_that.tripId,_that.generatedPlan,_that.status,_that.errorMessage,_that.currentPage,_that.sessionId,_that.maxReachedPage,_that.selectedDestination,_that.destinationQuery,_that.tripStart,_that.tripEnd,_that.adults,_that.children,_that.selectedBudget,_that.customBudget,_that.visibleMonth,_that.selectedInterests,_that.focusedDay);case _:
  return null;

}
}

}

/// @nodoc


class _AiPlannerState extends AiPlannerState {
  const _AiPlannerState({this.tripId, this.generatedPlan, this.status = AiPlannerStatus.initial, this.errorMessage = '', this.currentPage = 0, this.sessionId = '', this.maxReachedPage = 0, this.selectedDestination, this.destinationQuery = '', this.tripStart, this.tripEnd, this.adults = 0, this.children = 0, this.selectedBudget, this.customBudget = '', this.visibleMonth, final  List<String> selectedInterests = const <String>[], required this.focusedDay}): _selectedInterests = selectedInterests,super._();
  

@override final  String? tripId;
@override final  GeneratedPlanEntity? generatedPlan;
@override@JsonKey() final  AiPlannerStatus status;
@override@JsonKey() final  String errorMessage;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  String sessionId;
@override@JsonKey() final  int maxReachedPage;
@override final  String? selectedDestination;
@override@JsonKey() final  String destinationQuery;
@override final  DateTime? tripStart;
@override final  DateTime? tripEnd;
@override@JsonKey() final  int adults;
@override@JsonKey() final  int children;
@override final  BudgetTierModel? selectedBudget;
@override@JsonKey() final  String customBudget;
@override final  DateTime? visibleMonth;
 final  List<String> _selectedInterests;
@override@JsonKey() List<String> get selectedInterests {
  if (_selectedInterests is EqualUnmodifiableListView) return _selectedInterests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedInterests);
}

@override final  DateTime focusedDay;

/// Create a copy of AiPlannerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiPlannerStateCopyWith<_AiPlannerState> get copyWith => __$AiPlannerStateCopyWithImpl<_AiPlannerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiPlannerState&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.generatedPlan, generatedPlan) || other.generatedPlan == generatedPlan)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.maxReachedPage, maxReachedPage) || other.maxReachedPage == maxReachedPage)&&(identical(other.selectedDestination, selectedDestination) || other.selectedDestination == selectedDestination)&&(identical(other.destinationQuery, destinationQuery) || other.destinationQuery == destinationQuery)&&(identical(other.tripStart, tripStart) || other.tripStart == tripStart)&&(identical(other.tripEnd, tripEnd) || other.tripEnd == tripEnd)&&(identical(other.adults, adults) || other.adults == adults)&&(identical(other.children, children) || other.children == children)&&(identical(other.selectedBudget, selectedBudget) || other.selectedBudget == selectedBudget)&&(identical(other.customBudget, customBudget) || other.customBudget == customBudget)&&(identical(other.visibleMonth, visibleMonth) || other.visibleMonth == visibleMonth)&&const DeepCollectionEquality().equals(other._selectedInterests, _selectedInterests)&&(identical(other.focusedDay, focusedDay) || other.focusedDay == focusedDay));
}


@override
int get hashCode => Object.hash(runtimeType,tripId,generatedPlan,status,errorMessage,currentPage,sessionId,maxReachedPage,selectedDestination,destinationQuery,tripStart,tripEnd,adults,children,selectedBudget,customBudget,visibleMonth,const DeepCollectionEquality().hash(_selectedInterests),focusedDay);

@override
String toString() {
  return 'AiPlannerState(tripId: $tripId, generatedPlan: $generatedPlan, status: $status, errorMessage: $errorMessage, currentPage: $currentPage, sessionId: $sessionId, maxReachedPage: $maxReachedPage, selectedDestination: $selectedDestination, destinationQuery: $destinationQuery, tripStart: $tripStart, tripEnd: $tripEnd, adults: $adults, children: $children, selectedBudget: $selectedBudget, customBudget: $customBudget, visibleMonth: $visibleMonth, selectedInterests: $selectedInterests, focusedDay: $focusedDay)';
}


}

/// @nodoc
abstract mixin class _$AiPlannerStateCopyWith<$Res> implements $AiPlannerStateCopyWith<$Res> {
  factory _$AiPlannerStateCopyWith(_AiPlannerState value, $Res Function(_AiPlannerState) _then) = __$AiPlannerStateCopyWithImpl;
@override @useResult
$Res call({
 String? tripId, GeneratedPlanEntity? generatedPlan, AiPlannerStatus status, String errorMessage, int currentPage, String sessionId, int maxReachedPage, String? selectedDestination, String destinationQuery, DateTime? tripStart, DateTime? tripEnd, int adults, int children, BudgetTierModel? selectedBudget, String customBudget, DateTime? visibleMonth, List<String> selectedInterests, DateTime focusedDay
});




}
/// @nodoc
class __$AiPlannerStateCopyWithImpl<$Res>
    implements _$AiPlannerStateCopyWith<$Res> {
  __$AiPlannerStateCopyWithImpl(this._self, this._then);

  final _AiPlannerState _self;
  final $Res Function(_AiPlannerState) _then;

/// Create a copy of AiPlannerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripId = freezed,Object? generatedPlan = freezed,Object? status = null,Object? errorMessage = null,Object? currentPage = null,Object? sessionId = null,Object? maxReachedPage = null,Object? selectedDestination = freezed,Object? destinationQuery = null,Object? tripStart = freezed,Object? tripEnd = freezed,Object? adults = null,Object? children = null,Object? selectedBudget = freezed,Object? customBudget = null,Object? visibleMonth = freezed,Object? selectedInterests = null,Object? focusedDay = null,}) {
  return _then(_AiPlannerState(
tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,generatedPlan: freezed == generatedPlan ? _self.generatedPlan : generatedPlan // ignore: cast_nullable_to_non_nullable
as GeneratedPlanEntity?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AiPlannerStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,maxReachedPage: null == maxReachedPage ? _self.maxReachedPage : maxReachedPage // ignore: cast_nullable_to_non_nullable
as int,selectedDestination: freezed == selectedDestination ? _self.selectedDestination : selectedDestination // ignore: cast_nullable_to_non_nullable
as String?,destinationQuery: null == destinationQuery ? _self.destinationQuery : destinationQuery // ignore: cast_nullable_to_non_nullable
as String,tripStart: freezed == tripStart ? _self.tripStart : tripStart // ignore: cast_nullable_to_non_nullable
as DateTime?,tripEnd: freezed == tripEnd ? _self.tripEnd : tripEnd // ignore: cast_nullable_to_non_nullable
as DateTime?,adults: null == adults ? _self.adults : adults // ignore: cast_nullable_to_non_nullable
as int,children: null == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as int,selectedBudget: freezed == selectedBudget ? _self.selectedBudget : selectedBudget // ignore: cast_nullable_to_non_nullable
as BudgetTierModel?,customBudget: null == customBudget ? _self.customBudget : customBudget // ignore: cast_nullable_to_non_nullable
as String,visibleMonth: freezed == visibleMonth ? _self.visibleMonth : visibleMonth // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedInterests: null == selectedInterests ? _self._selectedInterests : selectedInterests // ignore: cast_nullable_to_non_nullable
as List<String>,focusedDay: null == focusedDay ? _self.focusedDay : focusedDay // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
