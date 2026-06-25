import 'dart:convert';

import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_json_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

extension CreateTripRequestMapper on Trip {
  CreateTripRequestModel toCreateTripRequest({
    required GeneratedPlanEntity plan,
  }) {
    final planJson = plan.toModel().toJson();

    return CreateTripRequestModel(
      title: title,
      destinationGovernorate: destinationGovernorate ?? destination,
      city: destination,
      startDate: tripStart?.toIso8601String(),
      endDate: tripEnd?.toIso8601String(),
      people: people,
      totalBudgetEgp: totalBudget,
      totalCost: totalCost,

      plan: planJson['plan'] as Map<String, dynamic>,

      collected: jsonEncode(planJson),

      sessionId: sessionId,

      isPublic: true,

      status: 0,
    );
  }
}
