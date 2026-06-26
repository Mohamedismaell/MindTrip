import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data.dart';

part 'chat_collected_data_model.freezed.dart';
part 'chat_collected_data_model.g.dart';

@freezed
abstract class ChatCollectedDataModel with _$ChatCollectedDataModel {
  const factory ChatCollectedDataModel({
    @JsonKey(fromJson: parseString) @Default('') String destination,
    @JsonKey(fromJson: parseInt) @Default(0) int days,
    @JsonKey(fromJson: parseInt) @Default(0) int budget,
    @JsonKey(fromJson: parseStringList) @Default([]) List<String> interests,
    @JsonKey(fromJson: parseInt) @Default(0) int people,
    @JsonKey(
      name: 'mustInclude',
      readValue: ChatCollectedDataModel._readMustInclude,
      fromJson: ChatCollectedDataModel._parseMustInclude,
    )
    @Default([])
    List<String> mustInclude,
  }) = _ChatCollectedDataModel;

  factory ChatCollectedDataModel.fromJson(Map<String, dynamic> json) =>
      _$ChatCollectedDataModelFromJson(json);

  factory ChatCollectedDataModel.fromEntity(CollectedPlannerData entity) {
    return ChatCollectedDataModel(
      destination: entity.destination,
      days: entity.days,
      budget: entity.budget,
      interests: entity.interests,
      people: entity.people,
      mustInclude: entity.mustInclude,
    );
  }

  factory ChatCollectedDataModel.empty() => const ChatCollectedDataModel();

  static List<String> _parseMustInclude(dynamic value) {
    return parseStringList(value);
  }

  static Object? _readMustInclude(Map json, String key) {
    return json[key] ?? json['must_include'];
  }
}

extension ChatCollectedDataModelMapper on ChatCollectedDataModel {
  CollectedPlannerData toEntity() {
    return CollectedPlannerData(
      destination: destination,
      days: days,
      budget: budget,
      interests: interests,
      people: people,
      mustInclude: mustInclude,
    );
  }

  Map<String, dynamic> toCardAnswersJson() {
    return {
      'destination': destination,
      'days': days,
      'budget': budget,
      'interests': interests,
      'people': people,
      'must_include': mustInclude,
    };
  }
}
