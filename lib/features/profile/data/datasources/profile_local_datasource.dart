import 'dart:convert';
import 'package:mindtrip/core/database/cache/cache_helper.dart';
import 'package:mindtrip/features/profile/data/models/trip_review_model.dart';

abstract class ProfileLocalDatasource {
  Future<void> saveMyReviews(List<Map<String, dynamic>> reviews);
  Future<List<TripReviewModel>?> getMyReviews();
  Future<void> clearMyReviews();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  final CacheHelper _cacheHelper;
  static const String _reviewsKey = 'CACHED_MY_REVIEWS';

  ProfileLocalDatasourceImpl({required CacheHelper cacheHelper})
    : _cacheHelper = cacheHelper;

  @override
  Future<void> saveMyReviews(List<Map<String, dynamic>> reviews) async {
    await _cacheHelper.saveData(key: _reviewsKey, value: jsonEncode(reviews));
  }

  @override
  Future<List<TripReviewModel>?> getMyReviews() async {
    final String? reviewsJson = _cacheHelper.getDataString(key: _reviewsKey);
    if (reviewsJson != null) {
      final List<dynamic> decoded = jsonDecode(reviewsJson);
      return decoded.map((e) => TripReviewModel.fromJson(e)).toList();
    }
    return null;
  }

  @override
  Future<void> clearMyReviews() async {
    await _cacheHelper.removeData(key: _reviewsKey);
  }
}
