// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 HomeDataStatus get bannersStatus; List<BannerEntity> get banners; String get bannersError;//popular
 HomeDataStatus get popularPlacesStatus; PaginationState<PlaceEntity> get popularPlaces; String get popularPlacesError;//category
 HomeDataStatus get categoryPlacesStatus; PaginationState<PlaceEntity> get categoryPlaces; PlaceCategory get selectedCategory; String get categoryPlacesError; HomeDataStatus get plannerPreviewsStatus; List<PlannerPreviewEntity> get plannerPreviews; String get plannerPreviewsError;//hidden gems
 HomeDataStatus get hiddenGemsStatus; PaginationState<PlaceEntity> get hiddenGems; String get hiddenGemsError; List<PlaceCategory> get homeCategories;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.bannersStatus, bannersStatus) || other.bannersStatus == bannersStatus)&&const DeepCollectionEquality().equals(other.banners, banners)&&(identical(other.bannersError, bannersError) || other.bannersError == bannersError)&&(identical(other.popularPlacesStatus, popularPlacesStatus) || other.popularPlacesStatus == popularPlacesStatus)&&(identical(other.popularPlaces, popularPlaces) || other.popularPlaces == popularPlaces)&&(identical(other.popularPlacesError, popularPlacesError) || other.popularPlacesError == popularPlacesError)&&(identical(other.categoryPlacesStatus, categoryPlacesStatus) || other.categoryPlacesStatus == categoryPlacesStatus)&&(identical(other.categoryPlaces, categoryPlaces) || other.categoryPlaces == categoryPlaces)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.categoryPlacesError, categoryPlacesError) || other.categoryPlacesError == categoryPlacesError)&&(identical(other.plannerPreviewsStatus, plannerPreviewsStatus) || other.plannerPreviewsStatus == plannerPreviewsStatus)&&const DeepCollectionEquality().equals(other.plannerPreviews, plannerPreviews)&&(identical(other.plannerPreviewsError, plannerPreviewsError) || other.plannerPreviewsError == plannerPreviewsError)&&(identical(other.hiddenGemsStatus, hiddenGemsStatus) || other.hiddenGemsStatus == hiddenGemsStatus)&&(identical(other.hiddenGems, hiddenGems) || other.hiddenGems == hiddenGems)&&(identical(other.hiddenGemsError, hiddenGemsError) || other.hiddenGemsError == hiddenGemsError)&&const DeepCollectionEquality().equals(other.homeCategories, homeCategories));
}


@override
int get hashCode => Object.hash(runtimeType,bannersStatus,const DeepCollectionEquality().hash(banners),bannersError,popularPlacesStatus,popularPlaces,popularPlacesError,categoryPlacesStatus,categoryPlaces,selectedCategory,categoryPlacesError,plannerPreviewsStatus,const DeepCollectionEquality().hash(plannerPreviews),plannerPreviewsError,hiddenGemsStatus,hiddenGems,hiddenGemsError,const DeepCollectionEquality().hash(homeCategories));

@override
String toString() {
  return 'HomeState(bannersStatus: $bannersStatus, banners: $banners, bannersError: $bannersError, popularPlacesStatus: $popularPlacesStatus, popularPlaces: $popularPlaces, popularPlacesError: $popularPlacesError, categoryPlacesStatus: $categoryPlacesStatus, categoryPlaces: $categoryPlaces, selectedCategory: $selectedCategory, categoryPlacesError: $categoryPlacesError, plannerPreviewsStatus: $plannerPreviewsStatus, plannerPreviews: $plannerPreviews, plannerPreviewsError: $plannerPreviewsError, hiddenGemsStatus: $hiddenGemsStatus, hiddenGems: $hiddenGems, hiddenGemsError: $hiddenGemsError, homeCategories: $homeCategories)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 HomeDataStatus bannersStatus, List<BannerEntity> banners, String bannersError, HomeDataStatus popularPlacesStatus, PaginationState<PlaceEntity> popularPlaces, String popularPlacesError, HomeDataStatus categoryPlacesStatus, PaginationState<PlaceEntity> categoryPlaces, PlaceCategory selectedCategory, String categoryPlacesError, HomeDataStatus plannerPreviewsStatus, List<PlannerPreviewEntity> plannerPreviews, String plannerPreviewsError, HomeDataStatus hiddenGemsStatus, PaginationState<PlaceEntity> hiddenGems, String hiddenGemsError, List<PlaceCategory> homeCategories
});


$PaginationStateCopyWith<PlaceEntity, $Res> get popularPlaces;$PaginationStateCopyWith<PlaceEntity, $Res> get categoryPlaces;$PaginationStateCopyWith<PlaceEntity, $Res> get hiddenGems;

}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bannersStatus = null,Object? banners = null,Object? bannersError = null,Object? popularPlacesStatus = null,Object? popularPlaces = null,Object? popularPlacesError = null,Object? categoryPlacesStatus = null,Object? categoryPlaces = null,Object? selectedCategory = null,Object? categoryPlacesError = null,Object? plannerPreviewsStatus = null,Object? plannerPreviews = null,Object? plannerPreviewsError = null,Object? hiddenGemsStatus = null,Object? hiddenGems = null,Object? hiddenGemsError = null,Object? homeCategories = null,}) {
  return _then(_self.copyWith(
bannersStatus: null == bannersStatus ? _self.bannersStatus : bannersStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerEntity>,bannersError: null == bannersError ? _self.bannersError : bannersError // ignore: cast_nullable_to_non_nullable
as String,popularPlacesStatus: null == popularPlacesStatus ? _self.popularPlacesStatus : popularPlacesStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,popularPlaces: null == popularPlaces ? _self.popularPlaces : popularPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,popularPlacesError: null == popularPlacesError ? _self.popularPlacesError : popularPlacesError // ignore: cast_nullable_to_non_nullable
as String,categoryPlacesStatus: null == categoryPlacesStatus ? _self.categoryPlacesStatus : categoryPlacesStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,categoryPlaces: null == categoryPlaces ? _self.categoryPlaces : categoryPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as PlaceCategory,categoryPlacesError: null == categoryPlacesError ? _self.categoryPlacesError : categoryPlacesError // ignore: cast_nullable_to_non_nullable
as String,plannerPreviewsStatus: null == plannerPreviewsStatus ? _self.plannerPreviewsStatus : plannerPreviewsStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,plannerPreviews: null == plannerPreviews ? _self.plannerPreviews : plannerPreviews // ignore: cast_nullable_to_non_nullable
as List<PlannerPreviewEntity>,plannerPreviewsError: null == plannerPreviewsError ? _self.plannerPreviewsError : plannerPreviewsError // ignore: cast_nullable_to_non_nullable
as String,hiddenGemsStatus: null == hiddenGemsStatus ? _self.hiddenGemsStatus : hiddenGemsStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,hiddenGems: null == hiddenGems ? _self.hiddenGems : hiddenGems // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,hiddenGemsError: null == hiddenGemsError ? _self.hiddenGemsError : hiddenGemsError // ignore: cast_nullable_to_non_nullable
as String,homeCategories: null == homeCategories ? _self.homeCategories : homeCategories // ignore: cast_nullable_to_non_nullable
as List<PlaceCategory>,
  ));
}
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get popularPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.popularPlaces, (value) {
    return _then(_self.copyWith(popularPlaces: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get categoryPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.categoryPlaces, (value) {
    return _then(_self.copyWith(categoryPlaces: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get hiddenGems {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.hiddenGems, (value) {
    return _then(_self.copyWith(hiddenGems: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HomeDataStatus bannersStatus,  List<BannerEntity> banners,  String bannersError,  HomeDataStatus popularPlacesStatus,  PaginationState<PlaceEntity> popularPlaces,  String popularPlacesError,  HomeDataStatus categoryPlacesStatus,  PaginationState<PlaceEntity> categoryPlaces,  PlaceCategory selectedCategory,  String categoryPlacesError,  HomeDataStatus plannerPreviewsStatus,  List<PlannerPreviewEntity> plannerPreviews,  String plannerPreviewsError,  HomeDataStatus hiddenGemsStatus,  PaginationState<PlaceEntity> hiddenGems,  String hiddenGemsError,  List<PlaceCategory> homeCategories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.bannersStatus,_that.banners,_that.bannersError,_that.popularPlacesStatus,_that.popularPlaces,_that.popularPlacesError,_that.categoryPlacesStatus,_that.categoryPlaces,_that.selectedCategory,_that.categoryPlacesError,_that.plannerPreviewsStatus,_that.plannerPreviews,_that.plannerPreviewsError,_that.hiddenGemsStatus,_that.hiddenGems,_that.hiddenGemsError,_that.homeCategories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HomeDataStatus bannersStatus,  List<BannerEntity> banners,  String bannersError,  HomeDataStatus popularPlacesStatus,  PaginationState<PlaceEntity> popularPlaces,  String popularPlacesError,  HomeDataStatus categoryPlacesStatus,  PaginationState<PlaceEntity> categoryPlaces,  PlaceCategory selectedCategory,  String categoryPlacesError,  HomeDataStatus plannerPreviewsStatus,  List<PlannerPreviewEntity> plannerPreviews,  String plannerPreviewsError,  HomeDataStatus hiddenGemsStatus,  PaginationState<PlaceEntity> hiddenGems,  String hiddenGemsError,  List<PlaceCategory> homeCategories)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.bannersStatus,_that.banners,_that.bannersError,_that.popularPlacesStatus,_that.popularPlaces,_that.popularPlacesError,_that.categoryPlacesStatus,_that.categoryPlaces,_that.selectedCategory,_that.categoryPlacesError,_that.plannerPreviewsStatus,_that.plannerPreviews,_that.plannerPreviewsError,_that.hiddenGemsStatus,_that.hiddenGems,_that.hiddenGemsError,_that.homeCategories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HomeDataStatus bannersStatus,  List<BannerEntity> banners,  String bannersError,  HomeDataStatus popularPlacesStatus,  PaginationState<PlaceEntity> popularPlaces,  String popularPlacesError,  HomeDataStatus categoryPlacesStatus,  PaginationState<PlaceEntity> categoryPlaces,  PlaceCategory selectedCategory,  String categoryPlacesError,  HomeDataStatus plannerPreviewsStatus,  List<PlannerPreviewEntity> plannerPreviews,  String plannerPreviewsError,  HomeDataStatus hiddenGemsStatus,  PaginationState<PlaceEntity> hiddenGems,  String hiddenGemsError,  List<PlaceCategory> homeCategories)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.bannersStatus,_that.banners,_that.bannersError,_that.popularPlacesStatus,_that.popularPlaces,_that.popularPlacesError,_that.categoryPlacesStatus,_that.categoryPlaces,_that.selectedCategory,_that.categoryPlacesError,_that.plannerPreviewsStatus,_that.plannerPreviews,_that.plannerPreviewsError,_that.hiddenGemsStatus,_that.hiddenGems,_that.hiddenGemsError,_that.homeCategories);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.bannersStatus = HomeDataStatus.initial, final  List<BannerEntity> banners = const [], this.bannersError = '', this.popularPlacesStatus = HomeDataStatus.initial, this.popularPlaces = const PaginationState<PlaceEntity>(), this.popularPlacesError = '', this.categoryPlacesStatus = HomeDataStatus.initial, this.categoryPlaces = const PaginationState<PlaceEntity>(), this.selectedCategory = PlaceCategory.food, this.categoryPlacesError = '', this.plannerPreviewsStatus = HomeDataStatus.initial, final  List<PlannerPreviewEntity> plannerPreviews = const [], this.plannerPreviewsError = '', this.hiddenGemsStatus = HomeDataStatus.initial, this.hiddenGems = const PaginationState<PlaceEntity>(), this.hiddenGemsError = '', final  List<PlaceCategory> homeCategories = const [PlaceCategory.food, PlaceCategory.cafes, PlaceCategory.hotels]}): _banners = banners,_plannerPreviews = plannerPreviews,_homeCategories = homeCategories;
  

@override@JsonKey() final  HomeDataStatus bannersStatus;
 final  List<BannerEntity> _banners;
@override@JsonKey() List<BannerEntity> get banners {
  if (_banners is EqualUnmodifiableListView) return _banners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_banners);
}

@override@JsonKey() final  String bannersError;
//popular
@override@JsonKey() final  HomeDataStatus popularPlacesStatus;
@override@JsonKey() final  PaginationState<PlaceEntity> popularPlaces;
@override@JsonKey() final  String popularPlacesError;
//category
@override@JsonKey() final  HomeDataStatus categoryPlacesStatus;
@override@JsonKey() final  PaginationState<PlaceEntity> categoryPlaces;
@override@JsonKey() final  PlaceCategory selectedCategory;
@override@JsonKey() final  String categoryPlacesError;
@override@JsonKey() final  HomeDataStatus plannerPreviewsStatus;
 final  List<PlannerPreviewEntity> _plannerPreviews;
@override@JsonKey() List<PlannerPreviewEntity> get plannerPreviews {
  if (_plannerPreviews is EqualUnmodifiableListView) return _plannerPreviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plannerPreviews);
}

@override@JsonKey() final  String plannerPreviewsError;
//hidden gems
@override@JsonKey() final  HomeDataStatus hiddenGemsStatus;
@override@JsonKey() final  PaginationState<PlaceEntity> hiddenGems;
@override@JsonKey() final  String hiddenGemsError;
 final  List<PlaceCategory> _homeCategories;
@override@JsonKey() List<PlaceCategory> get homeCategories {
  if (_homeCategories is EqualUnmodifiableListView) return _homeCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_homeCategories);
}


/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.bannersStatus, bannersStatus) || other.bannersStatus == bannersStatus)&&const DeepCollectionEquality().equals(other._banners, _banners)&&(identical(other.bannersError, bannersError) || other.bannersError == bannersError)&&(identical(other.popularPlacesStatus, popularPlacesStatus) || other.popularPlacesStatus == popularPlacesStatus)&&(identical(other.popularPlaces, popularPlaces) || other.popularPlaces == popularPlaces)&&(identical(other.popularPlacesError, popularPlacesError) || other.popularPlacesError == popularPlacesError)&&(identical(other.categoryPlacesStatus, categoryPlacesStatus) || other.categoryPlacesStatus == categoryPlacesStatus)&&(identical(other.categoryPlaces, categoryPlaces) || other.categoryPlaces == categoryPlaces)&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.categoryPlacesError, categoryPlacesError) || other.categoryPlacesError == categoryPlacesError)&&(identical(other.plannerPreviewsStatus, plannerPreviewsStatus) || other.plannerPreviewsStatus == plannerPreviewsStatus)&&const DeepCollectionEquality().equals(other._plannerPreviews, _plannerPreviews)&&(identical(other.plannerPreviewsError, plannerPreviewsError) || other.plannerPreviewsError == plannerPreviewsError)&&(identical(other.hiddenGemsStatus, hiddenGemsStatus) || other.hiddenGemsStatus == hiddenGemsStatus)&&(identical(other.hiddenGems, hiddenGems) || other.hiddenGems == hiddenGems)&&(identical(other.hiddenGemsError, hiddenGemsError) || other.hiddenGemsError == hiddenGemsError)&&const DeepCollectionEquality().equals(other._homeCategories, _homeCategories));
}


@override
int get hashCode => Object.hash(runtimeType,bannersStatus,const DeepCollectionEquality().hash(_banners),bannersError,popularPlacesStatus,popularPlaces,popularPlacesError,categoryPlacesStatus,categoryPlaces,selectedCategory,categoryPlacesError,plannerPreviewsStatus,const DeepCollectionEquality().hash(_plannerPreviews),plannerPreviewsError,hiddenGemsStatus,hiddenGems,hiddenGemsError,const DeepCollectionEquality().hash(_homeCategories));

@override
String toString() {
  return 'HomeState(bannersStatus: $bannersStatus, banners: $banners, bannersError: $bannersError, popularPlacesStatus: $popularPlacesStatus, popularPlaces: $popularPlaces, popularPlacesError: $popularPlacesError, categoryPlacesStatus: $categoryPlacesStatus, categoryPlaces: $categoryPlaces, selectedCategory: $selectedCategory, categoryPlacesError: $categoryPlacesError, plannerPreviewsStatus: $plannerPreviewsStatus, plannerPreviews: $plannerPreviews, plannerPreviewsError: $plannerPreviewsError, hiddenGemsStatus: $hiddenGemsStatus, hiddenGems: $hiddenGems, hiddenGemsError: $hiddenGemsError, homeCategories: $homeCategories)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 HomeDataStatus bannersStatus, List<BannerEntity> banners, String bannersError, HomeDataStatus popularPlacesStatus, PaginationState<PlaceEntity> popularPlaces, String popularPlacesError, HomeDataStatus categoryPlacesStatus, PaginationState<PlaceEntity> categoryPlaces, PlaceCategory selectedCategory, String categoryPlacesError, HomeDataStatus plannerPreviewsStatus, List<PlannerPreviewEntity> plannerPreviews, String plannerPreviewsError, HomeDataStatus hiddenGemsStatus, PaginationState<PlaceEntity> hiddenGems, String hiddenGemsError, List<PlaceCategory> homeCategories
});


@override $PaginationStateCopyWith<PlaceEntity, $Res> get popularPlaces;@override $PaginationStateCopyWith<PlaceEntity, $Res> get categoryPlaces;@override $PaginationStateCopyWith<PlaceEntity, $Res> get hiddenGems;

}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bannersStatus = null,Object? banners = null,Object? bannersError = null,Object? popularPlacesStatus = null,Object? popularPlaces = null,Object? popularPlacesError = null,Object? categoryPlacesStatus = null,Object? categoryPlaces = null,Object? selectedCategory = null,Object? categoryPlacesError = null,Object? plannerPreviewsStatus = null,Object? plannerPreviews = null,Object? plannerPreviewsError = null,Object? hiddenGemsStatus = null,Object? hiddenGems = null,Object? hiddenGemsError = null,Object? homeCategories = null,}) {
  return _then(_HomeState(
bannersStatus: null == bannersStatus ? _self.bannersStatus : bannersStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,banners: null == banners ? _self._banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerEntity>,bannersError: null == bannersError ? _self.bannersError : bannersError // ignore: cast_nullable_to_non_nullable
as String,popularPlacesStatus: null == popularPlacesStatus ? _self.popularPlacesStatus : popularPlacesStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,popularPlaces: null == popularPlaces ? _self.popularPlaces : popularPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,popularPlacesError: null == popularPlacesError ? _self.popularPlacesError : popularPlacesError // ignore: cast_nullable_to_non_nullable
as String,categoryPlacesStatus: null == categoryPlacesStatus ? _self.categoryPlacesStatus : categoryPlacesStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,categoryPlaces: null == categoryPlaces ? _self.categoryPlaces : categoryPlaces // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,selectedCategory: null == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as PlaceCategory,categoryPlacesError: null == categoryPlacesError ? _self.categoryPlacesError : categoryPlacesError // ignore: cast_nullable_to_non_nullable
as String,plannerPreviewsStatus: null == plannerPreviewsStatus ? _self.plannerPreviewsStatus : plannerPreviewsStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,plannerPreviews: null == plannerPreviews ? _self._plannerPreviews : plannerPreviews // ignore: cast_nullable_to_non_nullable
as List<PlannerPreviewEntity>,plannerPreviewsError: null == plannerPreviewsError ? _self.plannerPreviewsError : plannerPreviewsError // ignore: cast_nullable_to_non_nullable
as String,hiddenGemsStatus: null == hiddenGemsStatus ? _self.hiddenGemsStatus : hiddenGemsStatus // ignore: cast_nullable_to_non_nullable
as HomeDataStatus,hiddenGems: null == hiddenGems ? _self.hiddenGems : hiddenGems // ignore: cast_nullable_to_non_nullable
as PaginationState<PlaceEntity>,hiddenGemsError: null == hiddenGemsError ? _self.hiddenGemsError : hiddenGemsError // ignore: cast_nullable_to_non_nullable
as String,homeCategories: null == homeCategories ? _self._homeCategories : homeCategories // ignore: cast_nullable_to_non_nullable
as List<PlaceCategory>,
  ));
}

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get popularPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.popularPlaces, (value) {
    return _then(_self.copyWith(popularPlaces: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get categoryPlaces {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.categoryPlaces, (value) {
    return _then(_self.copyWith(categoryPlaces: value));
  });
}/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationStateCopyWith<PlaceEntity, $Res> get hiddenGems {
  
  return $PaginationStateCopyWith<PlaceEntity, $Res>(_self.hiddenGems, (value) {
    return _then(_self.copyWith(hiddenGems: value));
  });
}
}

// dart format on
