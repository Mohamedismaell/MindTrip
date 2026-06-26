import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/chat_response.dart';

class ChatResponseModel extends Equatable {
  const ChatResponseModel({
    this.status = '',
    this.output = '',
    this.collected = const CollectedDataModel(),
    this.missing = const [],
  });

  final String status;
  final String output;
  final CollectedDataModel collected;
  final List<String> missing;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      status: parseString(json['status']),
      output: parseString(json['output']),
      collected: json['collected'] is Map<String, dynamic>
          ? CollectedDataModel.fromJson(
              json['collected'] as Map<String, dynamic>,
            )
          : CollectedDataModel.empty(),
      missing: parseStringList(json['missing']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'output': output,
      'collected': collected.toJson(),
      'missing': missing,
    };
  }

  ChatResponseModel copyWith({
    String? status,
    String? output,
    CollectedDataModel? collected,
    List<String>? missing,
  }) {
    return ChatResponseModel(
      status: status ?? this.status,
      output: output ?? this.output,
      collected: collected ?? this.collected,
      missing: missing ?? this.missing,
    );
  }

  @override
  List<Object?> get props => [status, output, collected, missing];
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
