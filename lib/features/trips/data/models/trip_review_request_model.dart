import 'package:equatable/equatable.dart';

class TripReviewRequestModel extends Equatable {
  const TripReviewRequestModel({
    required this.rating,
    this.comment,
  });

  final int rating;
  final String? comment;

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      if (comment != null) 'comment': comment,
    };
  }

  @override
  List<Object?> get props => [rating, comment];
}
