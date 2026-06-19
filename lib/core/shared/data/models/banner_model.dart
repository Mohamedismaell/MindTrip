import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/adapters.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
@HiveType(typeId: 10)
abstract class BannerModel with _$BannerModel {
  const factory BannerModel({
    @HiveField(0) @Default('') String id,
    @HiveField(1) @Default('') String title,
    @HiveField(2) @Default('') String imageUrl,
    @HiveField(3) String? targetUrl,
  }) = _BannerModel;

  const BannerModel._();

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
