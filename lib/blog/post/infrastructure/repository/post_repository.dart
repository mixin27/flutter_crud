import 'package:dartz/dartz.dart';
import 'package:flutter_crud/blog/feat_blog.dart';
import 'package:smf_core/smf_core.dart';

abstract class PostRepository {
  /// Get all posts.
  Future<Either<BlogFailure, PaginatedResult<List<PostModel>>>> getAllPosts(
      PostRequestParam param);

  /// Get single post by id.
  Future<Either<BlogFailure, DomainResult<PostModel>>> getPostById(String id);

  /// Get all posts by login user.
  Future<Either<BlogFailure, DomainResult<List<PostModel>>>>
      getAllPostsByUser();

  /// Create post.
  Future<Either<BlogFailure, DomainResult<PostModel>>> createPost(
      {required String title,
      required String content,
      required String status,
      required String categoryId});

  /// Update post by id.
  Future<Either<BlogFailure, DomainResult<PostModel>>> updatePost(
      {required String id,
      required String title,
      required String content,
      required String status,
      required String categoryId});

  /// Delete post by id.
  Future<Either<BlogFailure, DomainResult<Unit>>> deletePost(
      {required String id});

  /// Delete multiple posts by id.
  Future<Either<BlogFailure, DomainResult<Unit>>> deleteMultiplePosts(
      {required List<String> ids});
}
