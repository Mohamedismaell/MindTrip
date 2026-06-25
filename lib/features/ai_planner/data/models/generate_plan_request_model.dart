import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mindtrip/features/trips/domain/entities/trip.dart';

part 'generate_plan_request_model.freezed.dart';
part 'generate_plan_request_model.g.dart';

@freezed
abstract class GeneratePlanRequestModel with _$GeneratePlanRequestModel {
  const factory GeneratePlanRequestModel({
    required String city,
    required int days,
    required int budget,
    required int people,
    required List<String> interests,
    String? mustInclude,
  }) = _GeneratePlanRequestModel;

  factory GeneratePlanRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GeneratePlanRequestModelFromJson(json);

  factory GeneratePlanRequestModel.fromTrip(Trip trip) {
    return GeneratePlanRequestModel(
      city: trip.destination,
      days: trip.durationDays,
      budget: trip.totalBudget,
      people: trip.people,
      interests: trip.interests,
      mustInclude: null,
    );
  }
}
