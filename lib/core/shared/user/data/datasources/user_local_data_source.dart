// import 'package:hive_ce_flutter/adapters.dart';
// import 'package:news_app/core/shared/data/datasources/news_data_source.dart';
// import 'package:news_app/core/shared/data/models/news_response_dto.dart';

// class NewsLocalDataSource implements NewsDataSource {
//   final Box<NewsResponseDto> newsBox;

//   String _categoryKey(String category) => 'category_$category';

//   NewsLocalDataSource({required this.newsBox});

//   @override
//   NewsResponseDto? getCategoryNews(String category) {
//     return newsBox.get(_categoryKey(category));
//   }

//   @override
//   NewsResponseDto? getTopHeadlinesNews() {
//     return newsBox.get('top_headlines');
//   }

//   @override
//   Future<void> saveCategoryNews(String category, NewsResponseDto value) async {
//     await newsBox.put(_categoryKey(category), value);
//   }

//   @override
//   Future<void> saveTopHeadlinesNews(NewsResponseDto value) async {
//     await newsBox.put('top_headlines', value);
//   }
// }
