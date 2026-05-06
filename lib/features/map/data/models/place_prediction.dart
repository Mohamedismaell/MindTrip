import 'package:equatable/equatable.dart';

class PlacePrediction extends Equatable {
  final String placeId;
  final String primaryText;
  final String secondaryText;
  final String fullText;

  const PlacePrediction({
    required this.placeId,
    required this.primaryText,
    required this.secondaryText,
    required this.fullText,
  });

  factory PlacePrediction.fromJson(Map<String, dynamic> json) {
    return PlacePrediction(
      placeId: json['place_id'] ?? '',
      primaryText: json['structured_formatting']?['main_text'] ?? json['description'] ?? '',
      secondaryText: json['structured_formatting']?['secondary_text'] ?? '',
      fullText: json['description'] ?? '',
    );
  }

  @override
  List<Object?> get props => [placeId, primaryText, secondaryText, fullText];
}
