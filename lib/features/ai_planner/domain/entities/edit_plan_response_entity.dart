import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/generated_plan_entity.dart';
import 'package:mindtrip/features/ai_planner/domain/entities/plan_place_entity.dart';

class EditPlanResponseEntity extends Equatable {
  final String mode;
  final String? message;
  final String? tripId;
  final String? status;
  final String? changeApplied;
  final bool? askForReplacement;
  final String? insertAfter;
  final PlanPlaceEntity? item;
  final int? people;
  final double? totalCalculatedCost;
  final int? daysCount;
  final bool? needsReplan;
  final GeneratedPlanEntity? plan;

  const EditPlanResponseEntity({
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
