import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
abstract class BannerModel with _$BannerModel {
  const factory BannerModel({
    @Default('') String id,
    @Default('') String title,
    @Default('') String imageUrl,
    String? targetUrl,
  }) = _BannerModel;

  const BannerModel._();

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
}
