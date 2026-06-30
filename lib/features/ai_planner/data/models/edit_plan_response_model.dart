import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/utils/json_parser.dart';
import 'package:mindtrip/features/ai_planner/data/models/generated_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

class EditPlanResponseModel extends Equatable {
  const EditPlanResponseModel({
    required this.mode,
    this.message,
    this.tripId,
    this.status,
    this.changeApplied,
    this.askForReplacement,
    this.insertAfter,
    this.item,
    this.people,
    this.totalCalculatedCost,
    this.daysCount,
    this.needsReplan,
    this.plan,
  });

  final String mode;
  final String? message;
  final String? tripId;
  final String? status;
  final String? changeApplied;
  final bool? askForReplacement;
  final String? insertAfter;
  final PlanPlaceModel? item;
  final int? people;
  final double? totalCalculatedCost;
  final int? daysCount;
  final bool? needsReplan;
  final GeneratedPlanModel? plan;

  factory EditPlanResponseModel.fromJson(Map<String, dynamic> json) {
    GeneratedPlanModel? generatedPlan;

    if (json['plan'] != null && json['plan'] is Map<String, dynamic>) {
      final innerPlan = json['plan'] as Map<String, dynamic>;

      if (innerPlan.containsKey('plan')) {
        generatedPlan = GeneratedPlanModel.fromJson(innerPlan);
      } else {
        generatedPlan = GeneratedPlanModel(
          tripId: parseString(json['trip_id']),
          status: parseString(json['status']),
          people: parseInt(json['people']),
          totalCalculatedCost: parseInt(json['total_calculated_cost']),
          daysCount: parseInt(json['days_count']),
          plan: PlanModel.fromJson(innerPlan),
        );
      }
    }

    return EditPlanResponseModel(
      mode: parseString(json['mode']),
      message: json['message']?.toString(),
      tripId: json['trip_id']?.toString(),
      status: json['status']?.toString(),
      changeApplied: json['change_applied']?.toString(),
      askForReplacement: json['ask_for_replacement'] as bool?,
      insertAfter: json['insert_after']?.toString(),
      item: json['item'] is Map<String, dynamic>
          ? PlanPlaceModel.fromJson(json['item'] as Map<String, dynamic>)
          : null,
      people: json['people'] == null ? null : parseInt(json['people']),
      totalCalculatedCost: json['total_calculated_cost'] == null
          ? null
          : parseDouble(json['total_calculated_cost']),
      daysCount: json['days_count'] == null
          ? null
          : parseInt(json['days_count']),
      needsReplan: json['needs_replan'] as bool?,
      plan: generatedPlan,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode,
      'message': message,
      'trip_id': tripId,
      'status': status,
      'change_applied': changeApplied,
      'ask_for_replacement': askForReplacement,
      'insert_after': insertAfter,
      'item': item?.toJson(),
      'people': people,
      'total_calculated_cost': totalCalculatedCost,
      'days_count': daysCount,
      'needs_replan': needsReplan,
      'plan': plan?.toJson(),
    };
  }

  EditPlanResponseModel copyWith({
    String? mode,
    String? message,
    String? tripId,
    String? status,
    String? changeApplied,
    bool? askForReplacement,
    String? insertAfter,
    PlanPlaceModel? item,
    int? people,
    double? totalCalculatedCost,
    int? daysCount,
    bool? needsReplan,
    GeneratedPlanModel? plan,
  }) {
    return EditPlanResponseModel(
      mode: mode ?? this.mode,
      message: message ?? this.message,
      tripId: tripId ?? this.tripId,
      status: status ?? this.status,
      changeApplied: changeApplied ?? this.changeApplied,
      askForReplacement: askForReplacement ?? this.askForReplacement,
      insertAfter: insertAfter ?? this.insertAfter,
      item: item ?? this.item,
      people: people ?? this.people,
      totalCalculatedCost: totalCalculatedCost ?? this.totalCalculatedCost,
      daysCount: daysCount ?? this.daysCount,
      needsReplan: needsReplan ?? this.needsReplan,
      plan: plan ?? this.plan,
    );
  }

  @override
  List<Object?> get props => [
    mode,
    message,
    tripId,
    status,
    changeApplied,
    askForReplacement,
    insertAfter,
    item,
    people,
    totalCalculatedCost,
    daysCount,
    needsReplan,
    plan,
  ];
}
