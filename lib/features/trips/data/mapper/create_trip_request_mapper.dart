import 'dart:math' as math;

import 'package:mindtrip/features/ai_planner/data/mapper/generated_plan_mapper.dart';
import 'package:mindtrip/features/ai_planner/data/models/collected_planner_data_model.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/collected_planner_data_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/trips/data/models/create_trip_request_model.dart';

extension CreateTripRequestMapper on GeneratedPlanEntity {
  CreateTripRequestModel toCreateTripRequest({
    required CollectedPlannerDataEntity collected,
    required String sessionId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    final resolvedDestination = collected.destination.isEmpty
        ? 'Unknown'
        : collected.destination;

    DateTime? resolvedStartDate = startDate;
    DateTime? resolvedEndDate = endDate;

    if (resolvedStartDate == null &&
        collected.date != null &&
        collected.date!.isNotEmpty) {
      resolvedStartDate = DateTime.parse(collected.date!);
    }

    if (resolvedEndDate == null && resolvedStartDate != null) {
      resolvedEndDate = resolvedStartDate.add(
        Duration(days: collected.days > 0 ? collected.days - 1 : 0),
      );
    }

    final safeBudget = collected.budget > 0 ? collected.budget : 0;
    final safeTotalCost = totalCalculatedCost > 0 ? totalCalculatedCost : 0;
    final biggestAmount = math.max(safeBudget, safeTotalCost);

    return CreateTripRequestModel(
      title: 'Trip to $resolvedDestination',
      destinationGovernorate: resolvedDestination,
      city: resolvedDestination,
      startDate: resolvedStartDate?.toIso8601String(),
      endDate: resolvedEndDate?.toIso8601String(),
      people: collected.people > 0 ? collected.people : people,
      totalBudgetEgp: biggestAmount,
      totalCost: biggestAmount,
      plan: toModel(),
      collected: CollectedDataModel.fromEntity(collected),
      sessionId: sessionId,
      isPublic: true,
    );
  }
}
