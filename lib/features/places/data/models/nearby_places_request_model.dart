class NearbyPlacesRequestModel {
  final double userLat;
  final double userLng;
  final double? radiusKm;
  final Map<String, dynamic>? filters;
  final int page;
  final int limit;

  const NearbyPlacesRequestModel({
    required this.userLat,
    required this.userLng,
    this.radiusKm = 10,
    this.filters,
    this.page = 1,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      'userLat': userLat,
      'userLng': userLng,
      if (radiusKm != null) 'radiusKm': radiusKm,
      if (filters != null && filters!.isNotEmpty) 'filters': filters,
      'page': page,
      'limit': limit,
    };
  }
}
