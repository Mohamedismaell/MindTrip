import 'package:equatable/equatable.dart';
import 'package:mindtrip/core/shared/data/models/location_model.dart';

class TourPackageModel extends Equatable {
  final String id;
  final String title;
  final LocationModel location;
  final String imageUrl;
  final double price;
  final double rating;
  final int durationDays;

  const TourPackageModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.durationDays,
  });

  factory TourPackageModel.fromJson(Map<String, dynamic> json) {
    return TourPackageModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      location: LocationModel.fromJson(json['location']),
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      durationDays: json['durationDays'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location.toJson(),
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'durationDays': durationDays,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    location,
    imageUrl,
    price,
    rating,
    durationDays,
  ];
}
