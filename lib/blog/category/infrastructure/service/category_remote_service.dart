import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_crud/blog/category/feat_category.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:smf_core/smf_core.dart';

class CategoryRemoteService {
  final Dio _dio;

  CategoryRemoteService(this._dio);

  /// Get all categories.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<List<CategoryDto>>> getAllCategories() async {
    try {
      final response = await _dio.get(AppConsts.apiEndpoints.category);

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final data = ResponseDto.fromJson(jsonData).data as List<dynamic>;
        final categories = data.map((e) => CategoryDto.fromJson(e)).toList();
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

  /// Create a category.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<CategoryDto>> createCategory({
    required String name,
  }) async {
    try {
      final response = await _dio.post(
        AppConsts.apiEndpoints.category,
        data: {
          "PostCategoryName": name,
        },
      );

      if (response.statusCode == AppConsts.status.ok) {
        final data = ResponseDto.fromJson(responseData(response)).data;
        final category = CategoryDto.fromJson(data);
        return Result.withData(category);
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

  /// Update a category by id.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<CategoryDto>> updateCategory({
    required String id,
    required String name,
  }) async {
    try {
      final response = await _dio.put(
        AppConsts.apiEndpoints.category,
        data: {
          "postCategoryID": id,
          "PostCategoryName": name,
        },
      );

      if (response.statusCode == AppConsts.status.ok) {
        final data = ResponseDto.fromJson(responseData(response)).data;
        final category = CategoryDto.fromJson(data);
        return Result.withData(category);
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

  /// Delete a category by id.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<Unit>> deleteCategoryById({
    required String id,
  }) async {
    try {
      final response = await _dio.delete(
        AppConsts.apiEndpoints.category,
        queryParameters: {
          "PostCategoryID": id,
        },
      );

      if (response.statusCode == AppConsts.status.ok) {
        return const Result.withData(unit);
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
