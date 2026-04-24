import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String id;
  final String userId;
  final String placeId;
  final String location;
  final double rating;
  final String title;
  final String body;
  final DateTime? createdAt;

  const ReviewModel({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.location,
    required this.rating,
    required this.title,
    required this.body,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      placeId: json['placeId'] ?? '',
      location: json['location'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'placeId': placeId,
      'location': location,
      'rating': rating,
      'title': title,
      'body': body,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    placeId,
    location,
    rating,
    title,
    body,
    createdAt,
  ];
}
