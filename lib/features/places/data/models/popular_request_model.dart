class PopularRequestModel {
  final Map<String, dynamic>? filters;
  final int page;
  final int limit;
  final int? seed;
  // final int poolSize;

  PopularRequestModel({
    this.filters,
    this.page = 1,
    this.limit = 10,
    this.seed = 0,
    // this.poolSize = 150,
  });

  Map<String, dynamic> toJson() {
    return {
      if (filters != null && filters!.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
      if (seed != null) 'seed': seed,
      // 'pool_size': poolSize,
    };
  }
}
