import 'package:mindtrip/core/shared/models/interest_categories.dart';

class GetPlacesRequestModel {
  final List<String>? city;
  final List<String>? category;
  final List<String>? interests;

  final double? minRating;
  final double? maxRating;

  final int? minPrice;
  final int? maxPrice;

  final bool? hiddenGem;

  final String? sortBy;
  final String? order;

  final int page;
  final int limit;

  const GetPlacesRequestModel({
    this.city,
    this.category,
    this.interests,
    this.minRating,
    this.maxRating,
    this.minPrice,
    this.maxPrice,
    this.hiddenGem,
    this.sortBy,
    this.order,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      if (city != null && city!.isNotEmpty) 'city': city,
      if (category != null && category!.isNotEmpty) 'category': category,
      if (interests != null && interests!.isNotEmpty)
        'interests':
            interests!.map((e) => InterestCategories.stripEmoji(e)).toList(),

      if (minRating != null) 'minRating': minRating,
      if (maxRating != null) 'maxRating': maxRating,

      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,

      if (hiddenGem != null) 'hiddenGem': hiddenGem,

      if (sortBy != null) 'sortBy': sortBy,
      if (order != null) 'order': order,

      'page': page,
      'limit': limit,
    };
  }
}
