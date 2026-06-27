import 'package:equatable/equatable.dart';

class TripReviewEntity extends Equatable {
  final String tripReviewId;
  final String tripId;
  final String destination;
  final double rating;
  final String comment;
  final DateTime createdAt;

  const TripReviewEntity({
    required this.tripReviewId,
    required this.tripId,
    required this.destination,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        tripReviewId,
        tripId,
        destination,
        rating,
        comment,
        createdAt,
      ];
}
