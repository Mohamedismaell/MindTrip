import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';

part 'collected_planner_data_model.freezed.dart';
part 'collected_planner_data_model.g.dart';

@freezed
abstract class CollectedDataModel with _$CollectedDataModel {
  const factory CollectedDataModel({
    @JsonKey(fromJson: parseString) @Default('') String destination,

    @JsonKey(fromJson: parseInt) @Default(0) int days,

    @JsonKey(fromJson: parseInt) @Default(0) int budget,

    @JsonKey(fromJson: parseStringList)
    @Default(<String>[])
    List<String> interests,

    @JsonKey(fromJson: parseInt) @Default(0) int people,

    @JsonKey(fromJson: parseStringList)
    @Default(<String>[])
    List<String> mustInclude,
  }) = _CollectedDataModel;

  factory CollectedDataModel.fromJson(Map<String, dynamic> json) =>
      _$CollectedDataModelFromJson(json);

  factory CollectedDataModel.fromEntity(CollectedPlannerDataEntity entity) =>
      CollectedDataModel(
        destination: entity.destination,
        days: entity.days,
        budget: entity.budget,
        interests: entity.interests,
        people: entity.people,
        mustInclude: entity.mustInclude,
      );

  factory CollectedDataModel.empty() => const CollectedDataModel();
}

extension CollectedDataModelMapper on CollectedDataModel {
  CollectedPlannerDataEntity toEntity() {
    return CollectedPlannerDataEntity(
      destination: destination,
      days: days,
      budget: budget,
      interests: interests,
      people: people,
      mustInclude: mustInclude,
    );
  }
}

extension CollectedPlannerDataEntityMapper on CollectedPlannerDataEntity {
  CollectedDataModel toModel() {
    return CollectedDataModel(
      destination: destination,
      days: days,
      budget: budget,
      interests: interests,
      people: people,
      mustInclude: mustInclude,
    );
  }
}
