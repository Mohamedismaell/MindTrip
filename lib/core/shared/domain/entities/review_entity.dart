import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String userId;
  final String placeId;
  final String location;
  final double rating;
  final String title;
  final String body;
  final DateTime? createdAt;

  const ReviewEntity({
    required this.id,
    required this.userId,
    required this.placeId,
    required this.location,
    required this.rating,
    required this.title,
    required this.body,
    this.createdAt,
  });

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
