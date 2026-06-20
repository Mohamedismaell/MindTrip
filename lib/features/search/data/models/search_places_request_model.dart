class SearchPlacesRequestModel {
  final String? query;
  final Map<String, dynamic>? filters;
  final int page;
  final int limit;

  SearchPlacesRequestModel({
    this.query,
    this.filters,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      if (query != null && query!.isNotEmpty) 'query': query,
      if (filters != null && filters!.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
    };
  }
}
