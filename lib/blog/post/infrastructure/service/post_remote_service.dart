import 'package:dio/dio.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:flutter_crud/core/feat_core.dart';
import 'package:smf_core/smf_core.dart';

class PostRemoteService {
  final Dio _dio;

  PostRemoteService(this._dio);

  /// Get all posts.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<PaginatedPostDto>> getAllPosts({
    required PostRequestParamDto param,
  }) async {
    try {
      final response = await _dio.get(
        AppConsts.apiEndpoints.post,
        queryParameters: param.toJson(),
      );

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final data = ResponseDto.fromJson(jsonData);
        final paginatedPost = PaginatedPostDto.fromJson(data.data);
        return Result.withData(paginatedPost);
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

  /// Create post.
  ///
  /// Throw [RestApiException] when the request failed.
  Future<Result<PostDto>> createPost({
    required String title,
    required String content,
    required String status,
    required String categoryId,
  }) async {
    try {
      final response = await _dio.post(
        AppConsts.apiEndpoints.post,
        data: {
          "postTitle": title,
          "postContent": content,
          "postStatus": status,
          "postCategoryID": categoryId,
        },
      );

      if (response.statusCode == AppConsts.status.ok) {
        final jsonData = responseData(response);
        final data = ResponseDto.fromJson(jsonData);
        final createdPost = PostDto.fromJson(data.data);
        return Result.withData(createdPost);
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
