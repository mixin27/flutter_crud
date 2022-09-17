import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

abstract class PostRepository {
  /// Get all posts.
  Future<Either<BlogFailure, PaginatedResult<List<PostModel>>>> getAllPosts(
      PostRequestParam param);

  /// Create post.
  Future<Either<BlogFailure, DomainResult<PostModel>>> createPost(
      {required String title,
      required String content,
      required String status,
      required String categoryId});
}
