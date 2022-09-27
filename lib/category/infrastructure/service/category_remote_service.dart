import 'package:dio/dio.dart';
import 'package:flutter_crud/category/feat_category.dart';
import 'package:smf_core/smf_core.dart';

class CategoryRemoteService {
  final Dio _dio;

  CategoryRemoteService(this._dio);

  Future<Result<List<CategoryDto>>> getAllCategories() async {
    try {
      final response = await _dio.get('/category');

      if (response.statusCode == 200) {
        final jsonData = responseData(response);
        final body = DataBody.fromJson(jsonData).data as List<dynamic>;
        final categories = body.map((e) => CategoryDto.fromJson(e)).toList();
        return Result.withData(categories);
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
