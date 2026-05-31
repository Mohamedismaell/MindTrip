import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
abstract class LocationModel with _$LocationModel {
  @HiveType(typeId: 2, adapterName: 'LocationModelAdapter')
  const factory LocationModel({
    @JsonKey(name: 'location') @HiveField(0) @Default('') String address,
    @HiveField(1) @Default(0.0) double latitude,
    @HiveField(2) @Default(0.0) double longitude,
  }) = _LocationModel;

  const LocationModel._();

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
}
