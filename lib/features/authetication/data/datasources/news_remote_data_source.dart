// import 'package:news_app/core/params/params.dart';

import '../../../../core/database/api/api_consumer.dart';
// import '../../../../core/database/api/end_points.dart';
// import '../models/news_model.dart';

class NewsRemoteDataSource {
  final ApiConsumer api;

  NewsRemoteDataSource({required this.api});
  // Future<NewsModel> getNewsByCategory(
  //   NewsCategoryParams params,
  // ) async {
  //   // print(
  //   //   "🔍 GET Request URL: ${EndPoints.baseUrl}/${EndPoints.news}",
  //   // );
  //   // print(
  //   //   "🔍 Query Params: ${{'q': params.category != null ? EndPoints.formatCategoryQuery(params.category!) : EndPoints.defaultCategory, 'token': EndPoints.token}}",
  //   // );
  //   // print(
  //   //   'Looooooooooook here${Uri.encodeComponent('category:"politics"')}',
  //   // );
  //   final categoryQuery = params.category != null
  //       ? EndPoints.formatCategoryQuery(params.category!)
  //       : EndPoints.formatCategoryQuery(
  //           EndPoints.defaultCategory,
  //         );
  //   // print('🔍 Query: $categoryQuery');
  //   final newsCategoryRes = await api.get(
  //     EndPoints.news,
  //     queryParameters: {
  //       'token': EndPoints.token,
  //       'q': categoryQuery,
  //     },
  //   );
  //   return NewsModel.fromJson(newsCategoryRes);
  // }
}
