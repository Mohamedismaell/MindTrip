// import 'package:ttproj/core/connections/result.dart';

// import 'package:ttproj/core/params/params.dart';

// import 'package:ttproj/features/templete/domain/entities/post_entitiy.dart';

// import '../../../../core/connections/network_info.dart';
// // import '../../../../core/errors/exceptions.dart';
// // import '../../../../core/errors/failure.dart';
// // import '../../../../core/params/params.dart';
// import '../../domain/repositories/news_repository.dart';
// import '../datasources/news_remote_data_source.dart';

// class NewsRepositoryImpl extends NewsRepository {
//   final NetworkInfo networkInfo;
//   final NewsRemoteDataSource remoteDataSource;
//   NewsRepositoryImpl({
//     required this.remoteDataSource,
//     required this.networkInfo,
//   });

//   @override
//   Future<Result<List<PostEntity>>> getNewsByCategory({
//     required NewsCategoryParams params,
//   }) {
//     // TODO: implement getNewsByCategory
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<List<PostEntity>>> getNewsByDate() {
//     // TODO: implement getNewsByDate
//     throw UnimplementedError();
//   }
//   //!Filtered Posts with Category
//   // @override
//   // Future<Result<List<PostEntity>>> getNewsByCategory({
//   //   required NewsCategoryParams params,
//   // }) async {
//   //   try {
//   //     final remoteNews = await remoteDataSource
//   //         .getNewsByCategory(params);
//   //     return Result.ok(remoteNews.posts ?? []);
//   //   } on ServerExceptions catch (e) {
//   //     return Result.error(
//   //       Failure(errMessage: e.errorModel.errorMessage),
//   //     );
//   //   }
//   // }
// }
