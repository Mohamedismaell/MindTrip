class PaginatedResponse<T> {
  final int total;
  final int page;
  final int limit;
  final int totalPages;
  final List<T> results;

  PaginatedResponse({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.results,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse<T>(
      total: (json['total'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((e) => fromJsonT(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
