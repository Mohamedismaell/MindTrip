import 'package:mindtrip/core/shared/models/interest_categories.dart';

class RecommendationPlacesRequestModel {
  final List<String> selectedCategories;
  final Map<String, dynamic>? filters;
  final int page;
  final int limit;
  final int? seed;
  final int poolSize;

  RecommendationPlacesRequestModel({
    required this.selectedCategories,
    this.filters,
    this.page = 1,
    this.limit = 10,
    this.seed,
    this.poolSize = 50,
  });

  Map<String, dynamic> toJson() {
    return {
      'selectedCategories': selectedCategories
          .map((e) => InterestCategories.stripEmoji(e))
          .toList(),
      if (filters != null && filters!.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
      if (seed != null) 'seed': seed,
      'poolSize': poolSize,
    };
  }
}
