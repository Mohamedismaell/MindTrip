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
    final collected = trip.collected;

    return GeneratePlanRequestModel(
      city: trip.city,
      days: collected?.days ?? trip.durationDays,
      budget: collected?.budget ?? trip.totalBudget,
      people: collected?.people ?? trip.people,
      interests: collected?.interests ?? const [],
      mustInclude: collected?.mustInclude.join(', '),
    );
  }
}
