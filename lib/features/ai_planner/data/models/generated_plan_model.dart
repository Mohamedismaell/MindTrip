import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_model.dart';

class GeneratedPlanModel extends Equatable {
  const GeneratedPlanModel({
    this.tripId = '',
    this.status = '',
    this.people = 0,
    this.totalCalculatedCost = 0,
    this.daysCount = 0,
    this.plan,
  });

  final String tripId;
  final String status;
  final int people;
  final int totalCalculatedCost;
  final int daysCount;
  final PlanModel? plan;

  factory GeneratedPlanModel.fromJson(Map<String, dynamic> json) {
    return GeneratedPlanModel(
      tripId: parseString(json['trip_id']),
      status: parseString(json['status']),
      people: parseInt(json['people']),
      totalCalculatedCost: parseInt(json['total_calculated_cost']),
      daysCount: parseInt(json['days_count']),
      plan: json['plan'] is Map<String, dynamic>
          ? PlanModel.fromJson(json['plan'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trip_id': tripId,
      'status': status,
      'people': people,
      'total_calculated_cost': totalCalculatedCost,
      'days_count': daysCount,
      'plan': plan?.toJson(),
    };
  }

  GeneratedPlanModel copyWith({
    String? tripId,
    String? status,
    int? people,
    int? totalCalculatedCost,
    int? daysCount,
    PlanModel? plan,
  }) {
    return GeneratedPlanModel(
      tripId: tripId ?? this.tripId,
      status: status ?? this.status,
      people: people ?? this.people,
      totalCalculatedCost: totalCalculatedCost ?? this.totalCalculatedCost,
      daysCount: daysCount ?? this.daysCount,
      plan: plan ?? this.plan,
    );
  }

  @override
  List<Object?> get props => [
    tripId,
    status,
    people,
    totalCalculatedCost,
    daysCount,
    plan,
  ];
}
