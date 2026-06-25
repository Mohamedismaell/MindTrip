import 'package:equatable/equatable.dart';

/// Value object that mirrors the `collected` / `cardAnswers` fields
/// sent to the backend's `/api/v1/ai/chat` endpoint.
class CollectedPlannerData extends Equatable {
  const CollectedPlannerData({
    this.destination,
    this.days,
    this.budget,
    this.interests = const [],
    this.people,
    this.mustInclude = const [],
  });

  final String? destination;
  final int? days;
  final double? budget;
  final List<String> interests;
  final int? people;
  final List<String> mustInclude;

  /// Builds the `collected` map for the chat request body.
  Map<String, dynamic> toCollectedMap() => {
    if (destination != null) 'destination': destination,
    if (days != null) 'days': days,
    if (budget != null) 'budget': budget,
    if (interests.isNotEmpty) 'interests': interests,
    if (people != null) 'people': people,
    if (mustInclude.isNotEmpty) 'mustInclude': mustInclude,
  };

  /// Builds the `cardAnswers` map for the chat request body.
  Map<String, dynamic> toCardAnswersMap() => {
    if (destination != null) 'destination': destination,
    if (days != null) 'days': days,
    if (budget != null) 'budget': budget,
    if (interests.isNotEmpty) 'interests': interests,
    if (people != null) 'people': people,
    if (mustInclude.isNotEmpty) 'must_include': mustInclude,
  };

  @override
  List<Object?> get props => [
    destination,
    days,
    budget,
    interests,
    people,
    mustInclude,
  ];
}
