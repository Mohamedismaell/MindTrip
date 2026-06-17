class RecommendationRequestModel {
  final List<String> selectedCategories;
  final Map<String, dynamic>? filters;
  final int page;
  final int limit;
  final int? seed;
  final int poolSize;

  RecommendationRequestModel({
    required this.selectedCategories,
    this.filters,
    this.page = 1,
    this.limit = 10,
    this.seed,
    this.poolSize = 150,
  });

  Map<String, dynamic> toJson() {
    return {
      'selected_categories': selectedCategories,
      if (filters != null && filters!.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
      if (seed != null) 'seed': seed,
      'pool_size': poolSize,
    };
  }
}
