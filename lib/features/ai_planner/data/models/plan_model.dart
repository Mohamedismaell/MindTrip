import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/ai_planner/data/models/day_plan_model.dart';
import 'package:mindtrip/features/ai_planner/data/models/plan_place_model.dart';

part 'plan_model.freezed.dart';
part 'plan_model.g.dart';

@freezed
abstract class PlanModel with _$PlanModel {
  const PlanModel._();

  const factory PlanModel({
    @JsonKey(name: 'accommodation', fromJson: _parseAccommodation)
    @Default([])
    List<PlanPlaceModel> accommodation,

    /// Days keyed by day number (1-based). Populated via custom fromJson.
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default({})
    Map<int, DayPlanModel> days,
  }) = _PlanModel;

  factory PlanModel.fromJson(Map<String, dynamic> json) =>
      _parsePlanModel(json);
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

List<PlanPlaceModel> _parseAccommodation(dynamic value) {
  if (value is! List) return [];
  return value
      .whereType<Map<String, dynamic>>()
      .map(PlanPlaceModel.fromJson)
      .toList();
}

/// Custom factory that first runs Freezed's generated fromJson, then manually
/// parses every `dayN` key from the raw JSON into the [days] map.
PlanModel _parsePlanModel(Map<String, dynamic> json) {
  // Parse accommodation via the generated code path.
  final accommodation = _parseAccommodation(json['accommodation']);

  // Parse every dayN entry dynamically.
  final days = <int, DayPlanModel>{};
  for (final entry in json.entries) {
    if (!entry.key.startsWith('day')) continue;
    final dayNumber = int.tryParse(entry.key.replaceFirst('day', ''));
    if (dayNumber == null) continue;
    final raw = entry.value;
    if (raw is Map<String, dynamic>) {
      days[dayNumber] = DayPlanModel.fromJson(raw);
    }
  }

  return PlanModel(accommodation: accommodation, days: days);
}
