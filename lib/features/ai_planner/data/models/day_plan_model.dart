import 'package:equatable/equatable.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

enum PlaceDayPeriod { morning, afternoon, evening }

class DayPlanModel extends Equatable {
  const DayPlanModel({
    this.morning = const [],
    this.afternoon = const [],
    this.evening = const [],
  });

  final List<PlanPlaceModel> morning;
  final List<PlanPlaceModel> afternoon;
  final List<PlanPlaceModel> evening;

  List<PlanPlaceModel> get allPlaces => [...morning, ...afternoon, ...evening];

  factory DayPlanModel.fromJson(Map<String, dynamic> json) {
    return DayPlanModel(
      morning: _parsePlaces(json['morning']),
      afternoon: _parsePlaces(json['afternoon']),
      evening: _parsePlaces(json['evening']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'morning': morning.map((e) => e.toJson()).toList(),
      'afternoon': afternoon.map((e) => e.toJson()).toList(),
      'evening': evening.map((e) => e.toJson()).toList(),
    };
  }

  DayPlanModel copyWith({
    List<PlanPlaceModel>? morning,
    List<PlanPlaceModel>? afternoon,
    List<PlanPlaceModel>? evening,
  }) {
    return DayPlanModel(
      morning: morning ?? this.morning,
      afternoon: afternoon ?? this.afternoon,
      evening: evening ?? this.evening,
    );
  }

  @override
  List<Object?> get props => [morning, afternoon, evening];
}

List<PlanPlaceModel> _parsePlaces(dynamic value) {
  if (value is! List) return const [];

  return value
      .whereType<Map<String, dynamic>>()
      .map(PlanPlaceModel.fromJson)
      .toList();
}
