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
    final resultsData = json['results'];
    List<dynamic> items = [];

    if (resultsData is List) {
      items = resultsData;
    } else if (resultsData is Map && resultsData['items'] is List) {
      items = resultsData['items'];
    }

    return PaginatedResponse<T>(
      total: (json['total'] as num?)?.toInt() ?? 0,
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
      results:
          items.map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
    );
  }
}

extension PaginatedResponseExtension<T> on PaginatedResponse<T> {
  PaginatedResponse<R> map<R>(R Function(T) mapper) {
    return PaginatedResponse<R>(
      total: total,
      page: page,
      limit: limit,
      totalPages: totalPages,
      results: results.map(mapper).toList(),
    );
  }
}
