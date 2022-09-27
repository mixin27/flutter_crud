import 'package:dio/dio.dart';
import 'package:flutter_crud/article/feat_article.dart';
import 'package:smf_core/smf_core.dart';

class ArticleRemoteService {
  final Dio _dio;

  ArticleRemoteService(this._dio);

  Future<Result<PaginatedArticleDto>> getAllArticles() async {
    try {
      final response = await _dio.get('/post');

      if (response.statusCode == 200) {
        final jsonData = responseData(response);
        final body = DataBody.fromJson(jsonData);
        final paginatedArticle = PaginatedArticleDto.fromJson(body.data);
        return Result.withData(paginatedArticle);
      } else {
        throw RestApiException(response.statusCode, response.statusMessage);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const Result.noConnection();
      } else if (e.error != null) {
        throw RestApiException(
          e.response?.statusCode,
          e.response?.statusMessage,
        );
      } else {
        rethrow;
      }
    }
  }
}
