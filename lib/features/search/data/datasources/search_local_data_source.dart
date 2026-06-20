import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/core/database/cache/app_hive.dart';
import 'package:mindtrip/features/search/data/models/recent_search_model.dart';

abstract class SearchLocalDataSource {
  Future<List<RecentSearchModel>> getRecentSearches();
  Future<void> saveRecentSearch(RecentSearchModel query);
  Future<void> clearRecentSearches();
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  SearchLocalDataSourceImpl();

  final Box<RecentSearchModel> _recentSearchBox = AppHive.recentSearchBox;

  @override
  Future<List<RecentSearchModel>> getRecentSearches() async {
    final searches = _recentSearchBox.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return searches;
  }

  @override
  Future<void> saveRecentSearch(RecentSearchModel query) async {
    // Update existing search or insert a new one.
    await _recentSearchBox.put(query.query.toLowerCase(), query);

    // Keep only the latest 10 searches.
    final entries = _recentSearchBox.toMap().entries.toList()
      ..sort((a, b) => b.value.timestamp.compareTo(a.value.timestamp));

    for (final entry in entries.skip(10)) {
      await _recentSearchBox.delete(entry.key);
    }
  }

  @override
  Future<void> clearRecentSearches() {
    return _recentSearchBox.clear();
  }
}
