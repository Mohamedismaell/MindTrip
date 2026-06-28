import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

part 'generate_plan_request_model.freezed.dart';
part 'generate_plan_request_model.g.dart';

@freezed
abstract class GeneratePlanMustIncludeItem with _$GeneratePlanMustIncludeItem {
  const factory GeneratePlanMustIncludeItem({
    required String name,
    @JsonKey(name: 'place_id', includeIfNull: false) String? placeId,
    @JsonKey(includeIfNull: false) String? type,
  }) = _GeneratePlanMustIncludeItem;

  factory GeneratePlanMustIncludeItem.fromJson(Map<String, dynamic> json) =>
      _$GeneratePlanMustIncludeItemFromJson(json);
}

@freezed
abstract class GeneratePlanRequestModel with _$GeneratePlanRequestModel {
  @JsonSerializable(explicitToJson: true)
  const factory GeneratePlanRequestModel({
    required String city,
    required int days,
    required int budget,
    required int people,
    required List<String> interests,
    @JsonKey(name: 'must_include')
    @Default([])
    List<GeneratePlanMustIncludeItem> mustInclude,
  }) = _GeneratePlanRequestModel;

  factory GeneratePlanRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GeneratePlanRequestModelFromJson(json);

  factory GeneratePlanRequestModel.fromTrip(Trip trip) {
    final collected = trip.collected;

    return GeneratePlanRequestModel(
      city: trip.city,
      days: collected?.days ?? trip.durationDays,
      budget: collected?.budget ?? trip.totalBudget,
      people: collected?.people ?? trip.people,
      interests: collected?.interests ?? const [],
      mustInclude: (collected?.mustInclude ?? const [])
          .map((name) => GeneratePlanMustIncludeItem(name: name))
          .toList(),
    );
  }
}
