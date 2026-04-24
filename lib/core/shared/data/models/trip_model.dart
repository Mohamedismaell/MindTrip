import 'package:equatable/equatable.dart';
import 'place_model.dart';

class TripModel extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final List<PlaceModel> places;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isFavorite;
  final bool isAiGenerated;

  const TripModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.places = const [],
    this.startDate,
    this.endDate,
    this.isFavorite = false,
    this.isAiGenerated = false,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      places:
          (json['places'] as List<dynamic>?)
              ?.map((e) => PlaceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isFavorite: json['isFavorite'] ?? false,
      isAiGenerated: json['isAiGenerated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'places': places.map((e) => e.toJson()).toList(),
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isFavorite': isFavorite,
      'isAiGenerated': isAiGenerated,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    imageUrl,
    places,
    startDate,
    endDate,
    isFavorite,
    isAiGenerated,
  ];
}
