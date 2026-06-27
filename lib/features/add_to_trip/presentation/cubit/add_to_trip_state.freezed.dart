// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_to_trip_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddToTripState {

 PlaceEntity get place; AddToTripStatus get status; List<Trip> get trips; Trip? get selectedTrip; String get errorMessage; DateTime? get startDate; DateTime? get endDate; int get adultCount; String get budget; String get customBudget; int get currentPage;
/// Create a copy of AddToTripState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddToTripStateCopyWith<AddToTripState> get copyWith => _$AddToTripStateCopyWithImpl<AddToTripState>(this as AddToTripState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddToTripState&&(identical(other.place, place) || other.place == place)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.trips, trips)&&(identical(other.selectedTrip, selectedTrip) || other.selectedTrip == selectedTrip)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.adultCount, adultCount) || other.adultCount == adultCount)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.customBudget, customBudget) || other.customBudget == customBudget)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,place,status,const DeepCollectionEquality().hash(trips),selectedTrip,errorMessage,startDate,endDate,adultCount,budget,customBudget,currentPage);

@override
String toString() {
  return 'AddToTripState(place: $place, status: $status, trips: $trips, selectedTrip: $selectedTrip, errorMessage: $errorMessage, startDate: $startDate, endDate: $endDate, adultCount: $adultCount, budget: $budget, customBudget: $customBudget, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class $AddToTripStateCopyWith<$Res>  {
  factory $AddToTripStateCopyWith(AddToTripState value, $Res Function(AddToTripState) _then) = _$AddToTripStateCopyWithImpl;
@useResult
$Res call({
 PlaceEntity place, AddToTripStatus status, List<Trip> trips, Trip? selectedTrip, String errorMessage, DateTime? startDate, DateTime? endDate, int adultCount, String budget, String customBudget, int currentPage
});




}
/// @nodoc
class _$AddToTripStateCopyWithImpl<$Res>
    implements $AddToTripStateCopyWith<$Res> {
  _$AddToTripStateCopyWithImpl(this._self, this._then);

  final AddToTripState _self;
  final $Res Function(AddToTripState) _then;

/// Create a copy of AddToTripState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? place = null,Object? status = null,Object? trips = null,Object? selectedTrip = freezed,Object? errorMessage = null,Object? startDate = freezed,Object? endDate = freezed,Object? adultCount = null,Object? budget = null,Object? customBudget = null,Object? currentPage = null,}) {
  return _then(_self.copyWith(
place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceEntity,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AddToTripStatus,trips: null == trips ? _self.trips : trips // ignore: cast_nullable_to_non_nullable
as List<Trip>,selectedTrip: freezed == selectedTrip ? _self.selectedTrip : selectedTrip // ignore: cast_nullable_to_non_nullable
as Trip?,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,adultCount: null == adultCount ? _self.adultCount : adultCount // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as String,customBudget: null == customBudget ? _self.customBudget : customBudget // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AddToTripState].
extension AddToTripStatePatterns on AddToTripState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddToTripState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddToTripState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddToTripState value)  $default,){
final _that = this;
switch (_that) {
case _AddToTripState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddToTripState value)?  $default,){
final _that = this;
switch (_that) {
case _AddToTripState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlaceEntity place,  AddToTripStatus status,  List<Trip> trips,  Trip? selectedTrip,  String errorMessage,  DateTime? startDate,  DateTime? endDate,  int adultCount,  String budget,  String customBudget,  int currentPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddToTripState() when $default != null:
return $default(_that.place,_that.status,_that.trips,_that.selectedTrip,_that.errorMessage,_that.startDate,_that.endDate,_that.adultCount,_that.budget,_that.customBudget,_that.currentPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlaceEntity place,  AddToTripStatus status,  List<Trip> trips,  Trip? selectedTrip,  String errorMessage,  DateTime? startDate,  DateTime? endDate,  int adultCount,  String budget,  String customBudget,  int currentPage)  $default,) {final _that = this;
switch (_that) {
case _AddToTripState():
return $default(_that.place,_that.status,_that.trips,_that.selectedTrip,_that.errorMessage,_that.startDate,_that.endDate,_that.adultCount,_that.budget,_that.customBudget,_that.currentPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlaceEntity place,  AddToTripStatus status,  List<Trip> trips,  Trip? selectedTrip,  String errorMessage,  DateTime? startDate,  DateTime? endDate,  int adultCount,  String budget,  String customBudget,  int currentPage)?  $default,) {final _that = this;
switch (_that) {
case _AddToTripState() when $default != null:
return $default(_that.place,_that.status,_that.trips,_that.selectedTrip,_that.errorMessage,_that.startDate,_that.endDate,_that.adultCount,_that.budget,_that.customBudget,_that.currentPage);case _:
  return null;

}
}

}

/// @nodoc


class _AddToTripState extends AddToTripState {
  const _AddToTripState({required this.place, this.status = AddToTripStatus.initial, final  List<Trip> trips = const [], this.selectedTrip, this.errorMessage = '', this.startDate, this.endDate, this.adultCount = 0, this.budget = '', this.customBudget = '', this.currentPage = 0}): _trips = trips,super._();
  

@override final  PlaceEntity place;
@override@JsonKey() final  AddToTripStatus status;
 final  List<Trip> _trips;
@override@JsonKey() List<Trip> get trips {
  if (_trips is EqualUnmodifiableListView) return _trips;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trips);
}

@override final  Trip? selectedTrip;
@override@JsonKey() final  String errorMessage;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  int adultCount;
@override@JsonKey() final  String budget;
@override@JsonKey() final  String customBudget;
@override@JsonKey() final  int currentPage;

/// Create a copy of AddToTripState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddToTripStateCopyWith<_AddToTripState> get copyWith => __$AddToTripStateCopyWithImpl<_AddToTripState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddToTripState&&(identical(other.place, place) || other.place == place)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._trips, _trips)&&(identical(other.selectedTrip, selectedTrip) || other.selectedTrip == selectedTrip)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.adultCount, adultCount) || other.adultCount == adultCount)&&(identical(other.budget, budget) || other.budget == budget)&&(identical(other.customBudget, customBudget) || other.customBudget == customBudget)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,place,status,const DeepCollectionEquality().hash(_trips),selectedTrip,errorMessage,startDate,endDate,adultCount,budget,customBudget,currentPage);

@override
String toString() {
  return 'AddToTripState(place: $place, status: $status, trips: $trips, selectedTrip: $selectedTrip, errorMessage: $errorMessage, startDate: $startDate, endDate: $endDate, adultCount: $adultCount, budget: $budget, customBudget: $customBudget, currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class _$AddToTripStateCopyWith<$Res> implements $AddToTripStateCopyWith<$Res> {
  factory _$AddToTripStateCopyWith(_AddToTripState value, $Res Function(_AddToTripState) _then) = __$AddToTripStateCopyWithImpl;
@override @useResult
$Res call({
 PlaceEntity place, AddToTripStatus status, List<Trip> trips, Trip? selectedTrip, String errorMessage, DateTime? startDate, DateTime? endDate, int adultCount, String budget, String customBudget, int currentPage
});




}
/// @nodoc
class __$AddToTripStateCopyWithImpl<$Res>
    implements _$AddToTripStateCopyWith<$Res> {
  __$AddToTripStateCopyWithImpl(this._self, this._then);

  final _AddToTripState _self;
  final $Res Function(_AddToTripState) _then;

/// Create a copy of AddToTripState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? place = null,Object? status = null,Object? trips = null,Object? selectedTrip = freezed,Object? errorMessage = null,Object? startDate = freezed,Object? endDate = freezed,Object? adultCount = null,Object? budget = null,Object? customBudget = null,Object? currentPage = null,}) {
  return _then(_AddToTripState(
place: null == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as PlaceEntity,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AddToTripStatus,trips: null == trips ? _self._trips : trips // ignore: cast_nullable_to_non_nullable
as List<Trip>,selectedTrip: freezed == selectedTrip ? _self.selectedTrip : selectedTrip // ignore: cast_nullable_to_non_nullable
as Trip?,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,adultCount: null == adultCount ? _self.adultCount : adultCount // ignore: cast_nullable_to_non_nullable
as int,budget: null == budget ? _self.budget : budget // ignore: cast_nullable_to_non_nullable
as String,customBudget: null == customBudget ? _self.customBudget : customBudget // ignore: cast_nullable_to_non_nullable
as String,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
