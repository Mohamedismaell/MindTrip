// import 'dart:convert';
// import '../../../../core/database/cache/cache_helper.dart';
// import '../../../../core/errors/exceptions.dart';
// import '../models/news_model.dart';

// class TemplateLocalDataSource {
//   final CacheHelper cache;
//   final String key = "CachedTemplate";
//   TemplateLocalDataSource({required this.cache});

//   cacheTemplate(NewsModel? templateToCache) {
//     if (templateToCache != null) {
//       cache.saveData(
//         key: key,
//         value: json.encode(templateToCache.toJson()),
//       );
//     } else {
//       throw CacheException(
//         errorMessage: "No Internet Connection",
//       );
//     }
//   }

//   Future<NewsModel> getLastTemplate() {
//     final jsonString = cache.getDataString(key: key);

//     if (jsonString != null) {
//       return Future.value(
//         NewsModel.fromJson(json.decode(jsonString)),
//       );
//     } else {
//       throw CacheException(
//         errorMessage: "No Internet Connection",
//       );
//     }
//   }
// }
