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
      if (interests != null && interests!.isNotEmpty) 'interests': interests,

      if (minRating != null) 'min_rating': minRating,
      if (maxRating != null) 'max_rating': maxRating,

      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,

      if (hiddenGem != null) 'hidden_gem': hiddenGem,

      if (sortBy != null) 'sort_by': sortBy,
      if (order != null) 'order': order,

      'page': page,
      'limit': limit,
    };
  }
}
