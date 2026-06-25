// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_place_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanPlaceModel {

@JsonKey(name: 'place_id', fromJson: parseString) String get placeId;@JsonKey(fromJson: parseString) String get name;@JsonKey(fromJson: parseString) String get city;@JsonKey(name: 'city_en', fromJson: parseString) String get cityEn;@JsonKey(fromJson: parseStringList) List<String> get interests;@JsonKey(fromJson: parseString) String get category;@JsonKey(fromJson: parseDouble) double get rating;@JsonKey(name: 'reviews_count', fromJson: parseInt) int get reviewsCount;@JsonKey(fromJson: parseString) String get address;@JsonKey(fromJson: parseString) String get description;@JsonKey(name: 'photo_url', fromJson: parseString) String get photoUrl;@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> get imageUrls;@JsonKey(name: 'maps_url', fromJson: parseString) String get mapsUrl;@JsonKey(name: 'opening_hours', fromJson: parseString) String get openingHours;@JsonKey(name: 'is_opened', fromJson: parseBool) bool get isOpened;@JsonKey(fromJson: parseDouble) double get lat;@JsonKey(fromJson: parseDouble) double get lng;@JsonKey(fromJson: parseDay) int get day;@JsonKey(fromJson: parseString) String get type;@JsonKey(fromJson: parseInt) int get price;@JsonKey(fromJson: parseInt) int get cost;@JsonKey(name: 'is_hidden_gem', fromJson: parseBool) bool get isHiddenGem;
/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanPlaceModelCopyWith<PlanPlaceModel> get copyWith => _$PlanPlaceModelCopyWithImpl<PlanPlaceModel>(this as PlanPlaceModel, _$identity);

  /// Serializes this PlanPlaceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanPlaceModel&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.cityEn, cityEn) || other.cityEn == cityEn)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpened, isOpened) || other.isOpened == isOpened)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.day, day) || other.day == day)&&(identical(other.type, type) || other.type == type)&&(identical(other.price, price) || other.price == price)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.isHiddenGem, isHiddenGem) || other.isHiddenGem == isHiddenGem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,city,cityEn,const DeepCollectionEquality().hash(interests),category,rating,reviewsCount,address,description,photoUrl,const DeepCollectionEquality().hash(imageUrls),mapsUrl,openingHours,isOpened,lat,lng,day,type,price,cost,isHiddenGem]);

@override
String toString() {
  return 'PlanPlaceModel(placeId: $placeId, name: $name, city: $city, cityEn: $cityEn, interests: $interests, category: $category, rating: $rating, reviewsCount: $reviewsCount, address: $address, description: $description, photoUrl: $photoUrl, imageUrls: $imageUrls, mapsUrl: $mapsUrl, openingHours: $openingHours, isOpened: $isOpened, lat: $lat, lng: $lng, day: $day, type: $type, price: $price, cost: $cost, isHiddenGem: $isHiddenGem)';
}


}

/// @nodoc
abstract mixin class $PlanPlaceModelCopyWith<$Res>  {
  factory $PlanPlaceModelCopyWith(PlanPlaceModel value, $Res Function(PlanPlaceModel) _then) = _$PlanPlaceModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'place_id', fromJson: parseString) String placeId,@JsonKey(fromJson: parseString) String name,@JsonKey(fromJson: parseString) String city,@JsonKey(name: 'city_en', fromJson: parseString) String cityEn,@JsonKey(fromJson: parseStringList) List<String> interests,@JsonKey(fromJson: parseString) String category,@JsonKey(fromJson: parseDouble) double rating,@JsonKey(name: 'reviews_count', fromJson: parseInt) int reviewsCount,@JsonKey(fromJson: parseString) String address,@JsonKey(fromJson: parseString) String description,@JsonKey(name: 'photo_url', fromJson: parseString) String photoUrl,@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> imageUrls,@JsonKey(name: 'maps_url', fromJson: parseString) String mapsUrl,@JsonKey(name: 'opening_hours', fromJson: parseString) String openingHours,@JsonKey(name: 'is_opened', fromJson: parseBool) bool isOpened,@JsonKey(fromJson: parseDouble) double lat,@JsonKey(fromJson: parseDouble) double lng,@JsonKey(fromJson: parseDay) int day,@JsonKey(fromJson: parseString) String type,@JsonKey(fromJson: parseInt) int price,@JsonKey(fromJson: parseInt) int cost,@JsonKey(name: 'is_hidden_gem', fromJson: parseBool) bool isHiddenGem
});




}
/// @nodoc
class _$PlanPlaceModelCopyWithImpl<$Res>
    implements $PlanPlaceModelCopyWith<$Res> {
  _$PlanPlaceModelCopyWithImpl(this._self, this._then);

  final PlanPlaceModel _self;
  final $Res Function(PlanPlaceModel) _then;

/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? name = null,Object? city = null,Object? cityEn = null,Object? interests = null,Object? category = null,Object? rating = null,Object? reviewsCount = null,Object? address = null,Object? description = null,Object? photoUrl = null,Object? imageUrls = null,Object? mapsUrl = null,Object? openingHours = null,Object? isOpened = null,Object? lat = null,Object? lng = null,Object? day = null,Object? type = null,Object? price = null,Object? cost = null,Object? isHiddenGem = null,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,cityEn: null == cityEn ? _self.cityEn : cityEn // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String,isOpened: null == isOpened ? _self.isOpened : isOpened // ignore: cast_nullable_to_non_nullable
as bool,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,isHiddenGem: null == isHiddenGem ? _self.isHiddenGem : isHiddenGem // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanPlaceModel].
extension PlanPlaceModelPatterns on PlanPlaceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanPlaceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanPlaceModel value)  $default,){
final _that = this;
switch (_that) {
case _PlanPlaceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanPlaceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id', fromJson: parseString)  String placeId, @JsonKey(fromJson: parseString)  String name, @JsonKey(fromJson: parseString)  String city, @JsonKey(name: 'city_en', fromJson: parseString)  String cityEn, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(fromJson: parseString)  String category, @JsonKey(fromJson: parseDouble)  double rating, @JsonKey(name: 'reviews_count', fromJson: parseInt)  int reviewsCount, @JsonKey(fromJson: parseString)  String address, @JsonKey(fromJson: parseString)  String description, @JsonKey(name: 'photo_url', fromJson: parseString)  String photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList)  List<String> imageUrls, @JsonKey(name: 'maps_url', fromJson: parseString)  String mapsUrl, @JsonKey(name: 'opening_hours', fromJson: parseString)  String openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool)  bool isOpened, @JsonKey(fromJson: parseDouble)  double lat, @JsonKey(fromJson: parseDouble)  double lng, @JsonKey(fromJson: parseDay)  int day, @JsonKey(fromJson: parseString)  String type, @JsonKey(fromJson: parseInt)  int price, @JsonKey(fromJson: parseInt)  int cost, @JsonKey(name: 'is_hidden_gem', fromJson: parseBool)  bool isHiddenGem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.interests,_that.category,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.mapsUrl,_that.openingHours,_that.isOpened,_that.lat,_that.lng,_that.day,_that.type,_that.price,_that.cost,_that.isHiddenGem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'place_id', fromJson: parseString)  String placeId, @JsonKey(fromJson: parseString)  String name, @JsonKey(fromJson: parseString)  String city, @JsonKey(name: 'city_en', fromJson: parseString)  String cityEn, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(fromJson: parseString)  String category, @JsonKey(fromJson: parseDouble)  double rating, @JsonKey(name: 'reviews_count', fromJson: parseInt)  int reviewsCount, @JsonKey(fromJson: parseString)  String address, @JsonKey(fromJson: parseString)  String description, @JsonKey(name: 'photo_url', fromJson: parseString)  String photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList)  List<String> imageUrls, @JsonKey(name: 'maps_url', fromJson: parseString)  String mapsUrl, @JsonKey(name: 'opening_hours', fromJson: parseString)  String openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool)  bool isOpened, @JsonKey(fromJson: parseDouble)  double lat, @JsonKey(fromJson: parseDouble)  double lng, @JsonKey(fromJson: parseDay)  int day, @JsonKey(fromJson: parseString)  String type, @JsonKey(fromJson: parseInt)  int price, @JsonKey(fromJson: parseInt)  int cost, @JsonKey(name: 'is_hidden_gem', fromJson: parseBool)  bool isHiddenGem)  $default,) {final _that = this;
switch (_that) {
case _PlanPlaceModel():
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.interests,_that.category,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.mapsUrl,_that.openingHours,_that.isOpened,_that.lat,_that.lng,_that.day,_that.type,_that.price,_that.cost,_that.isHiddenGem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'place_id', fromJson: parseString)  String placeId, @JsonKey(fromJson: parseString)  String name, @JsonKey(fromJson: parseString)  String city, @JsonKey(name: 'city_en', fromJson: parseString)  String cityEn, @JsonKey(fromJson: parseStringList)  List<String> interests, @JsonKey(fromJson: parseString)  String category, @JsonKey(fromJson: parseDouble)  double rating, @JsonKey(name: 'reviews_count', fromJson: parseInt)  int reviewsCount, @JsonKey(fromJson: parseString)  String address, @JsonKey(fromJson: parseString)  String description, @JsonKey(name: 'photo_url', fromJson: parseString)  String photoUrl, @JsonKey(name: 'image_urls', fromJson: parseStringList)  List<String> imageUrls, @JsonKey(name: 'maps_url', fromJson: parseString)  String mapsUrl, @JsonKey(name: 'opening_hours', fromJson: parseString)  String openingHours, @JsonKey(name: 'is_opened', fromJson: parseBool)  bool isOpened, @JsonKey(fromJson: parseDouble)  double lat, @JsonKey(fromJson: parseDouble)  double lng, @JsonKey(fromJson: parseDay)  int day, @JsonKey(fromJson: parseString)  String type, @JsonKey(fromJson: parseInt)  int price, @JsonKey(fromJson: parseInt)  int cost, @JsonKey(name: 'is_hidden_gem', fromJson: parseBool)  bool isHiddenGem)?  $default,) {final _that = this;
switch (_that) {
case _PlanPlaceModel() when $default != null:
return $default(_that.placeId,_that.name,_that.city,_that.cityEn,_that.interests,_that.category,_that.rating,_that.reviewsCount,_that.address,_that.description,_that.photoUrl,_that.imageUrls,_that.mapsUrl,_that.openingHours,_that.isOpened,_that.lat,_that.lng,_that.day,_that.type,_that.price,_that.cost,_that.isHiddenGem);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanPlaceModel implements PlanPlaceModel {
  const _PlanPlaceModel({@JsonKey(name: 'place_id', fromJson: parseString) this.placeId = '', @JsonKey(fromJson: parseString) this.name = '', @JsonKey(fromJson: parseString) this.city = '', @JsonKey(name: 'city_en', fromJson: parseString) this.cityEn = '', @JsonKey(fromJson: parseStringList) final  List<String> interests = const [], @JsonKey(fromJson: parseString) this.category = '', @JsonKey(fromJson: parseDouble) this.rating = 0.0, @JsonKey(name: 'reviews_count', fromJson: parseInt) this.reviewsCount = 0, @JsonKey(fromJson: parseString) this.address = '', @JsonKey(fromJson: parseString) this.description = '', @JsonKey(name: 'photo_url', fromJson: parseString) this.photoUrl = '', @JsonKey(name: 'image_urls', fromJson: parseStringList) final  List<String> imageUrls = const [], @JsonKey(name: 'maps_url', fromJson: parseString) this.mapsUrl = '', @JsonKey(name: 'opening_hours', fromJson: parseString) this.openingHours = '', @JsonKey(name: 'is_opened', fromJson: parseBool) this.isOpened = false, @JsonKey(fromJson: parseDouble) this.lat = 0.0, @JsonKey(fromJson: parseDouble) this.lng = 0.0, @JsonKey(fromJson: parseDay) this.day = 0, @JsonKey(fromJson: parseString) this.type = '', @JsonKey(fromJson: parseInt) this.price = 0, @JsonKey(fromJson: parseInt) this.cost = 0, @JsonKey(name: 'is_hidden_gem', fromJson: parseBool) this.isHiddenGem = false}): _interests = interests,_imageUrls = imageUrls;
  factory _PlanPlaceModel.fromJson(Map<String, dynamic> json) => _$PlanPlaceModelFromJson(json);

@override@JsonKey(name: 'place_id', fromJson: parseString) final  String placeId;
@override@JsonKey(fromJson: parseString) final  String name;
@override@JsonKey(fromJson: parseString) final  String city;
@override@JsonKey(name: 'city_en', fromJson: parseString) final  String cityEn;
 final  List<String> _interests;
@override@JsonKey(fromJson: parseStringList) List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override@JsonKey(fromJson: parseString) final  String category;
@override@JsonKey(fromJson: parseDouble) final  double rating;
@override@JsonKey(name: 'reviews_count', fromJson: parseInt) final  int reviewsCount;
@override@JsonKey(fromJson: parseString) final  String address;
@override@JsonKey(fromJson: parseString) final  String description;
@override@JsonKey(name: 'photo_url', fromJson: parseString) final  String photoUrl;
 final  List<String> _imageUrls;
@override@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override@JsonKey(name: 'maps_url', fromJson: parseString) final  String mapsUrl;
@override@JsonKey(name: 'opening_hours', fromJson: parseString) final  String openingHours;
@override@JsonKey(name: 'is_opened', fromJson: parseBool) final  bool isOpened;
@override@JsonKey(fromJson: parseDouble) final  double lat;
@override@JsonKey(fromJson: parseDouble) final  double lng;
@override@JsonKey(fromJson: parseDay) final  int day;
@override@JsonKey(fromJson: parseString) final  String type;
@override@JsonKey(fromJson: parseInt) final  int price;
@override@JsonKey(fromJson: parseInt) final  int cost;
@override@JsonKey(name: 'is_hidden_gem', fromJson: parseBool) final  bool isHiddenGem;

/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanPlaceModelCopyWith<_PlanPlaceModel> get copyWith => __$PlanPlaceModelCopyWithImpl<_PlanPlaceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanPlaceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanPlaceModel&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.cityEn, cityEn) || other.cityEn == cityEn)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.mapsUrl, mapsUrl) || other.mapsUrl == mapsUrl)&&(identical(other.openingHours, openingHours) || other.openingHours == openingHours)&&(identical(other.isOpened, isOpened) || other.isOpened == isOpened)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.day, day) || other.day == day)&&(identical(other.type, type) || other.type == type)&&(identical(other.price, price) || other.price == price)&&(identical(other.cost, cost) || other.cost == cost)&&(identical(other.isHiddenGem, isHiddenGem) || other.isHiddenGem == isHiddenGem));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,city,cityEn,const DeepCollectionEquality().hash(_interests),category,rating,reviewsCount,address,description,photoUrl,const DeepCollectionEquality().hash(_imageUrls),mapsUrl,openingHours,isOpened,lat,lng,day,type,price,cost,isHiddenGem]);

@override
String toString() {
  return 'PlanPlaceModel(placeId: $placeId, name: $name, city: $city, cityEn: $cityEn, interests: $interests, category: $category, rating: $rating, reviewsCount: $reviewsCount, address: $address, description: $description, photoUrl: $photoUrl, imageUrls: $imageUrls, mapsUrl: $mapsUrl, openingHours: $openingHours, isOpened: $isOpened, lat: $lat, lng: $lng, day: $day, type: $type, price: $price, cost: $cost, isHiddenGem: $isHiddenGem)';
}


}

/// @nodoc
abstract mixin class _$PlanPlaceModelCopyWith<$Res> implements $PlanPlaceModelCopyWith<$Res> {
  factory _$PlanPlaceModelCopyWith(_PlanPlaceModel value, $Res Function(_PlanPlaceModel) _then) = __$PlanPlaceModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'place_id', fromJson: parseString) String placeId,@JsonKey(fromJson: parseString) String name,@JsonKey(fromJson: parseString) String city,@JsonKey(name: 'city_en', fromJson: parseString) String cityEn,@JsonKey(fromJson: parseStringList) List<String> interests,@JsonKey(fromJson: parseString) String category,@JsonKey(fromJson: parseDouble) double rating,@JsonKey(name: 'reviews_count', fromJson: parseInt) int reviewsCount,@JsonKey(fromJson: parseString) String address,@JsonKey(fromJson: parseString) String description,@JsonKey(name: 'photo_url', fromJson: parseString) String photoUrl,@JsonKey(name: 'image_urls', fromJson: parseStringList) List<String> imageUrls,@JsonKey(name: 'maps_url', fromJson: parseString) String mapsUrl,@JsonKey(name: 'opening_hours', fromJson: parseString) String openingHours,@JsonKey(name: 'is_opened', fromJson: parseBool) bool isOpened,@JsonKey(fromJson: parseDouble) double lat,@JsonKey(fromJson: parseDouble) double lng,@JsonKey(fromJson: parseDay) int day,@JsonKey(fromJson: parseString) String type,@JsonKey(fromJson: parseInt) int price,@JsonKey(fromJson: parseInt) int cost,@JsonKey(name: 'is_hidden_gem', fromJson: parseBool) bool isHiddenGem
});




}
/// @nodoc
class __$PlanPlaceModelCopyWithImpl<$Res>
    implements _$PlanPlaceModelCopyWith<$Res> {
  __$PlanPlaceModelCopyWithImpl(this._self, this._then);

  final _PlanPlaceModel _self;
  final $Res Function(_PlanPlaceModel) _then;

/// Create a copy of PlanPlaceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? name = null,Object? city = null,Object? cityEn = null,Object? interests = null,Object? category = null,Object? rating = null,Object? reviewsCount = null,Object? address = null,Object? description = null,Object? photoUrl = null,Object? imageUrls = null,Object? mapsUrl = null,Object? openingHours = null,Object? isOpened = null,Object? lat = null,Object? lng = null,Object? day = null,Object? type = null,Object? price = null,Object? cost = null,Object? isHiddenGem = null,}) {
  return _then(_PlanPlaceModel(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,cityEn: null == cityEn ? _self.cityEn : cityEn // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,photoUrl: null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,mapsUrl: null == mapsUrl ? _self.mapsUrl : mapsUrl // ignore: cast_nullable_to_non_nullable
as String,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as String,isOpened: null == isOpened ? _self.isOpened : isOpened // ignore: cast_nullable_to_non_nullable
as bool,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,cost: null == cost ? _self.cost : cost // ignore: cast_nullable_to_non_nullable
as int,isHiddenGem: null == isHiddenGem ? _self.isHiddenGem : isHiddenGem // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
