import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/data/models/chat_collected_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';

part 'chat_response_model.freezed.dart';
part 'chat_response_model.g.dart';

@freezed
abstract class ChatResponseModel with _$ChatResponseModel {
  const factory ChatResponseModel({
    @JsonKey(fromJson: parseString) @Default('') String status,
    @JsonKey(fromJson: parseString) @Default('') String output,
    @Default(CollectedDataModel()) CollectedDataModel collected,
    @JsonKey(fromJson: parseStringList) @Default([]) List<String> missing,
  }) = _ChatResponseModel;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseModelFromJson(json);
}

extension ChatResponseModelMapper on ChatResponseModel {
  ChatResponse toEntity() {
    return ChatResponse(
      status: status,
      output: output,
      collected: collected.toEntity(),
      missing: missing,
    );
  }
}
