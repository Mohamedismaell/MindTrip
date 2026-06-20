import 'package:hive_ce_flutter/adapters.dart';
import 'package:mindtrip/features/search/domain/entity/recent_search_entity.dart';

part 'recent_search_model.g.dart';

@HiveType(typeId: 14)
class RecentSearchModel {
  @HiveField(0)
  final String query;
  @HiveField(1)
  final DateTime timestamp;

  RecentSearchModel({required this.query, required this.timestamp});

  factory RecentSearchModel.fromEntity(RecentSearchEntity entity) {
    return RecentSearchModel(query: entity.query, timestamp: entity.timestamp);
  }

  RecentSearchEntity toEntity() {
    return RecentSearchEntity(query: query, timestamp: timestamp);
  }
}
